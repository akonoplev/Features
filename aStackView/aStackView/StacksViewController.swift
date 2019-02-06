//
//  StacksViewController.swift
//  aStackView
//
//  Created by Коноплев Андрей on 05/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class StacksViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let collectionViewLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        self.collectionView.collectionViewLayout = collectionViewLayout
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        setupUI()
        
    }
    
    func setupUI()-> Void {
        self.collectionView.isScrollEnabled = false
    }
}

extension StacksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "title", for: indexPath) as! QuestionCell
        cell.configure(question: "", answer: "", indexPath: indexPath, delegate: self)
        return cell
    }
}

extension StacksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension StacksViewController: QuestionResolveDelegate {
    func didResolve(question: String, answer: String, indexPath: IndexPath) {
        let newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        print(newIndexPath)
        self.collectionView.scrollToItem(at: newIndexPath, at: .left, animated: true)
    }
    
    
}
