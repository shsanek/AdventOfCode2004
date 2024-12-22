import XCTest
@testable import Advent

final class Day21Test: XCTestCase, IBaseTest {
    let dataTest = """
    029A
    980A
    179A
    456A
    379A
    """

    func testPart1() throws {
        check(testValue: 126384, day21part1)
    }

    func testPart2() throws {
        check(testValue: 154115708116294, day21part2)
    }
}
