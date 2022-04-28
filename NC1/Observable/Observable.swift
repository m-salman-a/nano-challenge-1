//
//  WishItemsObservable.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

class Observable {
    
    private lazy var observers = [Observer]()
    
    func notifyListeners() {
        observers.forEach {
            $0.update(with: self)
        }
    }
    
    func addListener(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeListener(_ observer: Observer) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
}
