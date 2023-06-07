@attached(member, names: named(allKeyPath))
@attached(conformance)
public macro KeyPathIterable() = #externalMacro(module: "KeyPathIterableMacrosPlugin", type: "KeyPathIterableMacro")
