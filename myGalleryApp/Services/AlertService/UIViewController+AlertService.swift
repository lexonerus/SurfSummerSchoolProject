//
//  UIViewController+AlertService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 16.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(alert: UIAlertController) {
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
}
