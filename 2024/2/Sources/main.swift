// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"

func loadInput() -> String {
    do {
        let input = try String(contentsOfFile: inputPath, encoding: .utf8)
        return input
    } catch {
        fatalError("Could not read input file")
    }
}

func createArrays(input: String) -> [[Int]] {
    var arrays: [[Int]] = []
    let stringArrays = input.components(separatedBy: .newlines)
    for array in stringArrays {
        let splitArray = array.components(separatedBy: " ")
        let intArray = splitArray.map { Int($0)! }
        arrays.append(intArray)
    }
    return arrays
}

func checkForSafety(array: [Int]) -> Bool {
    let reports = array
    var hasIncreased = false
    var hasDecreased = false
    var isSafe = true

    for i in 0..<reports.count - 1 {
        let current = reports[i]
        let next = reports[i + 1]

        if current == next {
            isSafe = false
        }

        if abs(current - next) > 3 {
            isSafe = false
        }

        if current > next {
            if hasIncreased {
                isSafe = false
            }
            hasDecreased = true
        }

        if current < next {
            if hasDecreased {
                isSafe = false
            }
            hasIncreased = true
        }
    }
    return isSafe
}

func checkForSafetyWithOneBadLevel(array: [Int]) -> Bool {
    let firstCheck = checkForSafety(array: array)
    if firstCheck {
        return true
    }

    for i in 0..<array.count {
        var report = array
        report.remove(at: i)
        let safety = checkForSafety(array: report)
        if safety {
            return true
        }
    }

    return false
}

func countSafetyChecks(arrays: [[Int]]) -> Int {
    var safeCount = 0
    for array in arrays {
        let safetyCheck = checkForSafety(array: array)
        if safetyCheck { safeCount += 1 }
    }

    return safeCount
}

func countSafetyChecksWithOneBadLevel(arrays: [[Int]]) -> Int {
    var safeCount = 0
    for array in arrays {
        let safetyCheck = checkForSafetyWithOneBadLevel(array: array)
        if safetyCheck { safeCount += 1 }
    }

    return safeCount
}

let input = loadInput()
let arrays = createArrays(input: input)
let safetyCount = countSafetyChecks(arrays: arrays)
print("\(safetyCount) of the reports are safe!")
let safetyCountWithOneBadLevel = countSafetyChecksWithOneBadLevel(arrays: arrays)
print("\(safetyCountWithOneBadLevel) of the reports are safe with one level removed.")
