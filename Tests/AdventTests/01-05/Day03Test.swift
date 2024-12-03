import XCTest
@testable import Advent

final class Day03Test: XCTestCase, IBaseTest {
    let dataTest = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """

    func testPart1() throws {
        check(testValue: 161, day03part1)
    }

    func testPart2() throws {
        check(
            dataTest: "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))",
            testValue: 48,
            day03part2
        )
    }
}
