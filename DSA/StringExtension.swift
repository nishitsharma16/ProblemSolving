//
//  StringExtension.swift
//  DSA
//
//  Created by Nishit on 11/04/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension String {
    
    func stringToInteger() -> Int {
        let list = self.compactMap{ Int(String($0)) }
        let base = 10
        var power = 0
        var count = power
        var val = 0
        while count >= 0 {
            if let x = Int("\((pow(Decimal(base), power)))") {
                val += x*list[count]
            }
            count -= 1
            power += 1
        }
        return val
    }
    
    func findAllNumbers() -> [String] {
        let list = self.map { String($0) }
        var finalList = [String]()
        var strVal = ""
        for val in list {
            if let intVal = Int(val) {
                strVal += "\(intVal)"
            }
            else {
                if !strVal.isEmpty {
                    finalList.append(strVal)
                    strVal = ""
                }
            }
        }
        return finalList
    }
    
    //01231
    func findMaxValueWithAddOrMultiply() -> Int {
        let zero = 0
        let one = 1
        var result = 0
        let list = self.compactMap { Int(String($0)) }
        
        if !list.isEmpty {
            result = list[0] == zero || list[0] == one ? 0 : 1
            for val in list {
                if val == zero || val == one {
                    result += val
                }
                else if result == zero || result == one {
                    result += val
                }
                else {
                    result *= val
                }
            }
        }
        
        return result
    }
    
    func findMaxSegement(segment : Int) -> String {
        let intlist = self.compactMap { Int(String($0)) }
        var result = ""
        
        if !intlist.isEmpty {
            
            var max = intlist[0]
            for val in intlist {
                if val > max {
                    max = val
                }
            }
            
            if let maxIndex = intlist.firstIndex(of: max) {
                
                var count = maxIndex
                var segementCheck = 0
                
                while count < intlist.count {
                    let leftVals = intlist.count - segementCheck
                    if leftVals == segment {
                        break
                    }
                    result += "\(intlist[count])"
                    segementCheck += 1
                    count += 1
                }
                
                return result
            }
        }
        return result
    }
    
    /*
     IMP: Whenever we need to calculate remainder just calculate remainder with given number with a series {1, 10, 100, 1000, 10000,....}
     then in most of the cases, we will find there is series will come, just use that series to multiply each digit(from right to left) with that remainder and sum all values and again modulo that sum with that given number. The final remainder value will be the answer.
    */
    
    func remainderWhenDevidedByEleven() -> Int {
        let intlist = self.compactMap { Int(String($0)) }
        var count = intlist.count - 1
        var sum = 0
        let valList = [1, 10]
        var valCounter = 0
        let valListLength = valList.count
        
        while count >= 0 {
            let val = intlist[count]
            let index = valCounter % valListLength
            let multiplyer = valList[index]
            sum += multiplyer*val
            sum = sum % 11
            count -= 1
            valCounter += 1
        }
        
        return sum
    }
    
    func remainderWhenDevidedBySeven() -> Int {
        let intlist = self.compactMap { Int(String($0)) }
        var count = intlist.count - 1
        var sum = 0
        let valList = [1, 3, 2, -1, -3, -2]
        var valCounter = 0
        let valListLength = valList.count
        
        while count >= 0 {
            let val = intlist[count]
            let index = valCounter % valListLength
            let multiplyer = valList[index]
            sum += multiplyer*val
            sum = sum % 7
            count -= 1
            valCounter += 1
        }
        
        return sum
    }
    
    func caseInSensitiveWordsFromSentence() -> [String] {
        
        let list = self.map { String($0) }
        let charList = [" ", ". ", "\n"]
        var finalList = [String]()
        
        var str = ""
        for index in 0..<list.count {
            let val = list[index]
            if charList.contains(val) {
                if !str.isEmpty {
                    finalList.append(str.lowercased())
                    str = ""
                }
            }
            else if index == list.count - 1 {
                str += val
                if !str.isEmpty {
                    finalList.append(str.lowercased())
                    str = ""
                }
            }
            else {
                str += val
            }
        }
        return finalList
    }
    
    func wordsFromSentence() -> [String] {
        
        let list = self.map { String($0) }
        let charList = [" ", ". ", "\n"]
        var finalList = [String]()
        
        var str = ""
        for index in 0..<list.count {
            let val = list[index]
            if charList.contains(val) {
                if !str.isEmpty {
                    finalList.append(str)
                    str = ""
                }
            }
            else if index == list.count - 1 {
                str += val
                if !str.isEmpty {
                    finalList.append(str)
                    str = ""
                }
            }
            else {
                str += val
            }
        }
        return finalList
    }
    
    func countVowel() -> Int {
        let list = self.map { String($0) }
        let vowelList = ["a", "e", "i", "o", "u"]
        var count = 0
        for val in list {
            if vowelList.contains(val) {
                count += 1
            }
        }
        return count
    }
    
    func difficultyOfSentence() -> Int {
        let list = self.map { String($0) }
        let charList = [" ", ". ", "\n"]
        let vowelList = ["a", "e", "i", "o", "u"]
        var finalInfo = [String : Int]()
        var hardWord = 0
        var easyWord = 0
        
        for val in list {
            var str = ""
            var vowelCount = 0
            if charList.contains(val) {
                if !str.isEmpty {
                    finalInfo[str] = vowelCount
                }
                str = ""
                vowelCount = 0
            }
            else {
                if vowelList.contains(val) {
                    vowelCount += 1
                }
                str += val
            }
        }
        
        
        for item in finalInfo {
            let strlength = item.key.count
            if strlength < item.value {
                hardWord += 1
            }
            else {
                easyWord += 1
            }
        }
        
        return calculateDifficulty(hardWord: hardWord, easyWord: easyWord)
    }
    
    func calculateDifficulty(hardWord : Int, easyWord : Int) -> Int {
        return (5*hardWord + 3*easyWord)
    }
    
    func traverseString() {
        for i in 0..<self.count {
            let index = self.index(self.startIndex, offsetBy: i)
            let val = self[index]
            print("Val\(val)")
            let str = String(val)
            print("Val\(str)")
        }
    }
    
    func findLettersIntegerSpecialCharacters() -> (letters : String, integer : String, specialChars : String) {
        var letters = ""
        var integer = ""
        var other = ""
        
        for index in 0..<self.count {
            let indexVal = self.index(self.startIndex, offsetBy: index)
            let val = self[indexVal]
            if Constant.smallA2Z.contains(val) {
                letters.append(val)
            }
            else if Constant.digits.contains(val) {
                integer.append(val)
            }
            else {
                other.append(val)
            }
        }
        
        return (letters, integer, other)
    }
    
    func checkAllCharFound(info : [Character : Int]) -> Bool {
        if info.isEmpty {
            return false
        }
        for item in info {
            if item.value == 0 {
                return false
            }
        }
        return true
    }
    
    // Incomplete
    func findSmallestWindow(str : String) -> (start : Int, end : Int) {
        
        var startVal = -1
        var endVal = -1
        
        if str.count > self.count {
            return (startVal, endVal)
        }
        
        var hashPath = [Character : Int]()
        
        for index in 0..<str.count {
            let indexVal = str.index(str.startIndex, offsetBy: index)
            let val = str[indexVal]
            hashPath[val] = 0
        }
        
        for index in 0..<self.count {
            let indexVal = self.index(self.startIndex, offsetBy: index)
            let val = self[indexVal]
            if let findVal = hashPath[val] {
                hashPath[val] = findVal + 1
                if startVal == -1 {
                    startVal = self.distance(from: self.startIndex, to: indexVal)
                }
            }
        }
        
        return (0, 0)
    }
    
    func findAllUniqueCharSet() -> Set<Character> {
        var set = Set<Character>()
        for index in 0..<self.count {
            let indexVal = self.index(self.startIndex, offsetBy: index)
            let val = self[indexVal]
            set.insert(val)
        }
        return set
    }
    
    func findAllUniqueCharString() -> String {
        
        var result = ""
        let set = self.findAllUniqueCharSet()
        
        for item in set {
            result += String(item)
        }
        
        return result
    }
    
    func findSmalletWindowContainsAllChars() -> (start : Int, end : Int) {
        
        let maxCharCount = 256
        var distVisitedList = Array<Bool>(repeating: false, count: maxCharCount)
        var currCharList = Array<Int>(repeating: 0, count: maxCharCount)
        
        var count = 0
        var distCharCount = 0
        var start = 0
        var startIndex = 0
        var minLength = Int(INT_MAX)
    
        for index in 0..<self.count {
            let indexVal = self.getCharIndex(offset: index)
            if distVisitedList[indexVal] == false {
                distVisitedList[indexVal] = true
                distCharCount += 1
            }
        }
        
        for index in 0..<self.count {
            let indexVal = self.getCharIndex(offset: index)
            currCharList[indexVal] += 1
            if currCharList[indexVal] == 1 {
                count += 1
            }
            
            if count == distCharCount {
                while currCharList[self.getCharIndex(offset: start)] > 1 {
                    if currCharList[self.getCharIndex(offset: start)] > 1 {
                        currCharList[self.getCharIndex(offset: start)] -= 1
                    }
                    start += 1
                }
                
                let windowLength = index - startIndex + 1
                if minLength > windowLength {
                    minLength = windowLength
                    startIndex = start
                }
            }
        }
        
        return (startIndex, (startIndex + minLength - 1))
    }
    
    func getCharIndex(offset : Int) -> Int {
        let indexVal = self.index(self.startIndex, offsetBy: offset)
        let val = self[indexVal]
        if let charIndex = val.unicodeScalars.first?.value {
            let intIndex = Int(charIndex)
            return intIndex
        }
        return 0
    }
    
    func getAllSubstrings() -> [String] {
        
        var result = [String]()
        
        // Loop on length of substrings
        for length in 1...self.count {
            // Loop for substrings
            var start = self.startIndex
            for _ in 0...(self.count-length) {
                let indexVal = self.index(start, offsetBy: length - 1)
                let val = String(self[start...indexVal])
                result.append(val)
                start = self.index(after: start)
            }
        }
        
        return result
    }
    
    func findStringHaving(distinctCharCount : Int) -> Bool {
        let set = self.findAllUniqueCharSet()
        return set.count == distinctCharCount
    }
    
    func subStringsHavingDistinctCharsNaive(distinctCharCount : Int) -> [String] {
        
        var result = [String]()
        
        // Loop on length of substrings
        for length in distinctCharCount...self.count {
            // Loop for substrings
            var start = self.startIndex
            for index in 0...(self.count-length) {
                let indexVal = self.index(start, offsetBy: index + length - 1)
                let val = String(self[start...indexVal])
                if val.findStringHaving(distinctCharCount: distinctCharCount) {
                    result.append(val)
                }
                start = self.index(after: start)
            }
        }
        
        return result
    }
    
    // https://www.geeksforgeeks.org/count-number-of-substrings-with-exactly-k-distinct-characters/
    func subStringsHavingDistinctChars(distinctCharCount : Int) -> [String] {
        
        var result = [String]()
        let maxCharCount = 256

        for index in 0..<self.count {
            
            var distCount = 0
            var currCharList = Array<Int>(repeating: 0, count: maxCharCount)
            var str = ""
            
            for i in index..<self.count {
                
                let charIndexVal = self.getCharIndex(offset: i)
                currCharList[charIndexVal] += 1
                if currCharList[charIndexVal] == 1 {
                    let indexVal = self.index(self.startIndex, offsetBy: i)
                    let val = self[indexVal]
                    str += String(val)
                    distCount += 1
                }
                
                if distCount == distinctCharCount {
                    result.append(str)
                }
                
                // Have some doubt on this
                if distCount > distinctCharCount {
                    break
                }
            }
        }
        
        return result
    }
    
    func checkCharCountList(list : [Int], count : Int) -> Bool {
        for item in list {
            if item != 0 && item != count {
                return false
            }
        }
        return true
    }
    
    // https://www.geeksforgeeks.org/number-substrings-count-character-k/
    func subStringsHavingEachCharWithGivenCount(charCount : Int) -> Int {
        
        var result = 0
        let maxCharCount = 256
        
        for index in 0..<self.count {
            
            var currCharList = Array<Int>(repeating: 0, count: maxCharCount)
            
            for i in index..<self.count {
                
                let charIndexVal = self.getCharIndex(offset: i)
                currCharList[charIndexVal] += 1
                
                if currCharList[charIndexVal] > charCount {
                    break
                }
                
                if currCharList[charIndexVal] == charCount && checkCharCountList(list: currCharList, count: charCount) {
                    result += 1
                }
            }
        }
        
        return result
    }
    
    func createStringWithNoAdjecentAreSame(length : Int, distintCharCount : Int) -> String {
        var result = ""
        
        let a2z = Constant.smallA2Z
        let index = a2z.index(a2z.startIndex, offsetBy: distintCharCount - 1)
        let subStr = String(a2z[a2z.startIndex...index])
        
        var count = 0
        
        while count != length {
            let index = subStr.index(subStr.startIndex, offsetBy: (count % subStr.count))
            result += String(subStr[index])
            count += 1
        }
        
        return result
    }
    
    //Naive method
    func searchStringPatterInGivenString(str : String, pat : String) -> Bool {
        if str.isEmpty || pat.isEmpty {
            return false
        }
        
        let strLength = str.count
        let patLength = pat.count
        
        if patLength > strLength {
            return false
        }
        
        for i in 0...(strLength - patLength) {
            var j = 0
            while j < patLength {
                if str[i + j] != pat[j] {
                    break
                }
                j += 1
            }
            if j == patLength {
                return true
            }
        }
        
        return false
    }
    
    // LPS: Longest proper prefix which is suffix as well of any patter pat[0..i] then lps[i] = max lenghth of porper perfix which is suffix as well i.e. for "AAA" prefixes are "", "A", "AA" but not includes pattern pat[0..i] itself. And suffies are "", "A", "AA", "AAA"
    func lps(pat : String) -> [Int] {
        var lps = [Int]()
        if pat.isEmpty {
            return lps
        }
        var length = 0
        lps[0] = 0
        var index = 1
        while index < pat.count {
            if pat[index] == pat[length] {
                length += 1
                lps[index] = length
                index += 1
            }
            else {
                if length != 0 {
                    length = lps[length - 1]
                }
                else {
                    if length == 0 {
                        lps[index] = 0
                        index += 1
                    }
                }
            }
        }
        return lps
    }
    
    func kmpAlgorithmForFirstIndex(str : String, pat : String) -> Int {
        if str.isEmpty || pat.isEmpty {
            return -1
        }
        
        let strLength = str.count
        let patLength = pat.count
        
        if patLength > strLength {
            return -1
        }
        
        let lpsVal = lps(pat: pat)
        
        var i = 0
        var j = 0
        
        while i < strLength {
            if str[i] == pat[j] {
                i += 1
                j += 1
            }
            
            if j == patLength {
                return i - j
            }
            else if i < strLength && pat[j] != str[i] {
                if j > 0 {
                    j = lpsVal[j - 1]
                }
                else {
                    i += 1
                }
            }
        }
        return -1
    }
    
    func kmpAlgorithm(str : String, pat : String) -> Bool {
        if str.isEmpty || pat.isEmpty {
            return false
        }
        
        let strLength = str.count
        let patLength = pat.count
        
        if patLength > strLength {
            return false
        }
        
        let lpsVal = lps(pat: pat)
        
        var i = 0
        var j = 0
        
        while i < strLength {
            if str[i] == pat[j] {
                i += 1
                j += 1
            }
            
            if j == patLength {
                print("Match found")
                j = lpsVal[j - 1]
            }
            else if i < strLength && pat[j] != str[i] {
                if j > 0 {
                    j = lpsVal[j - 1]
                }
                else {
                    i += 1
                }
            }
        }
        return false
    }
    
    // Minimum operations to convert one string from another operations(insert, replace and remove)
    func editDistanceToConvertOneStringToAnother(str : String, target : String) -> Int {
        
        return 0
    }
    
    func checkStringIsPalindrome() -> Bool {
        if self.isEmpty {
            return false
        }
        
        var leftIndex = self.startIndex
        var rightIndex = self.index(before: self.endIndex) 
        
        while leftIndex < rightIndex {
            let x = self[leftIndex]
            let y = self[rightIndex]
            
            if x != y {
                return false
            }
            
            leftIndex = self.index(after: leftIndex)
            rightIndex = self.index(before: rightIndex)
        }
        
        return true
    }
    
