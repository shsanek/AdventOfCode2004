import XCTest
@testable import Advent

final class Day20Test: XCTestCase, IBaseTest {
    let dataTest = """
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
    """

    func testPart1() throws {
        check(testValue: 1, day20part1)
    }

    func testPart2() throws {
        check(testValue: 86, day20part2)
    }
}
