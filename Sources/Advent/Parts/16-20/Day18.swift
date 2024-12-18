import Foundation

func day18part1() -> Int {
    let input = DataLoader.load().rows.map({ $0.split(",").map({ Int($0)! }) }).prefix(DataLoader.isRealData ? 1024 : 12)
    let size = DataLoader.isRealData ? 71 : 7
    var map = Array(repeating: Array(repeating: " ", count: size), count: size)
    for value in input {
        assert(value.count == 2)
        map[value[1]][value[0]] = "#"
    }
    var currentPositions: Set<Point> = [.init(x: 0, y: 0)]
    var step = 0
    let diffs: [Point] = [.init(x: 0, y: 1), .init(x: 0, y: -1), .init(x: -1, y: 0), .init(x: 1, y: 0)]
    while currentPositions.count > 0 {
        var nextPositions: Set<Point> = []
        for pos in currentPositions {
            map[pos.y][pos.x] = "*"
        }
        for point in currentPositions {
            for diff in diffs {
                let pos = point + diff
                if map[pos] == " " {
                    nextPositions.insert(pos)
                }
            }
        }
        if nextPositions.contains(.init(x: size - 1, y: size - 1)) {
            return step + 1
        }
        print(nextPositions)
        step += 1
        currentPositions = nextPositions
    }
    return 0
}

func day18part2() -> String {
    let input = DataLoader.load().rows.map({ $0.split(",").map({ Int($0)! }) })
    let size = DataLoader.isRealData ? 71 : 7
    var map = Array(repeating: Array(repeating: " ", count: size), count: size)
    for value in input.prefix(DataLoader.isRealData ? 1024 : 12) {
        map[value[1]][value[0]] = "#"
    }
    let diffs: [Point] = [.init(x: 0, y: 1), .init(x: 0, y: -1), .init(x: -1, y: 0), .init(x: 1, y: 0)]
    let endPosition: Point = .init(x: size - 1, y: size - 1)
    for value in input.dropFirst(DataLoader.isRealData ? 1024 : 12) {
        map[value[1]][value[0]] = "#"
        var points: Set<Point> = .init()
        var currentPositions: Set<Point> = [.init(x: 0, y: 0)]

        while currentPositions.count > 0 {
            var nextPositions: Set<Point> = []
            points.formUnion(currentPositions)

            for point in currentPositions {
                for diff in diffs {
                    let pos = point + diff
                    if !points.contains(pos), map[pos] == " " {
                        nextPositions.insert(pos)
                    }
                }
            }
            currentPositions = nextPositions
            if currentPositions.contains(endPosition) {
                break
            }
        }
        if !currentPositions.contains(endPosition) {
            return "\(value[0]),\(value[1])"
        }
    }
    return "0, 0"
}