//    subscript(_ index : Int) -> Character {
//        return self[self.index(self.startIndex, offsetBy: index)]
//    }
//
}

extension WordItem : Comparable {
    static func < (lhs: WordItem<Item>, rhs: WordItem<Item>) -> Bool {
        lhs.frequency < rhs.frequency
    }
    
    static func == (lhs: WordItem<Item>, rhs: WordItem<Item>) -> Bool {
        return lhs.frequency == rhs.frequency
    }
}

struct Constant {
    static let smallA2Z = "abcdefghijklmnopqrstuvwxyz"
    static let digits = "0123456789"
}

extension String {
    subscript(_ offset : Int) -> Character {
        return self[index(self.startIndex, offsetBy: offset)]
    }
    
    subscript(_ startIndex : Int, _ endIndex : Int) -> String {
        
        if self.isEmpty {
            return ""
        }
        
        let length = self.count
        if startIndex >= 0 && startIndex < length && endIndex >= 0 && endIndex < length {
            let startIndexVal = self.index(self.startIndex, offsetBy: startIndex)
            let endIndexVal = self.index(self.startIndex, offsetBy: endIndex)
            if startIndexVal >= self.startIndex && startIndexVal < self.endIndex && endIndexVal >= self.startIndex && endIndexVal < self.endIndex {
                return String(self[startIndexVal...endIndexVal])
            }
            else {
                return ""
            }
        }
        else {
            return ""
        }
    }
    
