import Foundation

func day19part1() -> Int {
    let input = DataLoader.load().split("\n\n")
    let variations = input[0].split(", ").map({ $0.removeSpace.map { $0.asciiValue! } })
    let targets = input[1].split("\n").map({ $0.removeSpace.map { $0.asciiValue! } })

    class Node {
        let title: UInt8
        var subtree: [Node?]
        var isEnded: Bool = false

        init(title: UInt8) {
            self.title = title
            self.subtree = .init(repeating: nil, count: 30)
        }

        static let shift = "a".first!.asciiValue!

        func getFor(_ value: UInt8) -> Node? {
            subtree[Int(value - Self.shift)]
        }

        func setVariations(_ variation: [UInt8], inputIndex: Int = 0) {
            assert(variation[inputIndex] == title)
            if variation.count == inputIndex + 1 {
                isEnded = true
                return
            }
            let index = Int(variation[inputIndex + 1] - Self.shift)
            let node = subtree[index] ?? .init(title: variation[inputIndex + 1])
            subtree[index] = node
            node.setVariations(variation, inputIndex: inputIndex + 1)
        }
    }

    var nodes: [Node?] = .init(repeating: nil, count: 30)
    var cashs: Set<[UInt8]> = []
    var nocash: Set<[UInt8]> = []

    variations.forEach { value in
        nodes[Int(value[0] - Node.shift)] = nodes[Int(value[0] - Node.shift)] ?? .init(title: value[0])
        nodes[Int(value[0] - Node.shift)]?.setVariations(value)
        cashs.insert(value)
    }


    func check(_ target: [UInt8]) -> Bool {
        if cashs.contains(target) {
            return true
        }
        if nocash.contains(target) {
            return false
        }
        if target.count == 0 {
            return true
        }
        var currentNode = nodes[Int(target[0] - Node.shift)]
        if target.count == 1 && currentNode?.isEnded == true {
            return true
        }
        for i in 1..<target.count {
            if currentNode == nil { break }
            if currentNode?.isEnded == true {
                if check(Array(target.dropFirst(i))) {
                    cashs.insert(target)
                    return true
                }
            }
            currentNode = currentNode?.getFor(target[i])
        }
        nocash.insert(target)
        return false
    }


    var result = 0

    for target in targets.enumerated() {
        if check(target.element) {
            result += 1
        }
    }
    return result
}

func day19part2() -> Int {
    let input = DataLoader.load().split("\n\n")
    let variations = input[0].split(", ").map({ $0.removeSpace.map { $0.asciiValue! } })
    let targets = input[1].split("\n").map({ $0.removeSpace.map { $0.asciiValue! } })

    class Node {
        let title: UInt8
        var subtree: [Node?]
        var isEnded: Bool = false

        init(title: UInt8) {
            self.title = title
            self.subtree = .init(repeating: nil, count: 30)
        }

        static let shift = "a".first!.asciiValue!

        func getFor(_ value: UInt8) -> Node? {
            subtree[Int(value - Self.shift)]
        }

        func setVariations(_ variation: [UInt8], inputIndex: Int = 0) {
            assert(variation[inputIndex] == title)
            if variation.count == inputIndex + 1 {
                isEnded = true
                return
            }
            let index = Int(variation[inputIndex + 1] - Self.shift)
            let node = subtree[index] ?? .init(title: variation[inputIndex + 1])
            subtree[index] = node
            node.setVariations(variation, inputIndex: inputIndex + 1)
        }
    }

    var nodes: [Node?] = .init(repeating: nil, count: 30)
    var cashs: [[UInt8]: Int] = [:]

    variations.forEach { value in
        nodes[Int(value[0] - Node.shift)] = nodes[Int(value[0] - Node.shift)] ?? .init(title: value[0])
        nodes[Int(value[0] - Node.shift)]?.setVariations(value)
    }


    func check(_ target: [UInt8]) -> Int {
        if let value = cashs[target] {
            return value
        }
        if target.count == 0 {
            return 1
        }
        var currentNode = nodes[Int(target[0] - Node.shift)]
        var result: Int = 0
        for i in 0..<target.count {
            if currentNode == nil { break }
            if currentNode?.isEnded == true {
                let new = check(Array(target.dropFirst(i + 1)))
                result += new
            }
            guard i + 1 < target.count else { break }
            currentNode = currentNode?.getFor(target[i + 1])
        }
        cashs[target] = result
        return result
    }

    var result = 0

    for target in targets.enumerated() {
        let value = check(target.element)
        result += value
    }
    return result
}
