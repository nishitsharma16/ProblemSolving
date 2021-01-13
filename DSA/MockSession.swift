//
//  MockSession.swift
//  DSA
//
//  Created by Nishit on 12/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

protocol URLSessiontaskType {
    
}

class MockTask: URLSessiontaskType {
    
}

protocol URLSessionType {
    func dataTaskWith(_ requestPath: String, _ completion: @escaping (Data?, Error?) -> Void) -> MockTask?
}

class MockSession: URLSessionType {
    func dataTaskWith(_ requestPath: String, _ completion: @escaping (Data?, Error?) -> Void) -> MockTask? {
        let data = ["name" : "Nishit"]
        if let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) {
            DispatchQueue.main.asyncAfter(deadline: .init(uptimeNanoseconds: 10)) {
                completion(data, nil)
            }
        }
        return nil
    }
}
