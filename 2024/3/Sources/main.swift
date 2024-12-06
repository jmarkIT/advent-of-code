//
//  main.swift
//  Mull It Over
//
//  Created by James Mark on 12/4/24.
//

import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"

func loadInput() -> String {
    do {
        let input = try String(contentsOfFile: inputPath, encoding: .utf8)
        return input
    } catch {
        print(FileManager.default.currentDirectoryPath)
        fatalError("Could not read input file")
    }
}

func splitInput(input: String) -> [String] {
    return input.components(separatedBy: .newlines)
}

@MainActor
func multiplyNumbers(lines: [String]) -> Int {
    var total = 0

    for line in lines {
        var lineTotal = 0
        let matches = line.matches(of: search)

        for match in matches {
            lineTotal += (match.output.1 ?? 0) * (match.output.2 ?? 0)
        }
        total += lineTotal
    }

    return total
}

@MainActor
func multiplyNumbersWithCommands(lines: [String]) -> Int {
    var total = 0
    var doCommand = true

    for line in lines {
        var lineTotal = 0
        let matches = line.matches(of: searchDos)
        for match in matches {
            let foundMatch: String = String(match.output.0)
            if foundMatch == "don\'t()" {
                doCommand = false
            }
            if foundMatch == "do()" {
                doCommand = true
            }

            if foundMatch.contains("mul") && doCommand == true {
                let mulMatch = foundMatch.firstMatch(of: search)
                if let mulMatch {
                    lineTotal += (mulMatch.output.1 ?? 0) * (mulMatch.output.2 ?? 0)
                }
            }
        }

        total += lineTotal
    }

    return total
}

let input = loadInput()
let lines = splitInput(input: input)

print(multiplyNumbers(lines: lines))
print(multiplyNumbersWithCommands(lines: lines))
