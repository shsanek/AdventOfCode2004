import Foundation

func day03part1() -> Int {
    let input = DataLoader.load()
    let symbols = input.toCharterArray

    var i = 0
    var result = 0
    while i < symbols.count {
        if 
            symbols.checkSubstring(i: &i, substring: "mul("),
            let number1 = symbols.getNumber(i: &i),
            symbols.checkSubstring(i: &i, substring: ","),
            let number2 = symbols.getNumber(i: &i),
            symbols.checkSubstring(i: &i, substring: ")")
        {
            result += number1 * number2
        }
    }

    return result
}

func day03part2() -> Int {
    let input = DataLoader.load()
    let symbols = input.toCharterArray

    var i = 0
    var result = 0
    var skip = false
    while i < symbols.count {
        if symbols.checkSubstring(i: &i, shift: 0, substring: "don't()") {
            skip = true
        }
        if skip {
            if symbols.checkSubstring(i: &i, substring: "do()") {
                skip = false
            }
        } else {
            if
                symbols.checkSubstring(i: &i, substring: "mul("),
                let number1 = symbols.getNumber(i: &i),
                symbols.checkSubstring(i: &i, substring: ","),
                let number2 = symbols.getNumber(i: &i),
                symbols.checkSubstring(i: &i, substring: ")")
            {
                result += number1 * number2
            }
        }
    }
    return result
}
