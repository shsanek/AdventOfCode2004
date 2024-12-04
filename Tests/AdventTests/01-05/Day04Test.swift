import XCTest
@testable import Advent

final class Day04Test: XCTestCase, IBaseTest {
    let dataTest = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    func testPart1() throws {
        check(testValue: 18, day04part1)
    }

    func testPart2() throws {
        check(testValue: 9, day04part2)
    }
}
