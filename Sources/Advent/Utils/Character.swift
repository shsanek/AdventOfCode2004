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
