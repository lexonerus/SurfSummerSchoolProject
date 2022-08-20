//
//  String+PhoneMasking.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import Foundation

extension String {
    
    func phoneMasking(pattern: String, replacementCharacter: Character) -> String {
        var maskedNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < maskedNumber.count else { return maskedNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            maskedNumber.insert(patternCharacter, at: stringIndex)
        }
        return maskedNumber
    }
    
}
