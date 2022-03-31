//
//  KKTextFiled.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

class KKTextFiled: UITextField {
    var shouldLeaveMargin:Bool = true
    var canCopyPaste:Bool = false // true
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        self.initialize("",rightImageName: "")
    }
    
    init(frame:CGRect , leftImageName:String! , rightImageName:String! )
    {
        super.init(frame:frame)
        self.initialize(leftImageName , rightImageName: rightImageName)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.initialize("" , rightImageName:"")
    }
    
    func initialize( _ leftImageName:String! , rightImageName:String! )
    {
        self.textColor = UIColor.textColor()
        self.backgroundColor = UIColor.clear
        
        self.clearButtonMode = .always
        
        if( leftImageName != nil && leftImageName != "")
        {
            self.setLeftImageView(leftImageName)
        }
        
        if( rightImageName != nil && rightImageName != "")
        {
            self.setRightImageView(rightImageName)
        }
    }
  
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        return false
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        if( self.shouldLeaveMargin == false )
        {
            return super.textRect(forBounds: bounds)
        }
        
        super.textRect(forBounds: bounds)
        
        if ( self.leftView == nil && self.rightView == nil )
        {
            let rect = super.textRect(forBounds: bounds)
            return CGRect( x: UtilityManager.isIphone() ? 10:15 , y: rect.origin.y, width: rect.size.width , height: rect.size.height)
        }
        else if ( self.leftView != nil && self.rightView == nil )
        {
            let rect = super.textRect(forBounds: bounds)
            return CGRect( x: Constants.LEFT_VIEW_WIDTH + ( UtilityManager.isIphone() ? 10:15) , y: rect.origin.y, width: rect.size.width , height: rect.size.height)
        }
        else if ( self.leftView == nil && self.rightView != nil )
        {
            let rect = super.textRect(forBounds: bounds)
            return CGRect( x: UtilityManager.isIphone() ? 10:15 , y: rect.origin.y, width: rect.size.width - Constants.LEFT_VIEW_WIDTH , height: rect.size.height)
        }
        else
        {
            let rect = super.textRect(forBounds: bounds)
            return CGRect( x: Constants.LEFT_VIEW_WIDTH + ( UtilityManager.isIphone() ? 10:15) , y: rect.origin.y, width: rect.size.width - Constants.LEFT_VIEW_WIDTH, height: rect.size.height)
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        if( self.shouldLeaveMargin == false )
        {
            return super.editingRect(forBounds: bounds)
        }
        
        super.editingRect(forBounds: bounds)
        
        if ( self.leftView == nil && self.rightView == nil )
        {
            //            return CGRectInset(bounds, UtilityManager.isIphone() ? 10:15 , UtilityManager.isIphone() ? 10:15 )
            
            let rect = super.editingRect(forBounds: bounds)
            return CGRect( x: UtilityManager.isIphone() ? 10:15 , y: rect.origin.y, width: rect.size.width , height: rect.size.height)
        }
        else if ( self.leftView != nil && self.rightView == nil )
        {
            let rect = super.editingRect(forBounds: bounds)
            return CGRect( x: Constants.LEFT_VIEW_WIDTH + ( UtilityManager.isIphone() ? 10:15) , y: rect.origin.y, width: rect.size.width , height: rect.size.height)
        }
        else if ( self.leftView == nil && self.rightView != nil )
        {
            let rect = super.editingRect(forBounds: bounds)
            return CGRect( x: UtilityManager.isIphone() ? 10:15 , y: rect.origin.y, width: rect.size.width - Constants.LEFT_VIEW_WIDTH , height: rect.size.height)
        }
        else
        {
            let rect = super.editingRect(forBounds: bounds)
            return CGRect( x: Constants.LEFT_VIEW_WIDTH + ( UtilityManager.isIphone() ? 10:15) , y: rect.origin.y, width: rect.size.width - Constants.LEFT_VIEW_WIDTH, height: rect.size.height)
        }
    }
    
    func setPlaceHolder(_ placeHolder:String)
    {
        self.attributedPlaceholder = NSAttributedString(string:placeHolder,
                                                        attributes:[NSAttributedString.Key.foregroundColor:UIColor.placeholderColor(), NSAttributedString.Key.font:UIFont.REGULAR_FONT_SMALL()])
    }
    
    func setLeftImageView(_ imageName:String)
    {
        let leftView:UIImageView = UIImageView(frame: CGRect(x: 0, y: self.frame.size.height - Constants.LEFT_VIEW_WIDTH , width: Constants.LEFT_VIEW_WIDTH , height: Constants.LEFT_VIEW_WIDTH))
        leftView.image = UIImage(named:imageName)
        leftView.contentMode = .scaleAspectFit //Center//
        
        self.leftViewMode = .always
        self.leftView = leftView
    }
    
    func setRightImageView(_ imageName:String)
    {
        let leftView:UIImageView = UIImageView(frame: CGRect(x: 0, y: self.frame.size.height - Constants.LEFT_VIEW_WIDTH , width: Constants.LEFT_VIEW_WIDTH , height: Constants.LEFT_VIEW_WIDTH))
        leftView.image = UIImage(named:imageName)
        leftView.contentMode = .scaleAspectFit //Center//
        
        self.rightViewMode = .always
        self.rightView = leftView
    }
}

private var kAssociationKeyMaxLength: Int = 0
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}
