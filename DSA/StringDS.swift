//
//  StringDS.swift
//  DSA
//
//  Created by Nishit on 07/04/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class MyString {
    
    func maxMinSum(str1 : String, str2 : String, replace1 : String, replace2 : String) -> (max : String, min : String) {
        let list1 = str1.map { String($0) }
        let list2 = str2.map { String($0) }
        
        if let int1 = Int(replace1), let int2 = Int(replace2) {
            if int1 > int2 {
                var max1 = ""
                var min1 = ""
                
                for item in list1 {
                    if let val = Int(item) {
                        if val == int1 || val == int2 {
                            max1 += "\(int1)"
                            min1 += "\(int2)"
                        }
                        else {
                            max1 += "\(val)"
                            min1 += "\(val)"
                        }
                    }
                }
                
                var max2 = ""
                var min2 = ""
                
                for item in list2 {
                    if let val = Int(item) {
                        if val == int1 || val == int2 {
                            max2 += "\(int1)"
                            min2 += "\(int2)"
                        }
                        else {
                            max2 += "\(val)"
                            min2 += "\(val)"
                        }
                    }
                }
                
                let maxResult = addTwoNumbers(num1: max1, num2: max2)
                let minResult = addTwoNumbers(num1: min1, num2: min2)
                
                return (maxResult, minResult)
            }
            else {
                var max1 = ""
                var min1 = ""
                
                for item in list1 {
                    if let val = Int(item) {
                        if val == int1 || val == int2 {
                            max1 += "\(int2)"
                            min1 += "\(int1)"
                        }
                        else {
                            max1 += "\(val)"
                            min1 += "\(val)"
                        }
                    }
                }
                
                var max2 = ""
                var min2 = ""
                
                for item in list2 {
                    if let val = Int(item) {
                        if val == int1 || val == int2 {
                            max2 += "\(int2)"
                            min2 += "\(int1)"
                        }
                        else {
                            max2 += "\(val)"
                            min2 += "\(val)"
                        }
                    }
                }
                
                let maxResult = addTwoNumbers(num1: max1, num2: max2)
                let minResult = addTwoNumbers(num1: min1, num2: min2)
                
                return (maxResult, minResult)
            }
        }
        
        return ("", "")
    }
    
    func addTwoNumbers(num1 : String, num2 : String) -> String {
        
        let list1 = num1.map { String($0) }
        let list2 = num2.map { String($0) }
        
        if list1.count > list2.count {
            var sum = ""
            var rem = 0
            var count = list1.count - 1
            while count >= 0 {
                if let val1 = Int(list1[count]), let val2 = Int(list2[count]) {
                    let x = val1 + val2 + rem
                    let val = x / 10
                    if val > 0 {
                        sum += "\(val)"
                    }
                    rem = x % 10
                }
                count -= 1
            }
            
            if count >= 0 {
                rem = 0
                while count >= 0 {
                    if let val1 = Int(list1[count]) {
                        let x = val1 + rem
                        let val = x / 10
                        if val > 0 {
                            sum += "\(val)"
                        }
                        rem = x % 10
                    }
                    count -= 1
                }
            }
            return sum
        }
        else {
            var sum = ""
            var rem = 0
            var count = list2.count - 1
            while count >= 0 {
                if let val1 = Int(list1[count]), let val2 = Int(list2[count]) {
                    let x = val1 + val2 + rem
                    let val = x / 10
                    if val > 0 {
                        sum += "\(val)"
                    }
                    rem = x % 10
                }
                count -= 1
            }
            
            if count >= 0 {
                rem = 0
                while count >= 0 {
                    if let val1 = Int(list2[count]) {
                        let x = val1 + rem
                        let val = x / 10
                        if val > 0 {
                            sum += "\(val)"
                        }
                        rem = x % 10
                    }
                    count -= 1
                }
            }
            return sum
        }
    }
    
    func findMaxNumber(str : String) -> Int {
        if !str.isEmpty {
            let list = str.findAllNumbers()
            var max = list[0].stringToInteger()
            var count = 1
            
            while count < list.count {
                let x = list[count]
                let val = x.stringToInteger()
                if val > max {
                    max = val
                }
                count += 1
            }
            return max
        }
        return -1
    }
    
    func sumOfIntegerInString(str : String) -> Int {
        
        let list = str.findAllNumbers()
        var sum = 0
        
        for val in list {
            sum += val.stringToInteger()
        }
        
        return sum
    }
    
    //Incomplete
    func substractionOfNumbers(str1 : String, str2 : String) -> String {
        let intlist1 = str1.compactMap { Int(String($0)) }
        let intlist2 = str2.compactMap { Int(String($0)) }
        let upperList = intlist1.count > intlist2.count ? intlist1 : intlist2
        let downList = intlist1.count < intlist2.count ? intlist1 : intlist2
        var upperCount = upperList.count - 1
        var downCount = downList.count - 1
        var result = ""
        var remainder = 10
        var carryUsed = false
        
        while upperCount >= 0 {
            
            var first = upperList[upperCount]
            let second = downList[downCount]
            
            if carryUsed {
                if first == 0 {
                    first = remainder
                }
                carryUsed = false
            }
            else {
                
            }
            
            if first > second {
                result = "\(first - second)" + result
            }
            else {
                let val = remainder + first - second
                result = "\(val)" + result
                remainder -= 1
                carryUsed = true
            }
            
            upperCount -= 1
            downCount -= 1
        }
        
        if upperCount >= 0 {
            while upperCount >= 0 {
                
            }
        }
        return result
    }
}
