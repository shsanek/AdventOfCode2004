import Foundation

extension String {
    var oneSpace: String {
        split(separator: " ").filter({ !$0.isEmpty }).joined(separator: " ")
    }

    var rows: [String] {
        split(separator: "\n").map { String($0) }.filter {
            !$0.removeSpace.isEmpty
        }
    }

    var removeSpace: String {
        replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }
}

extension String {
    var toArray: [String] {
        map { String($0) }
    }

    var toCharterArray: [Character] {
        map { $0 }
    }
}
