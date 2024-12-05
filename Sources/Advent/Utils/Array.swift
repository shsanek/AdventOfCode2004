import Foundation

extension Array {
    func count(_ block: (Element) -> Bool) -> Int {
        var count = 0
        for element in self where block(element) {
            count += 1
        }
        return count
    }

    func removeFirst(_ block: (Element) -> Bool) -> [Element] {
        var result = self
        while result.count > 0 && block(result[0]) {
            result.removeFirst()
        }
        return result
    }

    func removeLast(_ block: (Element) -> Bool) -> [Element] {
        var result = self
        while result.count > 0 && block(result[result.count - 1]) {
            result.removeLast()
        }
        return result
    }

    func dropIndex(_ index: Int) -> [Element] {
        var result = self
        result.remove(at: index)
        return result
    }

    subscript(safe index: Int) -> Element? {
        (index >= 0 && index < count) ? self[index] : nil
    }
}
