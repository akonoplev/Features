//
//  CardsViewController.swift
//  myCustomTransition
//
//  Created by User on 12/04/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    var pageIndex: Int?
    var number : Int?
    
    @IBOutlet weak var cardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let number = number else { return }
        numberLabel.text = String(number)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segueIdentifier(for: segue) == .reveal {
            let destination = segue.destination as? RevaelViewController
            destination?.num = self.number
            destination?.transitioningDelegate = self
        }
    }


    @IBAction func tapToSegue(_ sender: Any) {
        performSegue(withIdentifier: .reveal, sender: nil)
    }
}

extension CardsViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case reveal
    }
}

extension CardsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlipPresentAnimationController(originFrame: cardView.frame)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            guard let revaelVC = dismissed as? RevaelViewController else {
                return nil
            }
            return FlipDismissViewController(destinationFrame: cardView.frame, interactionController: revaelVC.interactionTransitionController!)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? FlipDismissViewController,
            let interactorController = animator.interactionController,
            interactorController.interactionInProgress
            else { return nil}
        return interactorController
    }
}
