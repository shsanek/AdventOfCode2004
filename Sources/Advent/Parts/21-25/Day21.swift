import Foundation

func day21part1() -> Int {
    let numberKeys = [
        ["7", "8", "9"],
        ["4", "5", "6"],
        ["1", "2", "3"],
        ["#", "0", "A"]
    ]
    let controllKeys = [
        ["#", "^", "A"],
        ["<", "v", ">"]
    ]

    func path(_ keyboard: [[String]], input: [String], step: Int) -> Int {
        if step == 0 {
            return input.count
        }
        var startPosition: Point!

        keyboard.forMap { point, value in
            if value == "A" {
                startPosition = point
            }
        }
        var result: Int = 0
        var lastPosition: Point! = startPosition
        let diffs: [Point] = [.init(x: -1, y: 0), .init(x: 1, y: 0), .init(x: 0, y: -1), .init(x: 0, y: 1)]
        for target in input {
            var targetPosition: Point!
            keyboard.forMap { point, value in
                if value == target {
                    targetPosition = point
                }
            }
            var allPoints: Set<Point> = [targetPosition]
            var steps: [Set<Point>] = []
            var lastSteps: Set<Point> = allPoints
            while lastSteps.count > 0 {
                steps.insert(lastSteps, at: 0)
                if lastSteps.contains(lastPosition) {
                   break
                }
                var newStep = Set<Point>()
                for position in lastSteps {
                    for diff in diffs {
                        let pos = position + diff

                        if keyboard[pos] != nil, keyboard[pos] != "#", !allPoints.contains(pos) {
                            allPoints.insert(pos)
                            newStep.insert(pos)
                        }
                    }
                }
                lastSteps = newStep
            }
            func allVariation(indexStep: Int = 1, pos: Point) -> [[String]] {
                if indexStep == steps.count {
                    return [["A"]]
                }
                let step = steps[indexStep]
                var result: [[String]] = []
                for diff in diffs {
                    let posNew = pos + diff
                    if step.contains(posNew) {
                        var def = ""
                        let base = allVariation(indexStep: indexStep + 1, pos: posNew)
                        if diff.x == 1 {
                            def = ">"
                        } else if diff.x == -1 {
                            def = "<"
                        } else if diff.y == 1 {
                            def = "v"
                        } else if diff.y == -1 {
                            def = "^"
                        }
                        for suff in base {
                            result.append([def] + suff)
                        }
                    }
                }
                return result
            }
            let variations = allVariation(pos: lastPosition)
                .map({ (order: path(controllKeys, input: $0, step: step - 1), input: $0) })
            let best = variations.sorted(by: { $0.order < $1.order }).first!
            result += best.order
            lastPosition = targetPosition
        }
        return result
    }

    let input = DataLoader.load().rows
    var result = 0
    for code in input {
        let step = path(numberKeys, input: code.toArray, step: 3)

        let number = Int(code.dropLast())!
        result += step * number
    }
    return result
}

func day21part2() -> Int {
    let numberKeys = [
        ["7", "8", "9"],
        ["4", "5", "6"],
        ["1", "2", "3"],
        ["#", "0", "A"]
    ]
    let controllKeys = [
        ["#", "^", "A"],
        ["<", "v", ">"]
    ]

    struct CashKey: Hashable {
        let step: Int
        let input: [String]
    }
    var cash: [CashKey: Int] = [:]

    func path(_ keyboard: [[String]], input: [String], step: Int) -> Int {
        if step == 0 {
            return input.count
        }
        let cashKey = CashKey(step: step, input: input)
        if let value = cash[cashKey] {
            return value
        }
        var startPosition: Point!

        keyboard.forMap { point, value in
            if value == "A" {
                startPosition = point
            }
        }
        var result: Int = 0
        var lastPosition: Point! = startPosition
        let diffs: [Point] = [.init(x: -1, y: 0), .init(x: 1, y: 0), .init(x: 0, y: -1), .init(x: 0, y: 1)]
        for target in input {
            var targetPosition: Point!
            keyboard.forMap { point, value in
                if value == target {
                    targetPosition = point
                }
            }
            var allPoints: Set<Point> = [targetPosition]
            var steps: [Set<Point>] = []
            var lastSteps: Set<Point> = allPoints
            while lastSteps.count > 0 {
                steps.insert(lastSteps, at: 0)
                if lastSteps.contains(lastPosition) {
                   break
                }
                var newStep = Set<Point>()
                for position in lastSteps {
                    for diff in diffs {
                        let pos = position + diff

                        if keyboard[pos] != nil, keyboard[pos] != "#", !allPoints.contains(pos) {
                            allPoints.insert(pos)
                            newStep.insert(pos)
                        }
                    }
                }
                lastSteps = newStep
            }
            func allVariation(indexStep: Int = 1, pos: Point) -> [[String]] {
                if indexStep == steps.count {
                    return [["A"]]
                }
                let step = steps[indexStep]
                var result: [[String]] = []
                for diff in diffs {
                    let posNew = pos + diff
                    if step.contains(posNew) {
                        var def = ""
                        let base = allVariation(indexStep: indexStep + 1, pos: posNew)
                        if diff.x == 1 {
                            def = ">"
                        } else if diff.x == -1 {
                            def = "<"
                        } else if diff.y == 1 {
                            def = "v"
                        } else if diff.y == -1 {
                            def = "^"
                        }
                        for suff in base {
                            result.append([def] + suff)
                        }
                    }
                }
                return result
            }
            let variations = allVariation(pos: lastPosition)
                .map({ (order: path(controllKeys, input: $0, step: step - 1), input: $0) })
            let best = variations.sorted(by: { $0.order < $1.order }).first!
            result += best.order
            lastPosition = targetPosition
        }
        cash[cashKey] = result
        return result
    }

    let input = DataLoader.load().rows
    var result = 0
    for code in input {
        let step = path(numberKeys, input: code.toArray, step: 26)

        let number = Int(code.dropLast())!
        result += step * number
    }
    return result
}
