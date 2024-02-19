//
//  ImageService.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

final class ImageService {
    
    private var images = NSCache<NSString, NSData>()

    // MARK: - Public API
    
    func image(for url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        if let imageData = images.object(forKey: url.absoluteString as NSString) {
            print("Using cached images")
            
            guard let image = UIImage(data: imageData as Data) else { return }
            completionHandler(image)
            
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            
            var image: UIImage?

            defer {
                
                DispatchQueue.main.async {
                    completionHandler(image)
                }
            }

            if let data = data {
                self.images.setObject(data as NSData, forKey: url.absoluteString as NSString)
                image = UIImage(data: data)
            }
        }
        dataTask.resume()
    }

}
