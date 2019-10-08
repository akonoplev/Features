//
//  main.swift
//  Observable
//
//  Created by Andrei Konoplev on 07/06/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation

final class Observable<T> {
    typealias Observer = (T)-> Void

    private var observers: [Int: Observer] = [:]
    private var uniqueID = (0...).makeIterator()

    var value: T {
        didSet {
            observers.values.forEach({ $0(value) })
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    func observeSkippedFirst(_ observe: @escaping Observer)-> Disposable {
        return makeObserve(skipFirst: true, observe)
    }
    
    func removeAll()-> Void {
        observers.removeAll()
    }
}

private extension Observable {
    func makeObserve(skipFirst: Bool,_ observer: @escaping Observer)-> Disposable {
        guard let id = uniqueID.next() else {
            fatalError("Все айдишники кончились")
        }
        
        observers[id] = observer
        
        if !skipFirst {
            observer(value)
        }
        
        let disposable = Disposable { [weak self] in
            self?.observers[id] = nil
        }
        
        return disposable
    }
}

//MARL: Disposable

typealias Disposal = [Disposable]

final class Disposable {
    private let dispose: ()-> Void
    
    init(_ dispose: @escaping ()-> Void) {
        self.dispose = dispose
    }
    
    deinit {
        dispose()
    }
    
    func add(to disposal: inout Disposal) {
        disposal.append(self)
    }
}

var disposeBag = Disposal()

var a = Observable("Привет")
let b = Observable("Как дела")
let aDis = a.makeObserve(skipFirst: false) { (string) in
    print(string)
}

a.value = "ooo"
a.value = "aaa"
a.value = "ddd"
