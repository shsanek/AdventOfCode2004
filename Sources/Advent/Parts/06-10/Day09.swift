import Foundation

func day09part1() -> Int {
    var input = DataLoader.load().removeSpace.map({ Int(String($0))! })
    var index = 0
    var i = 0
    var result = 0
    if input.count % 2 == 0 {
        input.removeLast()
    }
    while i < input.count {
        defer { i += 1 }
        guard i % 2 == 1 else {
            for _ in 0..<input[i] {
                result += index * i / 2
                index += 1
            }
            continue
        }
        for _ in 0..<input[i] {
            if input.last == 0 {
                input.removeLast()
                input.removeLast()
                assert(input.last! > 0)
            }
            if i >= input.count {
                break
            }
            let id = input.count / 2
            input[input.count - 1] -= 1
            result += index * id
            index += 1
        }
    }
    return result
}

func day09part2() -> Int {
    let input = DataLoader.load().removeSpace.map({ Int(String($0))! })
    class Block {
        struct File {
            let id: Int
            let size: Int
            var move: Bool
        }
        var startIndex: Int
        var free: Int
        var files: [File]

        init(startIndex: Int, free: Int, files: [File]) {
            self.free = free
            self.files = files
            self.startIndex = startIndex
        }

        func insert(file: File) -> Bool {
            if file.size <= free {
                files.append(file)
                free -= file.size
                return true
            }
            return false
        }

        func calculate() -> Int {
            var index = startIndex
            var result = 0
            for file in files {
                for _ in 0..<file.size {
                    result += file.id * index
                    index += 1
                }
            }
            return result
        }
    }
    var i = 0
    var blocks = [Block]()
    var index = 0
    while i < input.count {
        defer { i += 2 }
        blocks.append(
            .init(
                startIndex: index,
                free: input[safe: i + 1] ?? 0,
                files: [.init(id: i / 2, size: input[i], move: false)]
            )
        )
        index += input[i] + (input[safe: i + 1] ?? 0)
    }
    for i in 0..<blocks.count {
        let j = blocks.count - i - 1
        let block = blocks[j]
        let index = blocks.prefix(j).firstIndex(where: { $0.insert(file: block.files[0]) })
        if index != nil {
            let file = block.files[0]
            block.files.removeFirst()
            block.startIndex += file.size
            blocks[safe: j - 1]?.free += file.size
        }
    }


    return blocks.reduce(0, { $0 + $1.calculate() })
}
