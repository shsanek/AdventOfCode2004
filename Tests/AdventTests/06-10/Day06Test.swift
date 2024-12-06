import XCTest
@testable import Advent

final class Day06Test: XCTestCase, IBaseTest {
    let dataTest = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

    func testPart1() throws {
        check(testValue: 41, day06part1)
    }

    func testPart2() throws {
        check(testValue: 6, day06part2)
    }
}
