//
//  ViewController.swift
//  myCustomTransition
//
//  Created by User on 12/04/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    private let numbers = [3,13,15,19,25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setViewControllers([viewControllerForPage(at: 0)], direction: .forward, animated: false, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CardsViewController,
            let pageIndex = viewController.pageIndex,
            pageIndex > 0 else {
                return nil
        }
        return viewControllerForPage(at: pageIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CardsViewController,
            let pageIndex = viewController.pageIndex,
            pageIndex + 1 < numbers.count else {
                return nil
        }
        return viewControllerForPage(at: pageIndex + 1)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return numbers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let viewControllers = pageViewController.viewControllers,
            let currentVC = viewControllers.first as? CardsViewController,
            let currentPageIndex = currentVC.pageIndex else {
                return 0
        }
        return currentPageIndex
    }
    
    
}
extension PageViewController {
    private func viewControllerForPage(at index: Int) -> UIViewController {
        let cardViewController: CardsViewController = UIStoryboard(storyboard: .main).instantiateViewController()
        cardViewController.pageIndex = index
        cardViewController.number = numbers[index]
        return cardViewController
    }
}
