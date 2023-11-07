//
//  Utilities.swift
//  CoolSlots
//
//  Created by Eric Shema on 03/11/2023.
//

import Foundation

class Utilities {
    
    static func formatNumberWithCommas(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        
        if let formattedValue = formatter.string(from: NSNumber(value: number)) {
            return formattedValue
        }
        
        return "\(number)"
    }
    
}
