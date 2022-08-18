//
//  LoginPageViewOutput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import Foundation

protocol LoginPageViewOutput: AnyObject {
    func login()
    func setPhoneNumber(phone: String)
    func setPassword(password: String)
}
