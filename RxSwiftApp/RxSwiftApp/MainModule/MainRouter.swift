//
//  MainRouter.swift
//  RxSwiftApp
//
//  Created by Андрей Коноплев on 28.07.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import UIKit

class MainRouter {
    enum destination {
        case first
        case second
    }
    
    private enum storyboards {
        static let first = UIStoryboard.create(.first)
        static let second = UIStoryboard.create(.second)
    }
    
    //Navigation
    public func navigateModally(to destination: destination, navigationController: UINavigationController) {
        let viewController = makeViewController(for: destination)
        let navController = UINavigationController()
        navController.pushViewController(viewController, animated: false)
        navigationController.present(navController, animated: false, completion: nil)
    }
    
    public func navigate(to destination: destination, navigationController: UINavigationController) {
        let vc = makeViewController(for: destination)
        navigationController.pushViewController(vc, animated: true)
    }
    
    public func makeViewController(for destination: destination)-> UIViewController {
        switch destination {
        case .first:
            return createFirstModulVC()
        case .second:
            return createSecondModuleVC()
        }
    }
    
}

extension MainRouter {
    public func createFirstModulVC()-> UIViewController {
        let vc = storyboards.first.instantiateViewController(withIdentifier: "firstModuleStoryboard") as! FirstModuleStartVC
        return vc
    }
    
    public func createSecondModuleVC()-> UIViewController {
        return UIViewController()
    }
}
