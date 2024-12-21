import Foundation

func day20part1() -> Int {
    var input = DataLoader.load().split("\n").map({ $0.toArray })
    var start: Point!
    var end: Point!
    input.forMap { point, value in
        if value == "S" {
            start = point
        }
        if value == "E" {
            end = point
        }
    }
    input[start.y][start.x] = "."
    input[end.y][end.x] = "."

    var values: [[Int?]] = Array(repeating: Array(repeating: nil, count: input[0].count), count: input.count)
    var step = 0
    var currentPositions: Set<Point> = .init([end])
    let diffs: [Point] = [.init(x: -1, y: 0), .init(x: 1, y: 0), .init(x: 0, y: -1), .init(x: 0, y: 1)]
    while !currentPositions.isEmpty {
        var newPosition = Set<Point>()
        for currentPosition in currentPositions {
            values[currentPosition.y][currentPosition.x] = step
            for diff in diffs {
                let pos = currentPosition + diff
                if input[pos] == ".", values[pos]! == nil {
                    newPosition.insert(pos)
                }
            }
        }
        step += 1
        currentPositions = newPosition
    }
    struct Cheat: Hashable {
        let s, e: Point
    }

    let minStep = values[start]!!
    step = 0
    currentPositions = .init([start])

    var cheats: [Cheat: Int] = [:]
    let diffs2: [Point] = [
        .init(x: 1, y: 1), .init(x: 1, y: -1), .init(x: -1, y: 1), .init(x: -1, y: -1)
    ] + diffs.map({ $0 * 2 })

    var allPositions = Set<Point>()
    while !currentPositions.isEmpty {
        var newPosition = Set<Point>()
        for currentPosition in currentPositions {
            for diff in diffs {
                let pos = currentPosition + diff
                if !allPositions.contains(pos), input[pos] == "." {
                    newPosition.insert(pos)
                    allPositions.insert(pos)
                }
            }
            for diff in diffs2 {
                let pos = currentPosition + diff
                let cheat = Cheat(s: currentPosition, e: pos)
                if input[pos] == ".", let value = values[pos]! {
                    let time = step + 2 + value
                    if time < minStep, cheats[cheat, default: .max] > time {
                        cheats[cheat] = time
                    }
                }
            }
        }
        step += 1
        currentPositions = newPosition
    }
    let list = cheats
        .map({ (minStep - $0.value, $0.key) })
        .sorted(by: { $0.0 < $1.0 })
    print(
        list.map({ "\($0.0) - s: <\($0.1.s.x), \($0.1.s.y)> e: <\($0.1.e.x), \($0.1.e.y)>" }).joined(separator: "\n")
    )
    let barier = DataLoader.isRealData ? 100 : 64
    return list.filter({ $0.0 >= barier }).count
}

func day20part2() -> Int {
    var input = DataLoader.load().split("\n").map({ $0.toArray })
    var start: Point!
    var end: Point!
    input.forMap { point, value in
        if value == "S" {
            start = point
        }
        if value == "E" {
            end = point
        }
    }
    input[start.y][start.x] = "."
    input[end.y][end.x] = "."

    var values: [[Int?]] = Array(repeating: Array(repeating: nil, count: input[0].count), count: input.count)
    var step = 0
    var currentPositions: Set<Point> = .init([end])
    let diffs: [Point] = [.init(x: -1, y: 0), .init(x: 1, y: 0), .init(x: 0, y: -1), .init(x: 0, y: 1)]
    while !currentPositions.isEmpty {
        var newPosition = Set<Point>()
        for currentPosition in currentPositions {
            values[currentPosition.y][currentPosition.x] = step
            for diff in diffs {
                let pos = currentPosition + diff
                if input[pos] == ".", values[pos]! == nil {
                    newPosition.insert(pos)
                }
            }
        }
        step += 1
        currentPositions = newPosition
    }
    struct Cheat: Hashable {
        let s, e: Point
    }

    let minStep = values[start]!!
    step = 0
    currentPositions = .init([start])

    var cheats: [Cheat: Int] = [:]
    var diffs2: Set<Point> = .init()

//    let diffs2: [Point] = [
//        .init(x: 1, y: 1), .init(x: 1, y: -1), .init(x: -1, y: 1), .init(x: -1, y: -1)
//    ] + diffs.map({ $0 * 2 })

    for i in 0...18 {
        for x in 0...i {
            for y in 0...(i - x) {
                diffs2.insert(.init(x: x, y: y))
                diffs2.insert(.init(x: x, y: -y))
                diffs2.insert(.init(x: -x, y: y))
                diffs2.insert(.init(x: -x, y: -y))
            }
        }
    }

    var allPositions = Set<Point>()
    while !currentPositions.isEmpty {
        var newPosition = Set<Point>()
        for currentPosition in currentPositions {
            for diff in diffs {
                let pos = currentPosition + diff
                if !allPositions.contains(pos), input[pos] == "." {
                    newPosition.insert(pos)
                    allPositions.insert(pos)
                }
            }
            var cheatPositions: Set<Point> = .init([currentPosition])
            var allCheatPositions: Set<Point> = .init()
            var cheatStep: Int = 1
            let startPosition = currentPosition
            while !cheatPositions.isEmpty, cheatStep < 21 {
                var newPosition = Set<Point>()
                defer {
                    cheatPositions = newPosition
                    cheatStep += 1
                }
                for currentPosition in cheatPositions {
                    for diff in diffs {
                        let pos = currentPosition + diff
                        if !allCheatPositions.contains(pos) {
                            if input[pos] == "." {
                                let cheat = Cheat(s: startPosition, e: pos)
                                if let value = values[pos]! {
                                    let time = step + cheatStep + value
                                    if time < minStep, cheats[cheat, default: .max] > time {
                                        cheats[cheat] = time
                                    }
                                }
                            }
                            newPosition.insert(pos)
                            allCheatPositions.insert(pos)
                        }
                    }
                }
            }
        }
        step += 1
        currentPositions = newPosition
    }
    let list = cheats
        .map({ (minStep - $0.value, $0.key) })
        .sorted(by: { $0.0 < $1.0 })
    
    let barier = DataLoader.isRealData ? 100 : 64
    return list.filter({ $0.0 >= barier }).count
}
