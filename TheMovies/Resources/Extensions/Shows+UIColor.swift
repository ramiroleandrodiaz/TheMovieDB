//
//  Shows+UIColor.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 16/08/2023.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func iceBlue() -> UIColor {
        return UIColor(hex: "#e1f5ff")
    }
    
    class func dark() -> UIColor {
        return UIColor(hex: "#1e2b31")
    }
    
    class func blackTwo() -> UIColor {
        return UIColor(hex: "#1b1b1b")
    }
    
    class func slate() -> UIColor {
        return UIColor(hex: "#3c5663")
    }
    
    class func darkSlate() -> UIColor {
        return UIColor(hex: "#091920")
    }
    
    class func detailBackgroundColor() -> UIColor {
        return UIColor(hex: "#f0b932")
    }
    
    class func overviewBlack() -> UIColor {
        return UIColor(hex: "#383838")
    }
    
}
