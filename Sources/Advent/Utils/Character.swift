enum Consts {
    static var numbersString = "0123456789"
    static var lowercaseSymbolsString = "qwertyuiopasdfghjklzxcvbnm"
    static var uppercaseSymbolsString = lowercaseSymbolsString.uppercased()
    static var symbolsString = lowercaseSymbolsString + uppercaseSymbolsString
}

extension Character {
    var isNumber: Bool {
        Consts.numbersString.contains(self)
    }

    var isLowercaseSymbol: Bool {
        Consts.lowercaseSymbolsString.contains(self)
    }

    var isUppercaseSymbol: Bool {
        Consts.uppercaseSymbolsString.contains(self)
    }

    var isSymbol: Bool {
        Consts.symbolsString.contains(self)
    }
}

extension Array where Element == Character {
    func getNumber(i: inout Int) -> Int? {
        var numberString: String = ""
        while i < count && self[i].isNumber {
            numberString += "\(self[i])"
            i += 1
        }
        if numberString.isEmpty {
            return nil
        }
        return Int(numberString)!
    }

    func checkSubstring(i: inout Int, shift: Int = 1, substring: String) -> Bool {
        let substring = substring.toCharterArray
        var j = 0
        while i + j < count && j < substring.count, self[i + j] == substring[j] {
            j += 1
        }
        if j == substring.count {
            i = i + j
            return true
        } else {
            i = i + shift
            return false
        }
    }
}
