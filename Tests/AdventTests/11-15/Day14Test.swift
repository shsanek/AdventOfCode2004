import XCTest
@testable import Advent

final class Day14Test: XCTestCase, IBaseTest {
    let dataTest = """
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
    """

    func testPart1() throws {
        check(testValue: 12, day14part1)
    }

    func testPart2() throws {
        check(testValue: 0, day14part2)
    }
}
