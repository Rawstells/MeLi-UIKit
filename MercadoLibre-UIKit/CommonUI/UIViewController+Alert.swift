//
//  UIViewController+Alert.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

extension UIViewController {
    func showAlert(error: String) {
        let alert  = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

