//
//  Observer.swift
//  SomePractice
//
//  Created by Nishit on 10/12/20.
//

import Foundation

private class ObserverInfo {
	fileprivate weak var value: AnyObject?
	fileprivate let method: () -> Void
	init(value: AnyObject, completion: @escaping () -> Void) {
		self.value = value
		self.method = completion
	}
}

final class Observer {
	
	static let shared = Observer()
	
	private init() {}
	
	private var map = [String: [ObserverInfo]]()
	
	private let queue = DispatchQueue(label: "Observer Queue", qos: .utility, attributes: .concurrent)
	func add(_ observer: AnyObject, _ key: String, _ completion: @escaping () -> Void) {
		syncronized { [weak self] in
			let observerInfo = ObserverInfo(value: observer, completion: completion)
			if var val = self?.map[key] {
				val.append(observerInfo)
				self?.map[key] = val
			}
			else {
				self?.map[key] = [observerInfo]
			}
		}
	}
	
	func notify(_ key: String) {
		var callBackList = [() -> Void]()
		
		syncronized { [weak self] in
			if let val = self?.map[key] {
				let temp = val.filter { (info) -> Bool in
					info.value != nil
				}

				for item in temp {
					if let _ = item.value {
						callBackList.append(item.method)
					}
				}
				self?.map[key] = temp
			}
		}
		
		callBackList.forEach { (item) in
			DispatchQueue.global(qos: .utility).async {
				DispatchQueue.main.async {
					item()
				}
			}
		}
	}
	
	func removeObserver<Element: AnyObject>(_ key: String, _ observer: Element) {
		syncronized { [weak self] in
			if let val = self?.map[key] {
				let temp = val.filter { (item) -> Bool in
					item.value !== observer
				}
				self?.map[key] = temp
			}
		}
	}
	
	private func syncronized(_ f: @escaping () -> Void) {
        queue.sync(execute: f)
	}
}

