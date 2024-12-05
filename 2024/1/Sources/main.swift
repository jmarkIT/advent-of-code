// The Swift Programming Language
// https://docs.swift.org/swift-book
import ArgumentParser
import Foundation

let fileManager = FileManager.default
let currentPath = fileManager.currentDirectoryPath
let inputPath = currentPath + "/input.txt"

func loadInput() -> String {
    do {
        let input = try String(contentsOfFile: inputPath, encoding: .utf8)
        return input
    } catch {
        fatalError("Could not read input file")
    }
}

func createArrays(input: String) -> ([Int], [Int]) {
    let lists = input.components(separatedBy: .newlines)
    var leftArray: [Int] = []
    var rightArray: [Int] = []
    for list in lists {
        let stringListArray = list.components(separatedBy: "   ")
        leftArray.append(Int(stringListArray[0])!)
        rightArray.append(Int(stringListArray[1])!)
    }
    leftArray.sort()
    rightArray.sort()

    return (leftArray, rightArray)

}

func getListDistance(firstList: [Int], secondList: [Int]) -> Int {
    var listDistance: Int = 0
    for (idx, _) in firstList.enumerated() {
        listDistance += abs(firstList[idx] - secondList[idx])
    }

    return listDistance
}

func getListSimilarity(firstList: [Int], secondList: [Int]) -> Int {
    //TODO: Do this part
    var listSimilarity: Int = 0
    for i in firstList {
        let count = secondList.count { $0 == i }
        listSimilarity += count * i
    }
    return listSimilarity
}

let input = loadInput()
let (leftArray, rightArray) = createArrays(input: input)

let distance = getListDistance(firstList: leftArray, secondList: rightArray)
print("The distance between the two lists is \(distance)")

let similarity = getListSimilarity(firstList: leftArray, secondList: rightArray)
print("The similarity between the two lists is \(similarity)")
