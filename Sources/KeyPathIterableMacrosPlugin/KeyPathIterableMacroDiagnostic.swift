import SwiftSyntax
import SwiftDiagnostics

public enum KeyPathIterableMacroDiagnostic {
    case requiresStructEnumClassActor
}

extension KeyPathIterableMacroDiagnostic: DiagnosticMessage {
    func diagnose(at node: some SyntaxProtocol) -> Diagnostic {
        Diagnostic(node: Syntax(node), message: self)
    }

    public var message: String {
        switch self {
        case .requiresStructEnumClassActor:
            return "'KeyPathIterable' macro can only be applied to struct, class, actor, or enum."
        }
    }

    public var severity: DiagnosticSeverity { .error }

    public var diagnosticID: MessageID {
        MessageID(domain: "Swift", id: "KeyPathIterable.\(self)")
    }
}
