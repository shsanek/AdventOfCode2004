import XCTest
@testable import Advent

final class Day18Test: XCTestCase, IBaseTest {
    let dataTest = """
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
    """

    func testPart1() throws {
        check(testValue: 22, day18part1)
    }

    func testPart2() throws {
        check(testValue: "6,1", day18part2)
    }
}
