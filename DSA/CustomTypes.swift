//
//  CustomTypes.swift
//  DSA
//
//  Created by Nishit on 15/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

private class NotificationInfo {
    let observer : NSObject
    let handler : ([AnyHashable : Any]) -> Void
    init(_ obs : NSObject, _ completion : @escaping ([AnyHashable : Any]) -> Void) {
        observer = obs
        handler = completion
    }
}

final class CustomNotificationCenter {
    
    static let defaultCenter = CustomNotificationCenter()
    private var info = [String : [NotificationInfo]]()
    private init() {
        
    }
    
    func addObserver(observer : NSObject, notificationKey : String, handler : @escaping ([AnyHashable : Any]) -> Void) {
        let obc = NotificationInfo(observer, handler)
        if var list = info[notificationKey] {
            list.append(obc)
            info[notificationKey] = list
        }
        else {
            info[notificationKey] = [obc]
        }
    }
    
    func postNotification(key : String) {
        if let list = info[key] {
            for item in list {
                item.handler([:])
            }
        }
    }
    
    func removeObserver(observer : NSObject) {
        for item in info {
            var list = item.value
            for index in 0..<list.count {
                let val = list[index]
                if val.observer == observer {
                    list.remove(at: index)
                }
            }
            info[item.key] = list
        }
    }
}
