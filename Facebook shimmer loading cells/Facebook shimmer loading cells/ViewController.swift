//
//  ViewController.swift
//  Facebook shimmer loading cells
//
//  Created by Андрей Коноплев on 09/08/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        Loader.addLoaderTo(self.tableView, unless: 1)
        //or loading use this for loading all cells
        //Loader.addLoaderTo(self.tableView, unless: nil)
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.loaded), userInfo: nil, repeats: false)
    }
    
    @objc func loaded() {
        Loader.removeLoaderFrom(self.tableView, unless: 1)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        return cell
    }
}

