import XCTest
@testable import Advent

final class Day11Test: XCTestCase, IBaseTest {
    let dataTest = """
    125 17
    """

    func testPart1() throws {
        check(testValue: 55312, day11part1)
    }

    func testPart2() throws {
        check(testValue: 65601038650482, day11part2)
    }
}
