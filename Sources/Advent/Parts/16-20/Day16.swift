import Foundation

func day16part1() -> Int {
    var input = DataLoader.load().rows.map({ $0.toArray })
    var _startPosition: Point!
    var _endPosition: Point!
    input.forMap { point, value in
        if value == "S" {
            _startPosition = point
            input[point.y][point.x] = "."
        }
        if value == "E" {
            _endPosition = point
            input[point.y][point.x] = "."
        }
    }
    class Title {
        var value: Int = .max
        var step: Step?
    }
    var map = input.map({ $0.map { value -> Title? in
        if value == "." {
            return Title()
        } else {
            return nil
        }
    } })
    let start = _startPosition!
    let end = _endPosition!
    var diffs = [Point(x: 1, y: 0), Point(x: -1, y: 0), Point(x: 0, y: 1), Point(x: 0, y: -1)]
    class Step {
        var start: Point
        var current: Point
        var last: Point
        var width: Int = 0 {
            didSet {
                assert(nextSteps.isEmpty)
            }
        }
        var lastStep: Step? = nil {
            didSet {
                updateStartWidth()
            }
        }
        var nextSteps: [Step] = []

        var fullWidth: Int {
            startWidth + width
        }
        var startWidth: Int = 0

        func updateStartWidth() {
            var base = lastStep?.fullWidth ?? 0
            if let last = lastStep?.calculateMove(start) {
                base += last
            }
            self.startWidth = base
            for step in nextSteps {
                step.updateStartWidth()
            }
        }

        init(current: Point, last: Point) {
            self.start = current
            self.current = current
            self.last = last
        }

        func next(_ current: Point) {
            self.width += calculateMove(current)
            self.last = self.current
            self.current = current
        }

        func calculateMove(_ next: Point) -> Int {
            let lastDiff = Point(x: abs(next.x - last.x), y: abs(next.y - last.y))
            if next == last {
                assert(true)
                return 2002
            }
            if lastDiff.x * lastDiff.y > 0 {
                return 1001
            } else {
                return 1
            }
        }
    }
    var endSteps: [Step] = []
    var steps: [Step] = [.init(current: start, last: start.move(x: -1))]
    var minValue: Int = .max
    while steps.count > 0 {
        var newSteps: [Step] = []
        for step in steps {
            while true {
                if step.fullWidth > minValue {
                    break
                }
                if step.current == end {
                    step.updateStartWidth()
                    minValue = min(step.fullWidth, minValue)
                    endSteps.append(step)
                    break
                }
                var nextPoint: [Point] = []
                for diff in diffs {
                    let pos = step.current + diff
                    if input[pos] == "." && pos != step.last {
                        nextPoint.append(pos)
                    }
                }
                if nextPoint.count == 1 {
                    step.next(nextPoint[0])
                    continue
                }
                step.updateStartWidth()
                let full = step.fullWidth
                for newPoint in nextPoint {
                    let width = full + step.calculateMove(newPoint)
                    if width < map[newPoint]!!.value {
                        map[newPoint]!!.value = width
                        if let nextStep = map[newPoint]!!.step {
                            nextStep.lastStep = step
                        } else {
                            let newStep = Step(current: newPoint, last: step.current)
                            newStep.lastStep = step
                            step.nextSteps.append(newStep)
                            newSteps.append(newStep)
                        }
                    }
                }
                break
            }
        }
        steps = newSteps
    }
    endSteps.forEach { $0.updateStartWidth() }
    return endSteps.map { $0.fullWidth }.min() ?? 0
}

func day16part2() -> Int {
    var input = DataLoader.load().rows.map({ $0.toArray })
    var _startPosition: Point!
    var _endPosition: Point!
    input.forMap { point, value in
        if value == "S" {
            _startPosition = point
            input[point.y][point.x] = "."
        }
        if value == "E" {
            _endPosition = point
            input[point.y][point.x] = "."
        }
    }
    class Title {
        var value: Int = .max
        var step: Step?
    }
    var map = input.map({ $0.map { value -> Title? in
        if value == "." {
            return Title()
        } else {
            return nil
        }
    } })
    let start = _startPosition!
    let end = _endPosition!
    var diffs = [Point(x: 1, y: 0), Point(x: -1, y: 0), Point(x: 0, y: 1), Point(x: 0, y: -1)]
    class Step {
        var start: Point
        var current: Point
        var last: Point

        var points: Set<Point> = .init()

        var width: Int = 0 {
            didSet {
                assert(nextSteps.isEmpty)
            }
        }
        var lastSteps: [Step] = [] {
            didSet {
                updateStartWidth()
            }
        }
        var nextSteps: [Step] = []

        var fullWidth: Int {
            startWidth + width
        }
        var startWidth: Int = 0

        var allPoints: Set<Point> {
            var points = Set<Point>()
            guard let base = lastSteps.map({ $0.fullWidth + $0.calculateMove(start) }).min() else { return points }
            lastSteps.forEach { step in
                if step.fullWidth + step.calculateMove(start) == base {
                    points.formUnion(step.allPoints)
                }
            }
            return points.union(self.points)
        }

        func updateStartWidth() {
            let base = lastSteps.map { $0.fullWidth + $0.calculateMove(start) }.min() ?? 0
            self.startWidth = base
            for step in nextSteps {
                step.updateStartWidth()
            }
        }

        init(current: Point, last: Point) {
            self.start = current
            self.current = current
            self.last = last
            points.insert(current)
        }

        func next(_ current: Point) {
            points.insert(current)
            self.width += calculateMove(current)
            self.last = self.current
            self.current = current
        }

        func calculateMove(_ next: Point) -> Int {
            let lastDiff = Point(x: abs(next.x - last.x), y: abs(next.y - last.y))
            if next == last {
                assert(true)
                return 2002
            }
            if lastDiff.x * lastDiff.y > 0 {
                return 1001
            } else {
                return 1
            }
        }
    }
    var endSteps: [Step] = []
    var steps: [Step] = [.init(current: start, last: start.move(x: -1))]
    var minValue: Int = .max
    while steps.count > 0 {
        var newSteps: [Step] = []
        for step in steps {
            while true {
                if step.fullWidth > minValue {
                    break
                }
                if step.current == end {
                    step.updateStartWidth()
                    minValue = min(step.fullWidth, minValue)
                    endSteps.append(step)
                    break
                }
                var nextPoint: [Point] = []
                for diff in diffs {
                    let pos = step.current + diff
                    if input[pos] == "." && pos != step.last {
                        nextPoint.append(pos)
                    }
                }
                if nextPoint.count == 1 {
                    step.next(nextPoint[0])
                    continue
                }
                step.updateStartWidth()
                let full = step.fullWidth
                for newPoint in nextPoint {
                    let width = full + step.calculateMove(newPoint)
                    if width <= map[newPoint]!!.value {
                        map[newPoint]!!.value = width
                        if let nextStep = map[newPoint]!!.step {
                            nextStep.lastSteps.append(step)
                        } else {
                            let newStep = Step(current: newPoint, last: step.current)
                            newStep.lastSteps.append(step)
                            step.nextSteps.append(newStep)
                            newSteps.append(newStep)
                        }
                    }
                }
                break
            }
        }
        steps = newSteps
    }
    endSteps.forEach { $0.updateStartWidth() }
    let min = endSteps.map { $0.fullWidth }.min() ?? 0
    var points = Set<Point>()
    endSteps.forEach { step in
        if step.fullWidth == min {
            points.formUnion(step.allPoints)
        }
    }
    return points.count + 1
}
