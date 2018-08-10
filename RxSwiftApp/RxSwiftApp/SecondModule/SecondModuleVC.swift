//
//  SecondModuleVC.swift
//  RxSwiftApp
//
//  Created by Андрей Коноплев on 05.08.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import RxSwift

class SecondModuleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        doThis()
    }
    
    
    
    func doThis() {
//        example(to: "PublishSubject") {
//            let subject = PublishSubject<String>()
//
//            subject.onNext("Is anyone listening")
//
//            let subscriptionOne = subject.subscribe(onNext: { (observer) in
//                print(observer)
//            })
//
//            subject.on(.next("1"))
//            subject.on(.next("2"))
//
//            let subscriptionTwo = subject.subscribe({ event in
//                print("2)", event.element ?? event)
//            })
//
//            subject.on(.next("3 suka"))
//
//            subscriptionOne.dispose()
//
//            subject.on(.next("4 blet"))
//
//            subject.onCompleted()
//
//            subject.onNext("this is war")
//
//            subscriptionTwo.dispose()
//
//            let disposeBag = DisposeBag()
//
//            subject.subscribe({ (event) in
//                print("3)", event.element ?? event)
//            }).disposed(by: disposeBag)
//
//            subject.onNext("????????")
//        }
        
//        enum MyError: Error {
//            case andreyError
//        }
//
//        func prints<T: CustomStringConvertible>(label: String, event: Event<T>) {
//            if event.element == nil {
//                print(event.error)
//            } else if event.error == nil {
//                print(event.element!)
//            } else {
//               print(event)
//            }
//        }
        
        //this subject send always initial or last event
//        example(to: "Behavior Subject") {
//            let subject = BehaviorSubject(value: "Initial value")
//            let disposeBag = DisposeBag()
//
//            subject.onNext("XXXX")
//
//            subject.subscribe({
//                prints(label: "1) ", event: $0)
//            }).disposed(by: disposeBag)
//
//            subject.onError(MyError.andreyError)
//
//            subject.subscribe({
//                prints(label: "2)", event: $0)
//            }).disposed(by: disposeBag)
//        }
    }

    func example(to description: String, action: ()-> Void)-> Void {
        print("----Example of: \(description)------")
        action()
    }
}
