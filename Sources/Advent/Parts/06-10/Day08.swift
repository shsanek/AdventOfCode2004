import Foundation

func day08part1() -> Int {
    let input = DataLoader.load().split(separator: "\n").map({ String($0).toArray })
    var coordinates = Set<String>()
    struct Anten {
        let x, y: Int
        let value: String
    }
    var antens: [Anten] = []
    for y in 0..<input.count {
        assert(input[y].count == input[0].count)
        for x in 0..<input[0].count {
            if input[y][x] != "." {
                antens.append(.init(x: x, y: y, value: input[y][x]))
            }
        }
    }
    for i in 0..<(antens.count - 1) {
        for j in i+1..<antens.count {
            let a = antens[i]
            let b = antens[j]
            guard a.value == b.value else { continue }
            let ax = a.x + (a.x - b.x)
            let ay = a.y + (a.y - b.y)
            if input[ay, ax] != nil {
                coordinates.insert("\(ax):\(ay):")
            }
            let bx = b.x + (b.x - a.x)
            let by = b.y + (b.y - a.y)
            if input[by, bx] != nil {
                coordinates.insert("\(bx):\(by):")
            }
        }
    }
    print(coordinates.sorted())
    return coordinates.count
}

func day08part2() -> Int {
    let input = DataLoader.load().split(separator: "\n").map({ String($0).toArray })
    var coordinates = Set<String>()
    struct Anten {
        let x, y: Int
        let value: String
    }
    var antens: [Anten] = []
    for y in 0..<input.count {
        assert(input[y].count == input[0].count)
        for x in 0..<input[0].count {
            if input[y][x] != "." {
                antens.append(.init(x: x, y: y, value: input[y][x]))
            }
        }
    }
    for i in 0..<(antens.count - 1) {
        for j in i+1..<antens.count {
            let a = antens[i]
            let b = antens[j]
            guard a.value == b.value else { continue }
            var difX = (a.x - b.x)
            var difY = (a.y - b.y)
            var ay = a.y
            var ax = a.x
            while input[ay, ax] != nil {
                coordinates.insert("\(ax):\(ay):")
                ax += difX
                ay += difY
            }
            difX = (b.x - a.x)
            difY = (b.y - a.y)
            var by = b.y
            var bx = b.x
            while input[by, bx] != nil {
                coordinates.insert("\(bx):\(by):")
                bx += difX
                by += difY
            }
        }
    }
    print(coordinates.sorted())
    return coordinates.count
}
