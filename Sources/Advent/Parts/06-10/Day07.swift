import Foundation

func day07part1() -> Int {
    struct Item {
        let result: Int
        let numbers: [Int]
    }
    let items = DataLoader.load().split(separator: "\n").map({
        let a = $0.split(separator: ":")
            .map({ 
                $0.split(separator: " ")
                    .map({ String($0).removeSpace })
                    .filter({ !$0.isEmpty })
                    .map({ Int($0)! })
            })
        assert(a.count == 2)
        return Item(result: a[0][0] , numbers: a[1])
    })
    func checkNumber(current: Int, target: Int, values: [Int], index: Int) -> Bool {
        guard current <= target else {
            return false
        }
        if index == values.count {
            return current == target
        }
        return  checkNumber(current: current + values[index], target: target, values: values, index: index + 1) ||
                checkNumber(current: current * values[index], target: target, values: values, index: index + 1)
    }
    var result = 0
    for item in items {
        if checkNumber(current: item.numbers[0], target: item.result, values: item.numbers, index: 1) {
            result += item.result
        }
    }
    return result
}

func day07part2() -> Int {
    struct Item {
        let result: Int
        let numbers: [Int]
    }
    let items = DataLoader.load().split(separator: "\n").map({
        let a = $0.split(separator: ":")
            .map({
                $0.split(separator: " ")
                    .map({ String($0).removeSpace })
                    .filter({ !$0.isEmpty })
                    .map({ Int($0)! })
            })
        assert(a.count == 2)
        return Item(result: a[0][0] , numbers: a[1])
    })
    func checkNumber(current: Int, target: Int, values: [Int], index: Int) -> Bool {
        guard current <= target else {
            return false
        }
        if index == values.count {
            return current == target
        }
        if let value = Int("\(current)" + "\(values[index])"),
           checkNumber(current: value, target: target, values: values, index: index + 1) {
            return true
        }
        return  checkNumber(current: current + values[index], target: target, values: values, index: index + 1) ||
                checkNumber(current: current * values[index], target: target, values: values, index: index + 1)
    }
    var result = 0
    for item in items {
        if checkNumber(current: item.numbers[0], target: item.result, values: item.numbers, index: 1) {
            result += item.result
        }
    }
    return result
}
