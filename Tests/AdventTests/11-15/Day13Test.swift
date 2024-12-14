import XCTest
@testable import Advent

final class Day13Test: XCTestCase, IBaseTest {
    let dataTest = """
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400
    """

    func testPart1() throws {
        check(testValue: 280, day13part1)
    }

    func testPart2() throws {
        check(testValue: 0, day13part2)
    }
}
