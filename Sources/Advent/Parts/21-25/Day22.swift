import Foundation

func day22part1() -> Int {
    let input = DataLoader.load().rows.map({ Int($0)! })
    var result: Int = 0
    for number in input {
        var step0 = number
        for _ in 0..<2000 {
            let step1 = ((step0 * 64) ^ step0) % 16777216
            let step2 = ((step1 / 32) ^ step1) % 16777216
            let step3 = ((step2 * 2048) ^ step2) % 16777216
            step0 = step3
        }
        result += step0
    }

    return result
}

func day22part2() -> Int {
    let input = DataLoader.load().rows.map({ Int($0)! })
    var result: Int = 0
    var sums: [[Int]: Int] = [:]
    for number in input {
        var step0 = number
        var fullKey: [Int] = [number % 10]
        var firstKeys: Set<[Int]> = []
        for _ in 0..<2000 {
            let step1 = ((step0 * 64) ^ step0) % 16777216
            let step2 = ((step1 / 32) ^ step1) % 16777216
            let step3 = ((step2 * 2048) ^ step2) % 16777216
            let oldPrice = step0 % 10
            let newPrice = step3 % 10
            step0 = step3
            fullKey.append(newPrice - oldPrice)
            if fullKey.count > 4 {
                fullKey.removeFirst()
            }
            if fullKey.count == 4, !firstKeys.contains(fullKey) {
                firstKeys.insert(fullKey)
                sums[fullKey, default: 0] += newPrice
            }
        }
        result += step0
    }

    return sums.values.max()!
}
