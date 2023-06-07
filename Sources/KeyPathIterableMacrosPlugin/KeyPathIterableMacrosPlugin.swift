#if canImport(SwiftCompilerPlugin)
import SwiftSyntaxMacros
import SwiftCompilerPlugin

@main
struct KeyPathIterableMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        KeyPathIterableMacro.self
    ]
}
#endif
