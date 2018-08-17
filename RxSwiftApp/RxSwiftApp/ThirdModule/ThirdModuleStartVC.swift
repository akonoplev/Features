//
//  ThirdModuleStartVC.swift
//  RxSwiftApp
//
//  Created by Андрей Коноплев on 17/08/2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import RxSwift

class ThirdModuleStartVC: UIViewController {

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private let bag = DisposeBag()
    private let images = Variable<[UIImage]>([])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.asObservable().subscribe(onNext: { [weak self] (photos) in
            guard let preview = self?.previewImage else { return }
            preview.image = UIImage.collage(images: photos, size: preview.frame.size)
        }).disposed(by: bag)
    }
    
    @IBAction func actionAdd() {
        images.value.append(UIImage(named: "rio")!)
    }
    
    @IBAction func actionClear() {
        images.value = []
    }
    

}
