//
//  Color+Extension.swift
//  CoolSlots
//
//  Created by Eric Shema on 03/10/2023.
//

import Foundation
import UIKit

extension UIColor {
    static let goldColor = UIColor(hex: "FFD700")
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
    
    static func slotBackground() -> UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        gradientLayer.colors = [
            UIColor(red: 2/255.0, green: 0/255.0, blue: 36/255.0, alpha: 1).cgColor,
            UIColor(red: 45/255.0, green: 71/255.0, blue: 113/255.0, alpha: 1).cgColor,
            UIColor(red: 25/255.0, green: 47/255.0, blue: 51/255.0, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.55, 1.0]
        
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return UIColor(patternImage: image)
            }
        }
        return .clear
    }
}
