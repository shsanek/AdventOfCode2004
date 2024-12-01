import Foundation

func day01part1() -> Int {
    let rows = DataLoader.load().rows.map { $0.oneSpace.split(separator: " ").map { Int(String($0).removeSpace)! }  }
    let array1 = rows.map { $0[0] }.sorted()
    let array2 = rows.map { $0[1] }.sorted()

    var length = 0
    for i in 0..<rows.count {
        length += abs(array1[i] - array2[i])
    }
    return length
}

func day01part2() -> Int {
    let rows = DataLoader.load().rows.map { $0.oneSpace.split(separator: " ").map { Int(String($0).removeSpace)! }  }
    let array1 = rows.map { $0[0] }.sorted()
    let array2 = rows.map { $0[1] }.sorted()

    var result = 0
    for i in 0..<rows.count {
        let filterArray = array2.filter { $0 == array1[i] }
        result += array1[i] * filterArray.count
    }
    return result
}
