//
//  MainEntry.swift
//  DSA
//
//  Created by Nishit on 21/02/21.
//  Copyright © 2021 Mine. All rights reserved.
//

import Foundation
import UIKit

@main
struct MainEntry {
    static func main() {
//        let topView = UIView()
//        let view1 = UIView()
//        view1.addSubview(UIView())
//        view1.addSubview(UIView())
//        let view2 = UIView()
//        let view3 = UIView()
//        view3.addSubview(UIView())
//        view3.addSubview(UIView())
//        view2.addSubview(view3)
//        view2.addSubview(UIView())
//        topView.addSubview(view1)
//        topView.addSubview(view2)
//        let x = topView.subViewString("")
//        
//        let y = ["1", "2"].customMap { (val) -> Int in
//            Int(val) ?? 0
//        }
//        download()
        
//        Problems.canThreePartsEqualSum([0,2,1,-6,6,-7,9,1,2,0,1])
        
//        let cls: AbstractProtocol = AbstractClass()
//        cls.save()
        
        Problems.uniquePermute([1,1,2])
    }
    
    
    
    static func deferTest() {
        defer {
            defer {
                print("C")
            }
            print("B")
        }
        print("A")
    }
    
    static func download() {
        let queue = DispatchQueue(label: "com.gcd.myQueue", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 3)
        for i in 0 ..< 15 {
           queue.async {
              let songNumber = i + 1
              semaphore.wait()
              print("Downloading song", songNumber)
              sleep(2) // Download take ~2 sec each
              print("Downloaded song", songNumber)
              semaphore.signal()
           }
        }
    }
}


protocol IDBManager {
    func saveData() -> Bool
}

class DBManager: IDBManager {
    func saveData() -> Bool {
        return false
    }
}

protocol AbstractProtocol {
    var dbHandler: IDBManager { get }
    func save()
    func beforeSave()
    func afterSave()
    func failedSave()
}

extension AbstractProtocol {
    func save() {
        beforeSave()
        if dbHandler.saveData() {
            afterSave()
        } else {
            failedSave()
        }
    }
}

class AbstractClass {
    var dbHandler: IDBManager = DBManager()
    
    func beforeSave() {
        print("beforeSave")
    }
    
     @objc func afterSave() {
        print("afterSave")
    }
    
    func failedSave() {
        print("failedSave")
    }
}

extension AbstractClass {
//    override func afterSave() {
//        
//    }
}

extension UITextField {
    open override func cut(_ sender: Any?) {
        
    }
}
