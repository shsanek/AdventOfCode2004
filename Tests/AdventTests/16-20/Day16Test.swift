import XCTest
@testable import Advent

final class Day16Test: XCTestCase, IBaseTest {
    let dataTest = """
    ###############
    #.......#....E#
    #.#.###.#.###.#
    #.....#.#...#.#
    #.###.#####.#.#
    #.#.#.......#.#
    #.#.#####.###.#
    #...........#.#
    ###.#.#####.#.#
    #...#.....#.#.#
    #.#.#.###.#.#.#
    #.....#...#.#.#
    #.###.#.#.#.#.#
    #S..#.....#...#
    ###############
    """

    func testPart1() throws {
        check(testValue: 7036, day16part1)
    }

    func testPart2() throws {
        check(testValue: 45, day16part2)
    }
}
