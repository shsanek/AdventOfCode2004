import Foundation

func day15part1() -> Int {
    let input = DataLoader.load().split("\n\n")
    assert(input.count == 2)
    var map = input[0].rows.map({ $0.toArray })
    let controls = input[1].removeSpace.toArray
    var position: Point!
    map.forMap { point, value in
        if value == "@" {
            position = point
        }
    }
    for control in controls {
//        defer {
//            print("c: \(control), map: \n\(map.map({ $0.joined() }).joined(separator: "\n"))")
//        }
        let move: Point
        if control == "^" { move = .init(x: 0, y: -1) } else
        if control == "v" { move = .init(x: 0, y: 1) } else
        if control == ">" { move = .init(x: 1, y: 0) } else
        if control == "<" { move = .init(x: -1, y: 0) } else
        { fatalError() }

        var first = position!
        while let value = map[first], value != "#" {
            if value == "." {
                break
            } else {
                first = first + move
            }
        }

        guard map[first] != nil && map[first] != "#" else { continue }
        let minusDiff = move * -1
        while first != position {
            map[first.y][first.x] = map[first + minusDiff]!
            first = first + minusDiff
            map[first.y][first.x] = "."
        }
        position = position + move
    }

    var result = 0
    map.forMap { point, value in
        if value == "O" {
            result += point.y * 100 + point.x
        }
    }

    return result
}

func day15part2() -> Int {
    let input = DataLoader.load().split("\n\n")
    assert(input.count == 2)
    var map = input[0].rows.map({ 
        $0
        .replacingOccurrences(of: ".", with: "..")
        .replacingOccurrences(of: "O", with: "[]")
        .replacingOccurrences(of: "#", with: "##")
        .replacingOccurrences(of: "@", with: "@.")
        .toArray
    })
    let controls = input[1].removeSpace.toArray
    var position: Point!
    map.forMap { point, value in
        if value == "@" {
            position = point
        }
    }
    for control in controls {
//        defer {
//            print("c: \(control), map: \n\(map.map({ $0.joined() }).joined(separator: "\n"))")
//        }
        let move: Point
        if control == "^" { move = .init(x: 0, y: -1) } else
        if control == "v" { move = .init(x: 0, y: 1) } else
        if control == ">" { move = .init(x: 1, y: 0) } else
        if control == "<" { move = .init(x: -1, y: 0) } else
        { fatalError() }
        if move.y == 0 {
            var first = position!
            while let value = map[first], value != "#" {
                if value == "." {
                    break
                } else {
                    first = first + move
                }
            }

            guard map[first] != nil && map[first] != "#" else { continue }
            let minusDiff = move * -1
            while first != position {
                map[first.y][first.x] = map[first + minusDiff]!
                first = first + minusDiff
                map[first.y][first.x] = "."
            }
            position = position + move
            continue
        }
        var steps = [Set([position!])]
        var isPossible = true
        while isPossible {
            let last = steps.last!
            var newPosition: Set<Point> = []
            for position in last {
                if map[position + move] == "#" {
                    isPossible = false
                    break
                }
                if map[position + move] == "[" {
                    newPosition.insert(position + move)
                    newPosition.insert(position + move.move(x: 1))
                }
                if map[position + move] == "]" {
                    newPosition.insert(position + move)
                    newPosition.insert(position + move.move(x: -1))
                }
            }
            if newPosition.isEmpty { break }
            steps.append(newPosition)
        }
        guard isPossible else { continue }
        for container in steps.reversed().enumerated() {
            let step = container.element
            for position in step {
                let nextPosition = position + move
                map[nextPosition.y][nextPosition.x] = map[position]!
                map[position.y][position.x] = "."
            }
        }
        position = position + move
    }

    var result = 0
    map.forMap { point, value in
        if value == "[" {
            result += point.y * 100 + point.x
        }
    }

    return result
}
