//
//  View+Addition.swift
//  DSA
//
//  Created by Nishit on 04/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation
import UIKit

struct SwizzleView {
    static var swizzle: Bool = false {
        didSet {
            UIView.swizzle()
        }
    }
}

extension UIView {
    class func swizzle() {
        struct Swizzle {
            static var once = false
        }
        guard !Swizzle.once else {
            return
        }
        
        Swizzle.once = true
        method_exchangeImplementations(class_getInstanceMethod(self, #selector(hitTest(_:with:)))!, class_getInstanceMethod(self, #selector(swizzledHittest(_:with:)))!)
    }
    
    @objc func swizzledHittest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isHidden && self.isUserInteractionEnabled && self.alpha > 0.01 && self.point(inside: point, with: event) {
            let subViews = self.subviews
            var i = subViews.count - 1
            while i >= 0 {
                let view = subviews[i]
                i -= 1
                let point = view.convert(point, from: self)
                let foundView = view.swizzledHittest(point, with: event)
                if foundView != nil {
                    return foundView
                }
            }
            return self
        }
        return nil
    }
}

extension UIView {
    func findAncesstor(_ otherView: UIView) -> UIView? {
        var a: UIView? = self
        var b: UIView? = otherView
        var set = Set<UIView>()
        
        while a != nil || b != nil {
            if let x = a, !set.contains(x) {
                set.insert(x)
            }
            else {
                return a
            }
            
            if let y = b, !set.contains(y) {
                set.insert(y)
            }
            else {
                return b
            }
            
            a = a?.superview
            b = b?.superview
        }
        return nil
    }
    
    func subViewString(_ sep: String) -> String {
        var res = sep + self.description
        for view in self.subviews {
            if view.subviews.count > 0 {
                let y = sep + "|"
                let x = view.subViewString(y)
                res += x
            }
            else {
                res += sep + "|" + view.description
            }
        }
        return res
    }
    
    func getSubViews() {
        let x = subViewString("")
        print(x)
    }
}

struct View {
    func findCommonAncesstor(_ view1: UIView?, _ view2: UIView?) -> UIView? {
        if view1 != nil {
            return view1
        }
        else if view2 != nil {
            return view2
        }
        else if view1 == view2 {
            return view1
        }
        else {
            return findCommonAncesstor(view1?.superview, view2?.superview)
        }
    }
}
