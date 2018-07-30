//
//  FirstModuleStartVC.swift
//  RxSwiftApp
//
//  Created by Андрей Коноплев on 28.07.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import RxSwift

class FirstModuleStartVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Rx First Module"
//        example(of: "one, of, from") {
//            let one = 1
//            let two = 2
//            let three = 3
//
//            //operators
////            let observable: Observable<Int> = Observable<Int>.just(one)
////
////            let observable2 = Observable.of(one, two, three)
////
////            let observable3 = Observable.of([one, two, three])
////
////            let observable4 = Observable.from([one,two,three])
//        }
        
//        example(of: "subscribe") {
//            let one = 1
//            let two = 2
//            let three = 3
//
//            let observable = Observable.of(one, two, three)
//            observable.subscribe({ (event) in
//                print(event)
//
//                if let element = event.element {
//                    print(element)
//                }
//            })
//            //short
//            observable.subscribe(onNext: { (element) in
//                print(element)
//            })
//
//
//            let emptyObserable = Observable<Void>.empty()
//            emptyObserable.subscribe(onNext: { (element) in
//                print(element)
//            }, onCompleted: {
//                print("completed")
//            })
//        }
        

//        let sequence = 0..<3
//        var iterator = sequence.makeIterator()
//        
//        while let n = iterator.next() {
//            print(n)
//        }
        
//        example(of: "never") {
//            let observable = Observable<Void>.never()
//
//            observable.subscribe(onNext: { (element) in
//                print(element)
//            }, onCompleted: {
//                print("completed")
//            })
//        }
        
//        example(of: "range") {
//            let observable = Observable<Int>.range(start: 0, count: 19)
//            observable.subscribe(onNext: { (element) in
//                let n = Double(element)
//                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
//                print(fibonacci)
//
//            })
//        }
        
        example(of: "dispose") {

            let observable = Observable.of(1, 2, 14)

            observable.subscribe(onNext: { (event) in
                print(event)

            }, onCompleted: {
                print("complete")
            })

            .dispose()
        }
        
        example(of: "DisposeBag") {
            let disposeBag = DisposeBag()
            
            Observable.of("A", "B", "C").subscribe {
                print($0)
            }
            
            .disposed(by: disposeBag)
        }
    }

    



    func example(of description: String, action: ()-> Void)-> Void {
        print("\(description)")
        action()
    }
}
