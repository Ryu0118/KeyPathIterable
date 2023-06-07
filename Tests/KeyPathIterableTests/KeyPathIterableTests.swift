import XCTest
import KeyPathIterable

final class KeyPathIterableTests: XCTestCase {
    func testStructKeyPathIterable() throws {
        XCTAssertEqual(StructHoge.allKeyPaths, [\.hoge, \.fuga, \.foo])

        let count = StructHoge.allKeyPaths.compactMap { $0 as? WritableKeyPath<StructHoge, Int> }.count
        XCTAssertEqual(count, 2)
    }

    func testEnumKeyPathIterable() throws {
        XCTAssertEqual(EnumHoge.allKeyPaths, [\.hoge, \.fuga])

        let count = EnumHoge.allKeyPaths.compactMap { $0 as? WritableKeyPath<EnumHoge, Int> }.count
        XCTAssertEqual(count, 0)
    }

    func testClassKeyPathIterable() throws {
        XCTAssertEqual(ClassHoge.allKeyPaths, [\.hoge, \.fuga, \.foo])

        let count = ClassHoge.allKeyPaths.compactMap { $0 as? WritableKeyPath<ClassHoge, Int> }.count
        XCTAssertEqual(count, 2)
    }

    func testActorKeyPathIterable() throws {
        XCTAssertEqual(ActorHoge.allKeyPaths, [\.hoge])

        let count = ActorHoge.allKeyPaths.compactMap { $0 as? WritableKeyPath<ActorHoge, Int> }.count
        XCTAssertEqual(count, 0)
    }


    @KeyPathIterable
    struct StructHoge {
        var hoge = 1
        var fuga = 2
        let foo = 1
    }

    @KeyPathIterable
    enum EnumHoge {
        var hoge: Int { 1 }
        var fuga: Int { 2 }
    }

    @KeyPathIterable
    final class ClassHoge {
        var hoge = 1
        var fuga = 2
        let foo = 1

        init() {}
    }

    @KeyPathIterable
    actor ActorHoge {
        nonisolated var hoge: Int { 1 }
        var fuga = 2
    }
}
