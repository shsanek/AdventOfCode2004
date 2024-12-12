import Foundation

struct Point: Hashable {
    let x, y: Int
}

func day12part1() -> Int {
    var input = DataLoader.load().split(separator: "\n").map({ String($0).removeSpace }).filter({ !$0.isEmpty }).map({ $0.toArray })
    let width = input[0].count
    let height = input[0].count
    let diffs: [Point] = [.init(x: -1, y: 0), .init(x: 1, y: 0), .init(x: 0, y: -1), .init(x: 0, y: 1)]
    var result: Int = 0
    for y in 0..<height {
        for x in 0..<width {
            guard input[y, x] != "." else {
                continue
            }
            let currentSymbol = input[y, x]!
            var steps: Set<Point> = [.init(x: x, y: y)]
            var perimeter: Int = 0
            var allPoints: Set<Point> = [.init(x: x, y: y)]
            while steps.count > 0 {
                var newSteps = Set<Point>()
                for point in steps {
                    allPoints.insert(point)
                    for diff in diffs {
                        let point = Point(x: point.x + diff.x, y: point.y + diff.y)
                        if input[point.y, point.x] == currentSymbol {
                            if !allPoints.contains(point) {
                                newSteps.insert(point)
                                allPoints.insert(point)
                            }
                        } else {
                            perimeter += 1
                        }
                    }
                }
                steps = newSteps
            }
            for point in allPoints {
                input[point.y][point.x] = "."
            }
            result += perimeter * allPoints.count
        }
    }
    return result
}

func day12part2() -> Int {
    struct Border: Hashable {
        let point: Point
        let diff: Point

        init(point: Point, diff: Point) {
            self.point = point
            self.diff = diff
        }

        var nextBorder: Border {
            .init(point: .init(x: point.x + diff.y, y: point.y + diff.x), diff: diff)
        }

        var backBorder: Border {
            .init(point: .init(x: point.x - diff.y, y: point.y - diff.x), diff: diff)
        }
    }
    var input = DataLoader.load().split(separator: "\n").map({ String($0).removeSpace }).filter({ !$0.isEmpty }).map({ $0.toArray })
    let width = input[0].count
    let height = input[0].count
    let diffs: [Point] = [.init(x: -1, y: 0), .init(x: 1, y: 0), .init(x: 0, y: -1), .init(x: 0, y: 1)]
    var result: Int = 0
    for y in 0..<height {
        for x in 0..<width {
            guard input[y, x] != "." else {
                continue
            }
            let currentSymbol = input[y, x]!
            var steps: Set<Point> = [.init(x: x, y: y)]
            var perimeter: Int = 0
            var allPoints: Set<Point> = [.init(x: x, y: y)]
            var borders: Set<Border> = []
            while steps.count > 0 {
                var newSteps = Set<Point>()
                for base in steps {
                    for diff in diffs {
                        let point = Point(x: base.x + diff.x, y: base.y + diff.y)
                        if input[point.y, point.x] == currentSymbol {
                            if !allPoints.contains(point) {
                                newSteps.insert(point)
                                allPoints.insert(point)
                            }
                        } else {
                            borders.insert(.init(point: base, diff: diff))
                            perimeter += 1
                        }
                    }
                }
                steps = newSteps
            }
            var sum = 0
            while borders.count > 0 {
                sum += 1
                let current = borders.first!
                borders.remove(current)

                var firstCurrent = current
                while borders.contains(firstCurrent.nextBorder) {
                    borders.remove(firstCurrent.nextBorder)
                    firstCurrent = firstCurrent.nextBorder
                }
                firstCurrent = current
                while borders.contains(firstCurrent.backBorder) {
                    borders.remove(firstCurrent.backBorder)
                    firstCurrent = firstCurrent.backBorder
                }
            }
            result += sum * allPoints.count
            for point in allPoints {
                input[point.y][point.x] = "."
            }
        }
    }
    return result
}
