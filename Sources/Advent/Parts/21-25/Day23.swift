import Foundation

func day23part1() -> Int {
    struct Connection: Hashable {
        let a: String
        let b: String

        init(a: String, b: String) {
            let sort = [a, b].sorted()
            self.a = sort[0]
            self.b = sort[1]
        }
    }

    let input = DataLoader.load().rows.map({ $0.split("-").sorted() }).map({ Connection(a: $0[0], b: $0[1]) })
    let allConnections: Set<Connection> = .init(input)
    let allComputers = Set(input.flatMap({ [$0.a, $0.b] }))

    var setBase: Set<[String]> = []

    let computersSorter = allComputers.sorted()
    for a_i in 0..<computersSorter.count - 2 {
        let a = computersSorter[a_i]
        for b_i in (a_i + 1)..<computersSorter.count - 1 {
            let b = computersSorter[b_i]
            guard a != b else { continue }
            for c_i in (b_i + 1)..<computersSorter.count {
                let c = computersSorter[c_i]
                guard a != c || c != b else { continue }
                guard a.hasPrefix("t") || b.hasPrefix("t") || c.hasPrefix("t") else { continue }
                let currentConnections = Set([
                    Connection(a: a, b: b),
                    Connection(a: a, b: c),
                    Connection(a: c, b: b),
                ])
                if currentConnections.isSubset(of: allConnections) {
                    let key = Set([a, b, c]).sorted()
                    if key.count == 3 {
                        assert(key.count == 3)
                        setBase.insert(key)
                    }
                }
            }
        }
    }
    return setBase.count
}

func day23part2() -> String {
    struct Connection: Hashable {
        let a: String
        let b: String

        init(a: String, b: String) {
            let sort = [a, b].sorted()
            self.a = sort[0]
            self.b = sort[1]
        }
    }
    struct ConnectionSet: Hashable {
        let computers: Set<String>
        let variations: Set<String>

        func hash(into hasher: inout Hasher) {
            hasher.combine(computers)
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.computers == rhs.computers
        }
    }
    let input = DataLoader.load().rows.map({ $0.split("-").sorted() }).map({ Connection(a: $0[0], b: $0[1]) })
    let allConnections: Set<Connection> = .init(input)
    let allComputers = Set(input.flatMap({ [$0.a, $0.b] }))
    var allSets: Set<ConnectionSet> = Set(allComputers.map({ ConnectionSet(computers: [$0], variations: allComputers) }))
    while true {
        var newSets: Set<ConnectionSet> = .init()
        for currentSet in allSets {
            var newComputers = Set<String>()
            for a in currentSet.variations {
                var added: Bool = true
                if currentSet.computers.contains(a) { continue }
                for b in currentSet.computers {
                    if !allConnections.contains(.init(a: a, b: b)) {
                        added = false
                        break
                    }
                }
                if added {
                    newComputers.insert(a)
                }
            }
            for newComputer in newComputers {
                newSets.insert(.init(computers: currentSet.computers.union([newComputer]), variations: newComputers))
            }
        }
        allSets = newSets
        if newSets.count == 1 {
            return newSets.first!.computers.sorted().joined(separator: ",")
        }
    }
}
