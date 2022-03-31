//
//  ETPLFont.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

//let FONT_LOGO = "Rostov"
//let FONT_ROBOTO_BLACK = "Roboto-Black"
//let FONT_ROBOTO_BOLD = "Roboto-Bold"
//let FONT_ROBOTO_LIGHT = "Roboto-Light"
//let FONT_ROBOTO_MEDIUM = "Roboto-Medium"
//let FONT_ROBOTO_REGULAR = "Roboto-Regular"
//let FONT_ROBOTO_THIN = "Roboto-Thin"

let FONT_ENGCARNATION_THIN = "engcarnation"

let FONT_SIZE_LOGO:CGFloat      = ( UtilityManager.isIphone() ?  60 : 60)
let FONT_SIZE_SMALLEST:CGFloat  = ( UtilityManager.isIphone() ?  10 : 16)
let FONT_SIZE_SMALL:CGFloat     = ( UtilityManager.isIphone() ?  12 : 18)
let FONT_SIZE_REGULAR:CGFloat   = ( UtilityManager.isIphone() ?  14 : 20)
let FONT_SIZE_MEDIUM:CGFloat    = ( UtilityManager.isIphone() ?  16 : 22)
let FONT_SIZE_BIG:CGFloat       = ( UtilityManager.isIphone() ?  18 : 20)
let FONT_SIZE_BIGGEST:CGFloat   = ( UtilityManager.isIphone() ?  21 : 29)

let TEXTFEILD_FONT_SIZE:CGFloat = ( UtilityManager.isIphone() ?  12 : 22 )
let BUTTON_FONT_SIZE:CGFloat    = ( UtilityManager.isIphone() ?  15 : 25 )

extension UIFont
{
    static func LOGO_FONT() -> (UIFont)
    {
        return UIFont(name: FONT_ENGCARNATION_THIN, size: FONT_SIZE_LOGO)!
    }
    
    static func TEXTFIELD_FONT() -> (UIFont)
    {
        return UIFont.REGULAR_FONT(size: TEXTFEILD_FONT_SIZE)
    }
    
    static func BUTTON_FONT() -> (UIFont)
    {
        return (UtilityManager.isIphone() ? UIFont.REGULAR_FONT_MEDIUM() : UIFont.REGULAR_FONT_MEDIUM())
    }
    
    static func REGULAR_FONT(size:CGFloat) -> (UIFont)
    {
        return UIFont(name: FONT_ENGCARNATION_THIN, size: size)!
    }
    
    static func REGULAR_FONT() -> (UIFont)
    {
        return UIFont(name: FONT_ENGCARNATION_THIN, size: FONT_SIZE_REGULAR)!
    }
    
    static func REGULAR_FONT_SMALLEST() -> (UIFont)
    {
        return UIFont(name: FONT_ENGCARNATION_THIN, size: FONT_SIZE_SMALLEST)!
    }
    
    static func REGULAR_FONT_SMALL() -> (UIFont)
    {
        return UIFont(name: FONT_ENGCARNATION_THIN, size: FONT_SIZE_SMALL)!
    }
    
    static func REGULAR_FONT_MEDIUM() -> (UIFont)
    {
        return UIFont(name: FONT_ENGCARNATION_THIN, size: FONT_SIZE_MEDIUM)!
    }
    
    static func REGULAR_FONT_BIG() -> (UIFont)
    {
        return UIFont( name: FONT_ENGCARNATION_THIN , size: FONT_SIZE_BIG)!
    }
    
    static func FONT_NAVIGATION_TITLE() -> (UIFont)
    {
        return UIFont( name:FONT_ENGCARNATION_THIN , size: FONT_SIZE_BIG)!
    }
    
    static func FONT_BUTTON() -> (UIFont)
    {
        return UIFont( name:FONT_ENGCARNATION_THIN , size: FONT_SIZE_MEDIUM)!
    }
    
    static func BOLD_FONT(size:CGFloat) -> (UIFont)
    {
        return UIFont( name: FONT_ENGCARNATION_THIN , size:size)!
    }
    
    static func BOLD_FONT() -> (UIFont)
    {
        return UIFont( name: FONT_ENGCARNATION_THIN, size: FONT_SIZE_REGULAR)!
    }
    
    static func BOLD_FONT_SMALLEST() -> (UIFont)
    {
        return UIFont( name: FONT_ENGCARNATION_THIN , size: FONT_SIZE_SMALLEST)!
    }
    
    
    static func BOLD_FONT_SMALL() -> (UIFont)
    {
        return UIFont( name: FONT_ENGCARNATION_THIN , size: FONT_SIZE_SMALL)!
    }
    
    static func BOLD_FONT_MEDIUM() -> (UIFont)
    {
        return UIFont( name: FONT_ENGCARNATION_THIN , size: FONT_SIZE_MEDIUM)!
    }
    
    static func BOLD_FONT_BIG() -> (UIFont)
    {
        return UIFont( name: FONT_ENGCARNATION_THIN , size: FONT_SIZE_BIG)!
    }
    
    static func NAVIGATION_TITLE_FONT() -> (UIFont)
    {
        return UIFont.BOLD_FONT()
    }
}

