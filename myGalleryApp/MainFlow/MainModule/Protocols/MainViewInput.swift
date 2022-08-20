//
//  MainViewInput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation

protocol MainViewInput: AnyObject {
    func updateCollection()
    func startLoading()
    func stopLoading()
    func showErrorState()
    func endRefreshControl()
}
