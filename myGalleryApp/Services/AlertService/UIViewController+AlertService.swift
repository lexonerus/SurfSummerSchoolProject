//
//  UIViewController+AlertService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 16.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okButtonTitle: String, cancelButtonTitle: String, okAction: (), cancelAction: ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okButtonTitle, style: .default, handler: { action in
            okAction
        })
        let cancel = UIAlertAction(title: cancelButtonTitle, style: .default, handler: { action in
            cancelAction
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })

    }
}
