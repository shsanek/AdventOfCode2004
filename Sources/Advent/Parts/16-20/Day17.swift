import Foundation

func day17part1() -> Int {
    let input = DataLoader.load().split("\n\n")
    let regA = 0
    let regB = 1
    let regC = 2
    let program = input[1].rows[0].split(": ")[1].split(",").map({ Int($0)! })

    var register = input[0].rows.map({ Int($0.split(": ")[1])! })
    assert(register.count == 3)
    var programIndex = 0
    let getOperand = { (isCom: Bool) -> Int in
        if !isCom {
            return program[programIndex + 1]
        }
        let value = program[programIndex + 1]
        if value < 4 {
            return value
        }
        assert(value < 7)
        return register[value - 4]
    }

    func pow(_ value: Int, _ pow: Int) -> Int {
        var result = 1
        for _ in 0..<pow {
            result *= value
        }
        return result
    }

    var out: [String] = []
    while programIndex < program.count {
        let command = program[programIndex]
        if command == 0 {
            register[regA] = register[regA] / pow(2, getOperand(true))
        } else if command == 6 {
            register[regB] = register[regA] / pow(2, getOperand(true))
        } else if command == 7 {
            register[regC] = register[regA] / pow(2, getOperand(true))
        } else if command == 1 {
            register[regB] = register[regB] ^ getOperand(false)
        } else if command == 2 {
            register[regB] = getOperand(true) & 0x7
        } else if command == 3 {
            if register[regA] != 0 {
                programIndex = getOperand(false)
                continue
            }
        } else if command == 4 {
            register[regB] = register[regB] ^ register[regC]
        } else if command == 5 {
            let operand = getOperand(true)
            let value = operand & 0x7
            print("\(value)")
            out.append("\(value)")
        } else {
            fatalError()
        }
        programIndex += 2
    }
    let result = out.joined()
    print("[T] \(result)")
    return Int(result)!
}


func day17part2() -> Int {
    let input = DataLoader.load().split("\n\n")

    let program = input[1].rows[0].split(": ")[1].split(",").map({ Int($0)! })

    class SearchNumber {
        var current: Int = 0
        let baseValue: Int
        let lock: Set<Int>

        init(current: Int = 0, lock: Set<Int> = []) {
            self.lock = lock

            var index = 0
            var baseValue = 0
            while current >= (0x1 << index) {
                if lock.contains(index) {
                    baseValue += current & (0x1 << index)
                }
                index += 1
            }
            self.baseValue = baseValue
            self.current = baseValue
        }

        func copy(start: Int, index: Int) -> SearchNumber {
            let index = index * 3
            let locks = [
                start + index + 0, start + index + 1, start + index + 2,
                index + 0, index + 1, index + 2
            ]

            return .init(current: current, lock: lock.union(locks))
        }

        @discardableResult
        func next() -> Int {
            var index = 0
            while true {
                if lock.contains(index) {
                    index += 1
                } else {
                    let mask = 0x1 << index
                    if current & mask == 0 {
                        current += mask
                        return current
                    } else {
                        current -= mask
                        index += 1
                    }
                }
            }
        }
    }

    func checkTwoValue(value: SearchNumber, index: Int, values: inout [Int]) {
        var check: Set<Int> = .init()
        for _ in (0)...0b1111111111 {
            let regA = value.current >> (index * 3)
            if regA & 0b1000000000000 != 0 {
                return
            }
            var regB = 0
            var regC = 0

            //2,4  B = A % 8
            //1,5  B = B XOR 5
            //7,5  C = A / (2^B)
            //1,6  B = B XOR 6
            //0,3  A = A / 8
            //4,0  B = B ^ C
            //5,5  out(B)
            //3,0  if A != 0 goto 0

            regB = (regA & 0b111) ^ 0b101
            regC = regA >> regB
            regB = regB ^ 0b110
            regB = regB ^ regC
            let out = regB & 0b111

            if out == program[index] {
                if index == program.count - 1 {
                    values.append(value.current)
                } else {
                    let shift = (regA & 0b111) ^ 0b101
                    let nextValue = value.copy(start: shift, index: index)
                    if !check.contains(nextValue.baseValue) {
                        checkTwoValue(value: nextValue, index: index + 1, values: &values)
                        check.insert(nextValue.baseValue)
                    }
                }
            }
            value.next()
        }
    }

    var values: [Int] = []
    checkTwoValue(value: .init(), index: 0, values: &values)
    return values.min()!
}
