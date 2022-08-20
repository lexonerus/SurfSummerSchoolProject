//
//  ProfileViewOutput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 19.08.2022.
//

import Foundation

protocol ProfileViewOutput: AnyObject {
    func logout()
    func getAvatar()    -> String
    func getName()      -> String
    func getStatus()    -> String
    func getCity()      -> String
    func getPhone()     -> String
    func getEmail()     -> String
}
