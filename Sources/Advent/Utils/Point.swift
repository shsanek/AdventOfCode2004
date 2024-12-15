import Foundation

struct Point: Hashable {
    var x, y: Int

    static func +(a: Point, b: Point) -> Point {
        .init(x: a.x + b.x, y: a.y + b.y)
    }

    static func *(a: Point, k: Int) -> Point {
        .init(x: a.x * k, y: a.y * k)
    }

    static func ==(a: Point, b: Point) -> Bool {
        return a.x == b.x && a.y == b.y
    }
}

