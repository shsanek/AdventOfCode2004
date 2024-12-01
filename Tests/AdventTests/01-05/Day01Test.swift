import XCTest
@testable import Advent

final class Day01Test: XCTestCase, IBaseTest {
    let dataTest = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    func testPart1() throws {
        check(testValue: 11, day01part1)
    }

    func testPart2() throws {
        check(testValue: 31, day01part2)
    }
}
