//
//  ViewController.swift
//  Decodable
//
//  Created by User on 15/06/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = URL(string: "https://api.flickr.com/services/rest/?api_key=aa0d8bc526d857a0ec0f10bab4ab3c83&method=flickr.interestingness.getList&format=json&per_page=50&extras=date_upload%2Cowner_name%2Curl_m&nojsoncallback=1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //parseDataStandart()
        decodabelParseData()
    }
}

//MARK: - standart method
extension ViewController {
    
    //swift 2/3/objC
    func parseDataStandart() {
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)

            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                guard let jsonPhotos = json["photos"] as? [String: Any] else { return }
                guard let photos = jsonPhotos["photo"] as? NSArray else { return }
                guard let photo = photos[0] as? [String: Any] else { return }
                //let model = Model(json: photo)
                //print(model)
            } catch let jsonErr {
               print(jsonErr)
            }
            }.resume()
    }
}

//MARK: - decodable parse data
extension ViewController {
    //swift4
    func decodabelParseData() {
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let model = try JSONDecoder().decode(RawServerResponse.self, from: data)
                print(model)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