    func startWith(_ s: String, _ index: Int) -> Bool {
        if s.isEmpty {
            return false
        }
        
        var indexVal = index
        let length = self.count
        
        if index + s.count > length {
            return false
        }
        
        for item in s {
            if indexVal < length && self[indexVal] != item {
                return false
            }
            indexVal += 1
        }
        
        return true
    }
    
    func isHexaDecimal() -> Bool {
        for item in self {
            let set = CharacterSet.init(charactersIn: "0123456789ABCDEFabcdef")
            if let x = item.unicodeScalars.first, !set.contains(x) {
                return false
            }
        }
        return true
    }
    
    func removeWhiteSpaceCharFromStartAndEnd() -> String {
        if self.isEmpty {
            return .empty
        }
        
        let length = self.count
        var firstNonSpaceIndex = 0
        var lastNonSpaceIndex = 0

        for index in 0..<length {
            let val = String(self[index])
            if val != .space {
                firstNonSpaceIndex = index
                break
            }
        }
        
        var counter = length - 1
        while counter >= 0 {
            let val = String(self[counter])
            if val != .space {
                lastNonSpaceIndex = counter
                break
            }
            counter -= 1
        }
        
        let start = self.startIndex
        let firstIndex = self.index(start, offsetBy: firstNonSpaceIndex)
        let lastIndex = self.index(start, offsetBy: lastNonSpaceIndex)
        let finalVal = self[firstIndex...lastIndex]
        return String(finalVal)
    }
    
    func isNegative() -> Bool? {
        if self.isEmpty {
            return .none
        }
        if let val = self.first {
            let x = String(val)
            if x == "-" {
                return true
            }
        }
        return false
    }
    
    func sort() -> String {
        let charList: [Character] = self.sorted()
        var val = ""
        for char in charList {
            val += String(char)
        }
        return val
    }
}

extension String {
    static var empty: String {
        ""
    }
    
    static var space: String {
        " "
    }
}

extension Character {
    var isDigit: Bool {
        let val = String(self)
        if let _ = Int(val) {
            return true
        }
        return false
    }
    
    var intVal: Int? {
        let val = String(self)
        return Int(val)
    }
    
}

extension StringProtocol {
    var asciiValues: [UInt8] { compactMap(\.asciiValue) }
}
