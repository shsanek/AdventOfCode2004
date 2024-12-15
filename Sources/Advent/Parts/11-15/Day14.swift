import Foundation

func day14part1() -> Int {
    struct Robot {
        var x, y: Int
        let vx, vy: Int
    }
    let input = DataLoader.load().split(separator: "\n").map(String.init).filter({ !$0.isEmpty }).map({
        let numbers = $0
            .replacingOccurrences(of: "p", with: "")
            .replacingOccurrences(of: "v", with: "")
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: " ", with: ",")
            .split(separator: ",")
            .map({ Int($0)! })
        assert(numbers.count == 4)
        return Robot(x: numbers[0], y: numbers[1], vx: numbers[2], vy: numbers[3])
    })

    // 11шириной и 7высотой
    // 101шириной и 103
    let width = DataLoader.isRealData ? 101 : 11
    let height = DataLoader.isRealData ? 103 :  7
    let time = 100

    var sectors: [String: Int] = [:]

    for robot in input {
        let x = ((robot.x + robot.vx * time) % width + width) % width
        let y = ((robot.y + robot.vy * time) % height + height) % height
        if x == width / 2 || y == height / 2 { continue }
        let vSector = x < width / 2
        let hSector = y < height / 2
        sectors["\(vSector), \(hSector)", default: 0] += 1
    }
    return sectors.values.reduce(1, { $0 * $1 })
}

func day14part2() -> Int {
    struct Robot {
        var x, y: Int
        let vx, vy: Int
    }
    let input = DataLoader.load().split(separator: "\n").map(String.init).filter({ !$0.isEmpty }).map({
        let numbers = $0
            .replacingOccurrences(of: "p", with: "")
            .replacingOccurrences(of: "v", with: "")
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: " ", with: ",")
            .split(separator: ",")
            .map({ Int($0)! })
        assert(numbers.count == 4)
        return Robot(x: numbers[0], y: numbers[1], vx: numbers[2], vy: numbers[3])
    })

    // 11шириной и 7высотой
    // 101шириной и 103
    let width = DataLoader.isRealData ? 101 : 11
    let height = DataLoader.isRealData ? 103 :  7

    for time in 0..<10000 {
        var position: Set<Point> = .init()

        for robot in input {
            let x = ((robot.x + robot.vx * time) % width + width) % width
            let y = ((robot.y + robot.vy * time) % height + height) % height
            position.insert(Point(x: x, y: y))
        }
        var count = 0
        for point in position {
            if
                position.contains(point + .init(x: 1, y: 0)) &&
                position.contains(point + .init(x: -1, y: 0)) &&
                position.contains(point + .init(x: 0, y: 1)) &&
                position.contains(point + .init(x: 0, y: -1))
            {
                count += 1
            }
        }
        if count > 10 {
            return time
        }
    }
    return 0
}
