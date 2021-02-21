//
//  TestSwift.swift
//  DSA
//
//  Created by Nishit on 18/02/21.
//  Copyright © 2021 Mine. All rights reserved.
//

import Foundation


class SomeClass: SomeProtocol {
    required convenience init(someParameter: Int) {
        // initializer implementation goes here
        self.init()
    }
    init() {
        let session = URLSession.shared.downloadTask(with: URLRequest(url: URL(string: "")!))
        
    }
}

class SomeSubClass: SomeClass {
    required convenience init(someParameter: Int) {
        // initializer implementation goes here
        self.init()
        let x: SomeProtocol1 = SomeSubClass1()
        
    }
}

protocol SomeProtocol {
    init(someParameter: Int)
}

protocol SomeProtocol1 {
}


class SomeClass1: SomeProtocol1 {
    init(x: Int, y: Int) {
        // initializer implementation goes here
    }
    init() {
        
    }
}

class SomeSubClass1: SomeClass1 {
    override init() {
        super.init(x: 0, y:0)
    }
    
    required init(someParameter: Int) {
        fatalError("init(someParameter:) has not been implemented")
    }
}
