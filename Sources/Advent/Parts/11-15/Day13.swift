import Foundation

func day13part1() -> Int {
    struct Puzzle {
        let a: Point
        let b: Point
        let result: Point
    }
    let input = DataLoader.load()
        .split(separator: "\n\n")
        .filter({ !String($0).removeSpace.isEmpty })
        .map { substring -> Puzzle in
            let row = substring.split(separator: "\n")
            assert(row.count == 3)
            assert(row[0].hasPrefix("Button A: X+"))
            assert(row[1].hasPrefix("Button B: X+"))
            assert(row[2].hasPrefix("Prize: X="))
            let handle = { (substring: Substring) -> Point in
                let sub = String(substring.split(separator: ":")[1])
                    .replacingOccurrences(of: "X", with: "")
                    .replacingOccurrences(of: "Y", with: "")
                    .replacingOccurrences(of: "+", with: "")
                    .replacingOccurrences(of: "=", with: "")
                    .split(separator: ",")
                let numbers = sub
                    .map({ String($0).removeSpace })
                    .filter({ !$0.isEmpty })
                    .map({ Int($0)! })
                assert(sub.count == 2)
                return .init(x: numbers[0], y: numbers[1])
            }
            return Puzzle(a: handle(row[0]), b: handle(row[1]), result: handle(row[2]))
        }

    var sum = 0
    for puzzle in input {
        for i in 0...100 {
            var result = 0
            for j in 0...100 {
                let pointer = puzzle.a * i + puzzle.b * j
                if pointer == puzzle.result {
                    result = 1
                    sum += i * 3 + j
                }
            }
            if result == 1 {
                break
            }
        }
    }

    return sum
}

import BigInt

func day13part2() -> Int {
    struct LongPoint {
        let x: BigInt
        let y: BigInt
    }

    struct Puzzle {
        let a: LongPoint
        let b: LongPoint
        let result: LongPoint
    }

    let input = DataLoader.load()
        .split(separator: "\n\n")
        .filter({ !String($0).removeSpace.isEmpty })
        .map { substring -> Puzzle in
            let row = substring.split(separator: "\n")
            assert(row.count == 3)
            assert(row[0].hasPrefix("Button A: X+"))
            assert(row[1].hasPrefix("Button B: X+"))
            assert(row[2].hasPrefix("Prize: X="))
            let handle = { (substring: Substring) -> LongPoint in
                let pref = substring.contains("Prize") ? BigInt("10000000000000") : 0
                let sub = String(substring.split(separator: ":")[1])
                    .replacingOccurrences(of: "X", with: "")
                    .replacingOccurrences(of: "Y", with: "")
                    .replacingOccurrences(of: "+", with: "")
                    .replacingOccurrences(of: "=", with: "")
                    .split(separator: ",")
                let numbers = sub
                    .map({ String($0).removeSpace })
                    .filter({ !$0.isEmpty })
                    .map({ pref + BigInt($0)! })
                assert(sub.count == 2)
                return .init(x: numbers[0], y: numbers[1])
            }
            return Puzzle(a: handle(row[0]), b: handle(row[1]), result: handle(row[2]))
        }

    func calculate(_ puzzle: Puzzle) -> BigInt {
        let dev = puzzle.a.y * puzzle.b.x - puzzle.a.x * puzzle.b.y
        let top = puzzle.result.y * puzzle.b.x - puzzle.result.x * puzzle.b.y

        if dev == 0 || top % dev != 0 {
            return 0
        }

        let k0 = top / dev
        let xDelta = puzzle.result.x - puzzle.a.x * k0

        if xDelta % puzzle.b.x != 0 {
            return 0
        }

        let k1 = xDelta / puzzle.b.x
        assert(
            k0 > 0 && k1 > 0 &&
            k0 * puzzle.a.x + k1 * puzzle.b.x == puzzle.result.x &&
            k0 * puzzle.a.y + k1 * puzzle.b.y == puzzle.result.y
        )
        let total = k0 * 3 + k1


        return total
    }
    let result = input.reduce(0, { $0 + calculate($1) })
    return Int(result)
}

