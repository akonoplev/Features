//
//  ViewController.swift
//  Multithreading
//
//  Created by Андрей Коноплев on 21/08/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class CreateThreadsVC: UIViewController {
    
    private var mutex = pthread_mutex_t()
    private var lock = NSLock()
    
    private let recursiveMutex = RecursiveMutexUnix()
    private let recursiveMutexFoun = RecursiveMutexFoundation()

    override func viewDidLoad() {
        super.viewDidLoad()
        pthread_mutex_init(&mutex, nil)
        recursiveMutex.test1()
        recursiveMutexFoun.test1()
        
//        makeUnixThread()
//        createThread()
//        createThreadWithQOS()
    }
    
    func makeUnixThread() {
        var thread = pthread_t(bitPattern: 0)
        var attr = pthread_attr_t()
        
        pthread_attr_init(&attr)
        pthread_create(&thread, &attr, { (pointer) -> UnsafeMutableRawPointer? in
            print("unix thread was started")
            return nil
        }, nil)
    }
    
    func createThread() {
        let nsthread = Thread {
            print("objc wrapper thread")
        }
        nsthread.start()
    }
    
    func makeUnixThreadwithQOS() {
        var thread = pthread_t(bitPattern: 0)
        var attr = pthread_attr_t()
        pthread_attr_init(&attr)
        pthread_attr_set_qos_class_np(&attr, QOS_CLASS_UTILITY, 0)
        pthread_create(&thread, &attr, { (pointer) -> UnsafeMutableRawPointer? in
            print("unix thread was started in utility qos")
            print("change qos to background")
            pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
            return nil
        }, nil)
    }
    
    func createThreadWithQOS() {
        let thread = Thread {
            print("test")
            print(qos_class_self())
        }
        
        thread.qualityOfService = .userInteractive
        thread.start()
        print(qos_class_main())
    }
    
    func unixThreadMutex() {
        pthread_mutex_lock(&mutex)
        //Do something
        pthread_mutex_unlock(&mutex)
    }
    
    func mutexFoundation() {
        self.lock.lock()
        //Do something
        self.lock.unlock()
    }

}

//recursive
class RecursiveMutexUnix {
    private var mutex = pthread_mutex_t()
    private var attr = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attr)
    }
    
    func test1() {
        pthread_mutex_lock(&mutex)
        test2()
        pthread_mutex_unlock(&mutex)
    }
    
    func test2() {
        pthread_mutex_lock(&mutex)
        //Do something
        print("УРа")
        pthread_mutex_unlock(&mutex)
    }
}

class RecursiveMutexFoundation {
    private var lock = NSRecursiveLock()
    
    func test1() {
        self.lock.lock()
        test2()
        self.lock.unlock()
    }
    
    func test2() {
        self.lock.lock()
        print("yeah")
        self.lock.unlock()
        
    }
}

//Condition
class ConditionMutex {
    private let condition = NSCondition()
    private var check: Bool = false
    
    func test1() {
        condition.lock()
        while(!check) {
            condition.wait()
        }
        condition.unlock()
    }
    
    func test2() {
        condition.lock()
        check = true
        condition.signal()
        condition.unlock()
    }
}

//ReadWrite lock only unix realization
class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attr = pthread_rwlockattr_t()
    
    var num: Int = 0
    
    init() {
        pthread_rwlock_init(&lock, &attr)
    }
    
    var testProperty: Int {
        get {
            pthread_rwlock_rdlock(&lock)
            let tmp = num
            pthread_rwlock_unlock(&lock)
            return tmp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            num = newValue
            pthread_rwlock_unlock(&lock)
            
        }
    }
}
