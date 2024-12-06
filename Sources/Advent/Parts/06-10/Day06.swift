import Foundation

func day06part1() -> Int {
    var map = DataLoader.load().split(separator: "\n")
        .map({ String($0).removeSpace.toArray })

    var charterX = 0
    var charterY = 0
    for y in 0..<map.count {
        for x in 0..<map[0].count {
            if map[y][x] == "^" {
                charterX = x
                charterY = y
                map[y][x] = "."
            }
        }
    }
    var result = 0
    var directX = 0
    var directY = -1
    while let value = map[safe: charterY]?[safe: charterX] {
        if value != "_" {
            result += 1
            map[charterY][charterX] = "_"
        }
        if map[safe: charterY + directY]?[safe: charterX + directX] == "#" {
            let a = directX
            let b = directY
            directX = -b
            directY = a
        } else {
            charterX += directX
            charterY += directY
        }
    }
    return result
}

func day06part2() -> Int {
    var map = DataLoader.load().split(separator: "\n")
        .map({ String($0).removeSpace.toArray.map({ Set([$0]) }) })

    var charterX = 0
    var charterY = 0
    for y in 0..<map.count {
        for x in 0..<map[0].count {
            if map[y][x] == Set(["^"]) {
                charterX = x
                charterY = y
                map[y][x] =  Set(["."])
            }
        }
    }
    var directX = 0
    var directY = -1

    var positions = Set<String>()
    func checkLoop(charterX: Int, charterY: Int, directX: Int, directY: Int) {
        guard let value = map[safe: charterY + directY]?[safe: charterX + directX], value == Set(["."]) else {
            return
        }
        let key = "x:\(charterX + directX)y:\(charterY + directY)"
        var charterX = charterX
        var charterY = charterY
        var directX = directX
        var directY = directY
        var loop = false
        if positions.contains(key) {
            return
        }

        let y = charterY + directY
        let x = charterX + directX
        map[y][x] = Set(["#"])
        defer {
            map[y][x] = Set(["."])
        }

        struct Pos: Hashable {
            var x, y, dx, dy: Int
        }
        var pos = Set<Pos>()
        while map[safe: charterY]?[safe: charterX] != nil {
            let key = Pos(x: charterX, y: charterY, dx: directX, dy: directY)
            if pos.contains(key) {
                loop = true
                break
            }
            pos.insert(key)

            if map[safe: charterY + directY]?[safe: charterX + directX] == Set(["#"]) {
                let a = directX
                let b = directY
                directX = -b
                directY = a
            } else {
                charterX += directX
                charterY += directY
            }
        }
        if loop {
            positions.insert(key)
        }
    }

    while let value = map[safe: charterY]?[safe: charterX] {
        if value != Set(["_"]) {
            map[charterY][charterX] = Set(["_"])
        }
        checkLoop(charterX: charterX, charterY: charterY, directX: directX, directY: directY)
        if map[safe: charterY + directY]?[safe: charterX + directX] == Set(["#"]) {
            let a = directX
            let b = directY
            directX = -b
            directY = a
        } else {
            charterX += directX
            charterY += directY
        }
    }

    return positions.count
}
