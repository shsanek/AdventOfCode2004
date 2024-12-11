import Foundation

func day11part1() -> Int {
    var input = DataLoader.load().split(separator: " ").map({ String($0).removeSpace }).filter({ !$0.isEmpty }).map({ Int64($0)! })
    for _ in 0..<25 {
        var i = 0
        while i < input.count {
            if input[i] == 0 {
                input[i] = 1
                i += 1
            } else if String("\(input[i])").count % 2 == 0 {
                let valueString = String("\(input[i])")
                let valueA = Int64(valueString.prefix(valueString.count / 2))!
                let valueB = Int64(valueString.suffix(valueString.count / 2))!
                input[i] = valueA
                input.insert(valueB, at: i + 1)
                i += 2
            } else {
                input[i] *= 2024
                i += 1
            }
        }
    }
    return input.count
}

func day11part2() -> Int {
    class Chain {
        let value: Int64

        private lazy var subchain: [Chain] = chains()
        private var nextCountCache: [Int: Int] = [:]

        init(_ value: Int64) {
            self.value = value
        }

        static var storage = [Int64: Chain]()

        static func getChain(for value: Int64) -> Chain {
            if let chain = Self.storage[value] {
                return chain
            }
            let chain = Chain(value)
            Self.storage[value] = chain
            return chain
        }

        func chains() -> [Chain] {
            let res: [Chain]
            if value == 0 {
                res = [Self.getChain(for: 1)]
            } else if String("\(value)").count % 2 == 0 {
                let valueString = String("\(value)")
                let valueA = Int64(valueString.prefix(valueString.count / 2))!
                let valueB = Int64(valueString.suffix(valueString.count / 2))!
                res = [Self.getChain(for: valueA), Self.getChain(for: valueB)]
            } else {
                res = [Self.getChain(for: value * 2024)]
            }
            return res
        }

        func levelValue(_ count: Int) -> Int {
            if let cached = nextCountCache[count] {
                return cached
            }
            guard count > 0 else { return 1 }
            let result = subchain.reduce(0, { $0 + $1.levelValue(count - 1) })
            nextCountCache[count] = result
            return result
        }
    }

    let input = DataLoader.load()
        .split(separator: " ")
        .map({ String($0).removeSpace })
        .filter({ !$0.isEmpty })
        .map({ Chain.getChain(for: Int64($0)!) })

    var result = 0
    for chain in input {
        result += chain.levelValue(75)
    }
    return result
}

