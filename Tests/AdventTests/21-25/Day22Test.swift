import XCTest
@testable import Advent

final class Day22Test: XCTestCase, IBaseTest {
    let dataTest = """
    1
    10
    100
    2024
    """

    func testPart1() throws {
        check(testValue: 37327623, day22part1)
    }

    func testPart2() throws {
        check(testValue: 24, day22part2)
    }
}
