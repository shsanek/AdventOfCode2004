import XCTest
@testable import Advent

final class Day19Test: XCTestCase, IBaseTest {
    let dataTest = """
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """

    func testPart1() throws {
        check(testValue: 6, day19part1)
    }

    func testPart2() throws {
        check(testValue: 16, day19part2)
    }
}
