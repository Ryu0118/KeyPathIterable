import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

fileprivate extension VariableDeclSyntax {
    var variableName: String? {
        bindings.first?.pattern.trimmed.description
    }
}

public struct KeyPathIterableMacro: MemberMacro {
    public static func expansion<
        Declaration: DeclGroupSyntax, Context: MacroExpansionContext
    >(
        of node: AttributeSyntax,
        providingMembersOf declaration: Declaration,
        in context: Context
    ) throws -> [DeclSyntax] {
        guard let decl = decodeExpansion(of: node, attachedTo: declaration, in: context) else {
            return []
        }

        let namespace = decl.identifier.text

        let keyPathPairs = declaration.memberBlock.members
            .compactMap { $0.decl.as(VariableDeclSyntax.self)}
            .filter {
                if decl.is(ActorDeclSyntax.self) {
                    return $0.modifiers?.contains { $0.name.text == "nonisolated" } ?? false
                } else {
                    return true
                }
            }
            .compactMap(\.variableName)
            .map { "\\.\($0)" }
            .joined(separator: ", ")

        let codeBlockItemList = try VariableDeclSyntax("static var allKeyPaths: [PartialKeyPath<\(raw: namespace)>]") {
            StmtSyntax("[\(raw: keyPathPairs)]")
        }
        .formatted()
        .description
        return ["\(raw: codeBlockItemList)"]
    }
}

extension KeyPathIterableMacro: ConformanceMacro {
    public static func expansion<Declaration, Context>(of node: AttributeSyntax, providingConformancesOf declaration: Declaration, in context: Context) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)] where Declaration : DeclGroupSyntax, Context : MacroExpansionContext {
        guard let declaration = decodeExpansion(of: node, attachedTo: declaration, in: context) else {
            return []
        }

        if let inheritedTypes = declaration.inheritanceClause?.inheritedTypeCollection,
           inheritedTypes.contains(where: { inherited in inherited.typeName.trimmedDescription == "KeyPathIterable" })
        {
            return []
        }

        return [("KeyPathIterable", nil)]
    }
}

public extension KeyPathIterableMacro {
    static func decodeExpansion(
        of attribute: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) -> (any NamespaceSyntax)? {
        if let structDecl = declaration.as(StructDeclSyntax.self) {
            return structDecl
        } else if let enumDecl = declaration.as(EnumDeclSyntax.self) {
            return enumDecl
        } else if let classDecl = declaration.as(ClassDeclSyntax.self) {
            return classDecl
        } else if let actorDecl = declaration.as(ActorDeclSyntax.self) {
            return actorDecl
        } else {
            context.diagnose(KeyPathIterableMacroDiagnostic.requiresStructEnumClassActor.diagnose(at: attribute))
            return nil
        }
    }
}
