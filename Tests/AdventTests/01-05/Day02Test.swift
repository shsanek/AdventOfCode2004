import XCTest
@testable import Advent

final class Day02Test: XCTestCase, IBaseTest {
    let dataTest = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    func testPart1() throws {
        check(testValue: 2, day02part1)
    }

    func testPart2() throws {
        check(testValue: 4, day02part2)
    }
}
