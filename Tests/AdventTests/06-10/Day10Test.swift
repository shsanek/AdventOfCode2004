import XCTest
@testable import Advent

final class Day10Test: XCTestCase, IBaseTest {
    let dataTest = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """

    func testPart1() throws {
        check(testValue: 36, day10part1)
    }

    func testPart2() throws {
        check(testValue: 81, day10part2)
    }
}
