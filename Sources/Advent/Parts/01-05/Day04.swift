import Foundation

func check(x: Int, y: Int, rows: [[String]], directX: Int, directY: Int, text: [String]) -> Bool {
    for i in 0..<text.count {
        if rows[y + directY * i][x + directX * i] != text[i] {
            return false
        }
    }
    return true
}

func day04part1() -> Int {
    let text = "XMAS".toArray
    let horizontalOffset = Array(repeating: "_", count: text.count).joined()
    var rows = DataLoader.load()
        .split(separator: "\n")
        .map({ String(horizontalOffset + $0 + horizontalOffset).removeSpace.toArray })
    let verticalOffset = Array(repeating: Array(repeating: "_", count: rows[0].count), count: text.count)
    rows = verticalOffset + rows + verticalOffset

    var result = 0
    for y in text.count..<(rows.count - text.count) {
        for x in text.count..<(rows[0].count - text.count) {
            guard rows[y][x] == text[0] else {
                continue
            }
            if check(x: x, y: y, rows: rows, directX: 1, directY: 0, text: text) {
                result += 1
            }
            if check(x: x, y: y, rows: rows, directX: -1, directY: 0, text: text) {
                result += 1
            }
            if check(x: x, y: y, rows: rows, directX: 0, directY: 1, text: text) {
                result += 1
            }
            if check(x: x, y: y, rows: rows, directX: 0, directY: -1, text: text) {
                result += 1
            }
            if check(x: x, y: y, rows: rows, directX: 1, directY: -1, text: text) {
                result += 1
            }
            if check(x: x, y: y, rows: rows, directX: -1, directY: -1, text: text) {
                result += 1
            }
            if check(x: x, y: y, rows: rows, directX: 1, directY: 1, text: text) {
                result += 1
            }
            if check(x: x, y: y, rows: rows, directX: -1, directY: 1, text: text) {
                result += 1
            }
        }
    }

    return result
}

func day04part2() -> Int {
    let text = "MAS".toArray
    let horizontalOffset = Array(repeating: "_", count: text.count).joined()
    var rows = DataLoader.load()
        .split(separator: "\n")
        .map({ String(horizontalOffset + $0 + horizontalOffset).removeSpace.toArray })
    let verticalOffset = Array(repeating: Array(repeating: "_", count: rows[0].count), count: text.count)
    rows = verticalOffset + rows + verticalOffset

    var result = 0
    let set = Set(["M", "S"])
    for y in text.count..<(rows.count - text.count) {
        for x in text.count..<(rows[0].count - text.count) {
            guard rows[y][x] == "A" else {
                continue
            }
            let first = Set([rows[y - 1][x - 1], rows[y + 1][x + 1]])
            let second = Set([rows[y - 1][x + 1], rows[y + 1][x - 1]])

            if set == first, set == second {
                result += 1
            }
        }
    }

    return result
}
