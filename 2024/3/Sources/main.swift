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

let sampleInput = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

let input = loadInput()
let lines = splitInput(input: input)

print(multiplyNumbers(lines: lines))
