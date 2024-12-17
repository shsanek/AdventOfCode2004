import XCTest
@testable import Advent

final class Day17Test: XCTestCase, IBaseTest {
    let dataTest = """
    Register A: 729
    Register B: 0
    Register C: 0

    Program: 0,1,5,4,3,0
    """

    func testPart1() throws {
        check(testValue: 4635635210, day17part1)
    }

    func testPart2() throws {
        print("[T] \(day17part2())")
    }
}
