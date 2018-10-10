//
//  ViewController.swift
//  PluralLayout
//
//  Created by Андрей Коноплев on 10/10/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import PureLayout

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpButton()
    }
    
    func setUpButton() {
        let button = UIButton(forAutoLayout: ())
        button.backgroundColor = UIColor.black
        button.setTitle("А Б В Г Д", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.view.addSubview(button)
        button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 30, height: 60))
        button.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        button.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = "\(indexPath.row)"
    }
}

