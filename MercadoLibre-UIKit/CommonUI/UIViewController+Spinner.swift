//
//  UIViewController+Spinner.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

var vSpinner: [UIView] = []

extension UIViewController {
        
    func showSpinner(onView: UIView) {
        let spinnerView = UIView(frame: onView.bounds)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        activityIndicator.color = .lightGray
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        vSpinner.append(spinnerView)
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner.popLast()?.removeFromSuperview()
        }
    }
    
}
