public protocol KeyPathIterable {
    static var allKeyPaths: [PartialKeyPath<Self>] { get }
}
