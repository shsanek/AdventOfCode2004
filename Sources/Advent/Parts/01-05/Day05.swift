import Foundation

func day05part1() -> Int {
    let input = DataLoader.load().split(separator: "\n\n")
    let rules = input[0].split(separator: "\n").map({ $0.split(separator: "|").map({ Int($0)! }) })
    let lists = input[1].split(separator: "\n").map({ $0.split(separator: ",").map({ Int($0)! }) })
    var result = 0
    for list in lists {
        var right = true
        for rule in rules {
            assert(rule.count == 2)
            let index1 = list.firstIndex(where: { $0 == rule[0] })
            let index2 = list.firstIndex(where: { $0 == rule[1] })
            assert(index1 != index2 || (index1 == nil && index2 == nil))
            if let index1, let index2, index2 < index1 {
                right = false
                break
            }
        }
        if right {
            assert(list.count % 2 == 1)
            let center = list[list.count / 2]
            result += center
        }
    }
    return result
}

func day05part2() -> Int {
    let input = DataLoader.load().split(separator: "\n\n")
    let rules = input[0].split(separator: "\n").map({ $0.split(separator: "|").map({ Int($0)! }) })
    let lists = input[1].split(separator: "\n").map({ $0.split(separator: ",").map({ Int($0)! }) })
    class NumberInfoList {
        let number: Int
        var nexts: [NumberInfoList] = []
        var loop: Bool = false

        lazy var allBig: Set<Int> = {
            var result = Set<Int>()
            assert(loop == false)
            loop = true
            for next in nexts {
                result.insert(next.number)
                result.formUnion(next.allBig)
            }
            return result
        }()

        init(number: Int) {
            self.number = number
        }
    }
    var result = 0
    for list in lists {
        var right = true
        for rule in rules {
            assert(rule.count == 2)
            let index1 = list.firstIndex(where: { $0 == rule[0] })
            let index2 = list.firstIndex(where: { $0 == rule[1] })
            assert(index1 != index2 || (index1 == nil && index2 == nil))
            if let index1, let index2, index2 < index1 {
                right = false
                break
            }
        }
        if !right {
            var numbers = [Int: NumberInfoList]()
            let numberSet = Set(list)
            for key in numberSet {
                numbers[key] = .init(number: key)
            }
            for key in numberSet {
                let number = numbers[key]!
                number.nexts = rules.filter { $0[0] == key }.compactMap { numbers[$0[1]] }
            }

            assert(list.count % 2 == 1)
            let list = list.sorted(by: { a, b in
                guard let number = numbers[a] else {
                    return false
                }
                return number.allBig.contains(b)
            })
            let center = list[list.count / 2]
            result += center
        }
    }
    return result
}
