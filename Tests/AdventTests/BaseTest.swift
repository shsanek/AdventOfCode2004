import XCTest
@testable import Advent

protocol IBaseTest {
    var dataTest: String { get }
}

enum TestValue: ExpressibleByIntegerLiteral, ExpressibleByStringLiteral {
    case unowned
    case data(value: String)

    init(integerLiteral value: IntegerLiteralType) {
        self = .data(value: "\(value)")
    }


    init(stringLiteral value: StringLiteralType) {
        self = .data(value: value)
    }
}

extension IBaseTest {
    func check(
        dataTest: String? = nil,
        checkAllDate: Int? = nil,
        testValue: TestValue,
        _ block: () -> Int,
        file: StaticString = #file,
        line: UInt = #line,
        function: StaticString = #function
    ) {
        guard case .data(let value) = testValue else {
            XCTAssert(false, "use real value from task", file: file, line: line)
            return
        }
        DataLoader.test(data: dataTest ?? self.dataTest) {
            XCTAssertEqual("\(block())", value, file: file, line: line)
        }
        let result = block()
        if let checkAllDate {
            XCTAssertEqual(block(), checkAllDate, file: file, line: line)
        }
        print("[T] \(function): ", result)
    }
}

extension IBaseTest {
    func check(
        dataTest: String? = nil,
        checkAllDate: String? = nil,
        testValue: TestValue,
        _ block: () -> String,
        file: StaticString = #file,
        line: UInt = #line,
        function: StaticString = #function
    ) {
        guard case .data(let value) = testValue else {
            XCTAssert(false, "use real value from task", file: file, line: line)
            return
        }
        DataLoader.test(data: dataTest ?? self.dataTest) {
            XCTAssertEqual("\(block())", value, file: file, line: line)
        }
        let result = block()
        if let checkAllDate {
            XCTAssertEqual(block(), checkAllDate, file: file, line: line)
        }
        print("[T] \(function): ", result)
    }
}
