import XCTest
@testable import Advent

final class Day12Test: XCTestCase, IBaseTest {
    let dataTest = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

    func testPart1() throws {
        check(testValue: 1930, day12part1)
    }

    func testPart2() throws {
        check(testValue: 1206, day12part2)
    }
}
