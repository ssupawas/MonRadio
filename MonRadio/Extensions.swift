//
//  Extensions.swift
//  Extensions
//
//  Created by Wittaya Malaratn on 6/7/18.
//  Copyright © 2018 Wittaya Malaratn. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    
    @IBInspectable var trackHeight: CGFloat = 7
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
    
}

extension UIView {
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        
        _ = anchorPositionReturn(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
        
    }
    
    func anchorPositionReturn(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint]{
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
        
    }
    
}

extension UIColor {
    
    static func whiteAlpha(alpha: CGFloat) -> UIColor {
        return UIColor(white: 1, alpha: alpha)
    }
    
    static func blackAlpha(alpha: CGFloat) -> UIColor {
        return UIColor(white: 0, alpha: alpha)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static var jetBlack = UIColor.rgb(red: 33, green: 45, blue: 79)
    static var gold = UIColor.rgb(red: 255, green: 182, blue: 0)
    static var kelly = UIColor.rgb(red: 0, green: 206, blue: 62)
    static var mediumBlue = UIColor.rgb(red: 0, green: 122, blue: 255)
    static var rosePink = UIColor.rgb(red: 255, green: 193, blue: 224)
    static var navy = UIColor.rgb(red: 66, green: 66, blue: 136)
    static var emerald = UIColor.rgb(red: 0, green: 222, blue: 182)
    static var lolipop = UIColor.rgb(red: 143, green: 20, blue: 108)
    static var ruby = UIColor.rgb(red: 235, green: 42, blue: 117)
    
}

extension UIFont {
    
    static func PoppinsBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size)!
    }
    
    static func PoppinsMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size)!
    }
    
    static func PoppinsMediumItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-MediumItalic", size: size)!
    }
    
    static func PoppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size)!
    }
    
    static func PoppinsLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size)!
    }
    static func KanitLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Kanit-Light", size: size)!
    }
    static func KanitMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Kanit-Medium", size: size)!
    }
}
