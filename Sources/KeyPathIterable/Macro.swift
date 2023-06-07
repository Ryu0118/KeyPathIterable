@attached(member, names: named(allKeyPaths))
@attached(conformance)
public macro KeyPathIterable() = #externalMacro(module: "KeyPathIterableMacrosPlugin", type: "KeyPathIterableMacro")
