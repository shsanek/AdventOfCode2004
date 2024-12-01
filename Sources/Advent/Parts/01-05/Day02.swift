import Foundation

private func checkLevel(row: [Int]) -> Bool {
    var last = row[0]
    let direction = row[0] - row[1]
    if direction == 0 {
        return false
    }
    var added = true
    for i in 1..<row.count {
        let diff = last - row[i]
        last = row[i]
        guard abs(diff) > 0 && abs(diff) < 4, direction * diff > 0 else {
            added = false
            break
        }
    }
    return added
}

func day02part1() -> Int {
    let input = DataLoader.load()
    let rows = input.oneSpace.rows.map { $0.split(separator: " ").map({ Int($0)! }) }
    var result = 0
    for row in rows {
        var last = row[0]
        let direction = row[0] - row[1]
        if direction == 0 {
            continue
        }
        var added = true
        for i in 1..<row.count {
            let diff = last - row[i]
            last = row[i]
            guard abs(diff) > 0 && abs(diff) < 4, direction * diff > 0 else {
                added = false
                break
            }
        }
        if added {
            result += 1
        }
    }
    return result
}

func day02part2() -> Int {
    let input = DataLoader.load()
    let rows = input.oneSpace.rows.map { $0.split(separator: " ").map({ Int($0)! }) }
    var result = 0
    for row in rows {
        if checkLevel(row: Array(row.dropFirst())) || checkLevel(row: Array(row.dropIndex(1))) {
            result += 1
            continue
        }
        var skip = true
        var added = true
        var last = row[0]
        var direction = 0
        for i in 1..<row.count {
            let diff = last - row[i]
            if direction == 0 {
                direction = diff
            }
            if !(abs(diff) > 0 && abs(diff) < 4 && direction * diff > 0) {
                if skip {
                    skip = false
                } else {
                    added = false
                    break
                }
            } else {
                last = row[i]
            }
        }
        if added {
            result += 1
        }
    }
    return result
}
