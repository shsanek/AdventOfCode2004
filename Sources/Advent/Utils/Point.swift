import Foundation

struct Point: Hashable {
    var x, y: Int

    var len_2: Int {
        x * x + y * y
    }

    static func +(a: Point, b: Point) -> Point {
        .init(x: a.x + b.x, y: a.y + b.y)
    }

    static func -(a: Point, b: Point) -> Point {
        .init(x: a.x - b.x, y: a.y - b.y)
    }

    static func *(a: Point, k: Int) -> Point {
        .init(x: a.x * k, y: a.y * k)
    }

    static func ==(a: Point, b: Point) -> Bool {
        return a.x == b.x && a.y == b.y
    }

    func move(x: Int = 0, y: Int = 0) -> Point {
        .init(x: self.x + x, y: self.y + y)
    }
}

