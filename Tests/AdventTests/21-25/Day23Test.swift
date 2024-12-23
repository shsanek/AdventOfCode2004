import XCTest
@testable import Advent

final class Day23Test: XCTestCase, IBaseTest {
    let dataTest = """
    kh-tc
    qp-kh
    de-cg
    ka-co
    yn-aq
    qp-ub
    cg-tb
    vc-aq
    tb-ka
    wh-tc
    yn-cg
    kh-ub
    ta-co
    de-co
    tc-td
    tb-wq
    wh-td
    ta-ka
    td-qp
    aq-cg
    wq-ub
    ub-vc
    de-ta
    wq-aq
    wq-vc
    wh-yn
    ka-de
    kh-ta
    co-tc
    wh-qp
    tb-vc
    td-yn
    """

    func testPart1() throws {
        check(testValue: 7, day23part1)
    }

    func testPart2() throws {
        check(testValue: "co,de,ka,ta", day23part2)
    }
}
