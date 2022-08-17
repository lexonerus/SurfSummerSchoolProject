//
//  Date+Formatter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import Foundation


extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

