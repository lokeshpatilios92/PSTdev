//
//  ETPLColor.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

extension UIColor
{
    // MARK: Set All App colors here
    static func hexStringToUIColor(hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#"))
        {
            cString.remove(at:cString.startIndex)
        }
        
        if ((cString.count) != 6)
        {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    static func shadowColor() -> UIColor
    {
        return UIColor(red: 220/255, green: 221/255, blue: 223/255, alpha: 1.0)
    }
    
    static func backgroundColor() -> UIColor {
        return hexStringToUIColor(hex: "#ebebeb")
    }

    static func seperatorColor() -> UIColor{
        return UIColor.shadowColor()
    }
    
    static func placeholderColor() -> UIColor {
        return hexStringToUIColor(hex: "#565c61")
    }
    
    
    //    MARK: ************** PrepSmart **************
    //    Orange color :- #ef4f23
    //    Gray color  :- #f2f2f2
    
    //    All Text color
    //    Dark text color :-  #4a4a4a
    //    light gray text color :-  #a4a4a4
    
    static func textColorLightGray() -> UIColor {
        return hexStringToUIColor(hex: "#a4a4a4")
    }
    
    static func textColorDarkGray() -> UIColor {
        return hexStringToUIColor(hex: "#4a4a4a")
    }
    
    static func textColor() -> UIColor {
        return textColorDarkGray()
    }
    
    static func appGoogleButtonColor() -> UIColor {
        return hexStringToUIColor(hex: "#d34836")//FF4500")
    }
    
    static func appFacebookButtonColor() -> UIColor {
        return hexStringToUIColor(hex: "#3b5998")
    }
    
    static func appOrangeColor() -> UIColor {
        return hexStringToUIColor(hex: "#ef4f23")
    }
    
    static func appGrayColor() -> UIColor {
        return hexStringToUIColor(hex: "#f2f2f2")
    }

}
