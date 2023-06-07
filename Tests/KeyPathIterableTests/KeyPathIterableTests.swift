import XCTest
@testable import KeyPathIterable

final class KeyPathIterableTests: XCTestCase {
    func testStructKeyPathIterable() throws {
        XCTAssertEqual(StructHoge.allKeyPath, [\.hoge, \.fuga, \.foo])

        let count = StructHoge.allKeyPath.compactMap { $0 as? WritableKeyPath<StructHoge, Int> }.count
        XCTAssertEqual(count, 2)
    }

    func testEnumKeyPathIterable() throws {
        XCTAssertEqual(EnumHoge.allKeyPath, [\.hoge, \.fuga])

        let count = EnumHoge.allKeyPath.compactMap { $0 as? WritableKeyPath<EnumHoge, Int> }.count
        XCTAssertEqual(count, 0)
    }

    func testClassKeyPathIterable() throws {
        XCTAssertEqual(ClassHoge.allKeyPath, [\.hoge, \.fuga, \.foo])

        let count = ClassHoge.allKeyPath.compactMap { $0 as? WritableKeyPath<ClassHoge, Int> }.count
        XCTAssertEqual(count, 2)
    }

    func testActorKeyPathIterable() throws {
        XCTAssertEqual(ActorHoge.allKeyPath, [\.hoge])

        let count = ActorHoge.allKeyPath.compactMap { $0 as? WritableKeyPath<ActorHoge, Int> }.count
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
