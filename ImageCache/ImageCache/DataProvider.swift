//
//  DataProvider.swift
//  ImageCache
//
//  Created by Андрей Коноплев on 21/08/2018.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

class DataProvider {
    
    //NSString - is class
    //String - is struct
    
    
    var imageCache = NSCache<NSString, UIImage>()
    func downloadImage(url: URL, success: @escaping (UIImage?)-> Void) {
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) {
            success(cacheImage)
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil, data != nil,
            let response = response as? HTTPURLResponse,
             response.statusCode == 200 else { return }
            
            guard let image = UIImage(data: data!) else { return }
            
            self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                success(image)
            }
        }
        dataTask.resume()
    }
}
