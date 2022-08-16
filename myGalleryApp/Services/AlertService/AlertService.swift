//
//  AlertService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 16.08.2022.
//

import UIKit

struct AlertService {
    static func createTwoButtonsAlert(title: String, message: String, okButtonTitle: String, cancelButtonTitle: String, okAction: @escaping ()->Void, cancelAction: @escaping ()->Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okButtonTitle, style: .default, handler: { action in
            okAction()
        })
        let cancel = UIAlertAction(title: cancelButtonTitle, style: .default, handler: { action in
            cancelAction()
        })
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        alert.preferredAction = ok
        
        return alert
    }
}
