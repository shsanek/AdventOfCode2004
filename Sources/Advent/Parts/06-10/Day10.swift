import Foundation

func day10part1() -> Int {
    class Cell {
        let value: Int
        var count: Int
        var set: Set<String> = .init()

        init(value: Int, count: Int) {
            self.value = value
            self.count = count
        }
    }
    let input = DataLoader
        .load()
        .split(separator: "\n")
        .filter({ !String($0).removeSpace.isEmpty })
        .map({ String($0).toArray.map({ Cell(value: Int($0)!, count: 0) }) })

    let numbers = [8, 7, 6, 5, 4, 3, 2, 1, 0]
    for y in 0..<input.count {
        for x in 0..<input.count {
            if input[y, x]?.value == 9 {
                input[y, x]?.count = 1
                input[y, x]?.set.insert("\(y), \(x)")
            }
        }
    }

    for number in numbers {
        for y in 0..<input.count {
            for x in 0..<input.count {
                if input[y, x]?.value == number {
                    if input[y - 1, x]?.value == number + 1 {
                        input[y, x]!.count += input[y - 1, x]!.count
                        input[y, x]?.set.formUnion(input[y - 1, x]!.set)
                    }
                    if input[y, x - 1]?.value == number + 1 {
                        input[y, x]!.count += input[y, x - 1]!.count
                        input[y, x]?.set.formUnion(input[y, x - 1]!.set)
                    }
                    if input[y + 1, x]?.value == number + 1 {
                        input[y, x]!.count += input[y + 1, x]!.count
                        input[y, x]?.set.formUnion(input[y + 1, x]!.set)
                    }
                    if input[y, x + 1]?.value == number + 1 {
                        input[y, x]!.count += input[y, x + 1]!.count
                        input[y, x]?.set.formUnion(input[y, x + 1]!.set)
                    }
                    print("value\(number) y: \(y), x: \(x) \(input[y, x]!.count)")
                }
            }
        }
    }
    var result = 0

    for y in 0..<input.count {
        for x in 0..<input.count {
            if input[y, x]?.value == 0 {
                result += input[y, x]!.set.count
                print(input[y, x]!.set.count)
            }
        }
    }

    return result
}

func day10part2() -> Int {
    class Cell {
        let value: Int
        var count: Int

        init(value: Int, count: Int) {
            self.value = value
            self.count = count
        }
    }
    let input = DataLoader
        .load()
        .split(separator: "\n")
        .filter({ !String($0).removeSpace.isEmpty })
        .map({ String($0).toArray.map({ Cell(value: Int($0)!, count: 0) }) })

    let numbers = [8, 7, 6, 5, 4, 3, 2, 1, 0]
    for y in 0..<input.count {
        for x in 0..<input.count {
            if input[y, x]?.value == 9 {
                input[y, x]?.count = 1
            }
        }
    }

    for number in numbers {
        for y in 0..<input.count {
            for x in 0..<input.count {
                if input[y, x]?.value == number {
                    if input[y - 1, x]?.value == number + 1 {
                        input[y, x]!.count += input[y - 1, x]!.count
                    }
                    if input[y, x - 1]?.value == number + 1 {
                        input[y, x]!.count += input[y, x - 1]!.count
                    }
                    if input[y + 1, x]?.value == number + 1 {
                        input[y, x]!.count += input[y + 1, x]!.count
                    }
                    if input[y, x + 1]?.value == number + 1 {
                        input[y, x]!.count += input[y, x + 1]!.count
                    }
                    print("value\(number) y: \(y), x: \(x) \(input[y, x]!.count)")
                }
            }
        }
    }
    var result = 0

    for y in 0..<input.count {
        for x in 0..<input.count {
            if input[y, x]?.value == 0 {
                result += input[y, x]!.count
                print(input[y, x]!.count)
            }
        }
    }

    return result
}
