//
//  ObserversArray.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 30.12.2020.
//

import Foundation

final class ObserversArray<T> {
    
    var values: [T] {
        return weakPointers.compactMap { $0.value }
    }

    func add(observer: T) {
        weakPointers.append(Weak(observer))
    }

    func remove(observer: T) {
        weakPointers = weakPointers.filter { ($0.value as AnyObject) !== (observer as AnyObject) }
    }

    func removeAll() {
        weakPointers.removeAll()
    }

    func invoke(invocation: (T) -> Void) {
        weakPointers = weakPointers.filter { $0.value != nil }
        weakPointers.forEach { $0.value.map { invocation($0) } }
    }

    private var weakPointers = [Weak<T>]()
}

struct Weak<Wrapped> {
    
    var value: Wrapped? {
        return storedValue as? Wrapped
    }
    
    init(_ value: Wrapped) {
        self.storedValue = value as AnyObject
    }
    
    private weak var storedValue: AnyObject?
}
