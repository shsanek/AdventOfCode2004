import XCTest
@testable import Advent

final class Day07Test: XCTestCase, IBaseTest {
    let dataTest = """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """

    func testPart1() throws {
        check(testValue: 3749, day07part1)
    }

    func testPart2() throws {
        check(testValue: 11387, day07part2)
    }
}
