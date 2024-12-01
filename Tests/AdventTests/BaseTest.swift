import XCTest
@testable import Advent

protocol IBaseTest {
    var dataTest: String { get }
}

enum TestValue: ExpressibleByIntegerLiteral {
    case unowned
    case number(value: Int)

    init(integerLiteral value: IntegerLiteralType) {
        self = .number(value: value)
    }
}

extension IBaseTest {
    func check(
        testValue: TestValue,
        _ block: () -> Int,
        file: StaticString = #file,
        line: UInt = #line,
        function: StaticString = #function
    ) {
        guard case .number(let value) = testValue else {
            XCTAssert(false, "use real value from task", file: file, line: line)
            return
        }
        DataLoader.test(data: dataTest) {
            XCTAssertEqual(block(), value, file: file, line: line)
        }
        print("[T] \(function): ", block())
    }
}
