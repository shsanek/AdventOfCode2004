import XCTest
@testable import Advent

final class Day09Test: XCTestCase, IBaseTest {
    let dataTest = """
    2333133121414131402
    """

    func testPart1() throws {
        check(testValue: 1928, day09part1)
    }

    func testPart2() throws {
        check(testValue: 2858, day09part2)
    }
}
