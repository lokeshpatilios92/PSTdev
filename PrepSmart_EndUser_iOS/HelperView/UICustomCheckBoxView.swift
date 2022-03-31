//
//  UICustomCheckBoxView.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

protocol UICustomCheckBoxViewDelegate {
    func checkBoxValueChanged(_ value:Bool)
}

class UICustomCheckBoxView: UIView {
    var checkButton:BEMCheckBox!
    var checkboxSelected:Bool!
    var valueLabel:UILabel!
    
    var button:UIButton!
    var title:NSString!
    var textColor:UIColor!
    
    var delegate:UICustomCheckBoxViewDelegate!
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        textColor = UIColor.red
        title = "";
        self.initializeUI()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
    }
    
    init(frame: CGRect , _title:String)
    {
        super.init(frame: frame)
        textColor = UIColor.textColor()
        title = _title as NSString?
        self.initializeUI()
    }
    
    func initializeUI()
    {
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        let space:CGFloat = UtilityManager.isIphone() ? 3:5
        
        checkboxSelected = false
        self.backgroundColor = UIColor.clear
        
        let checkButtonSize:CGFloat = 25
        
        checkButton = BEMCheckBox(frame: CGRect(x: 0,y: 0, width: checkButtonSize , height: checkButtonSize ))
        checkButton.boxType = .square
        checkButton.onFillColor = .clear//UIColor.buttonBackgroundPinkColor()// buttonBackgroundColor()
        checkButton.onTintColor = .white//UIColor.buttonBackgroundPinkColor() // buttonBackgroundColor()
        checkButton.onCheckColor = UIColor.white
        checkButton.onAnimationType = .fill
        checkButton.offAnimationType = .fill
        checkButton.isUserInteractionEnabled = false
        self.addSubview(checkButton)
        
        valueLabel = UILabel(frame:CGRect(x: checkButton.frame.origin.x + checkButton.frame.size.width + space*2 , y: 0, width: self.frame.size.width - (checkButton.frame.origin.x + checkButton.frame.size.width + 2*space), height: self.frame.size.height))
        valueLabel.text = title as String
        valueLabel.numberOfLines = 0
        valueLabel.lineBreakMode = .byWordWrapping
        valueLabel.backgroundColor = UIColor.clear
        valueLabel.font = UIFont.REGULAR_FONT() // FONT_SMALL(FONT_WEIGHT_REGULAR)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .left
//        valueLabel.setTextUnderline(.white, string: ETPLSTR.TERMS_AND_CONDITION)
        self.addSubview(valueLabel)
        
        
        valueLabel.frame = CGRect(x: valueLabel.frame.origin.x, y: 0, width: valueLabel.frame.size.width, height: max(checkButton.frame.size.height,  valueLabel.frame.size.height))
        //        checkButton.frame = CGRectMake(0, 0, checkButtonSize  , valueLabel.frame.size.height)
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: valueLabel.frame.size.height)
        button = UIButton(frame:self.bounds)
        
        button.addTarget(self, action: #selector(UICustomCheckBoxView.checkboxButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        
        self.addSubview(button)
        self.adjustSize()
    }
    
    
    
    override func sizeToFit()
    {
        super.sizeToFit()
        self.valueLabel.sizeToFit()
        self.frame.size.width = self.valueLabel.frame.origin.x + self.valueLabel.frame.size.width + (UtilityManager.isIphone() ? 3:5)*2
        self.valueLabel.frame.size.height = self.frame.size.height
    }
    
    func attachLabel(_ text:String , color:UIColor)
    {
        self.attachLabel(text as NSString, color: color, font: UIFont.REGULAR_FONT()) // FONT_SMALL(FONT_WEIGHT_REGULAR))
    }
    
    func attachLabel(_ text:NSString , color:UIColor , font:UIFont)
    {
        title = text;
        textColor = color;
        valueLabel.font = UIFont.REGULAR_FONT()// FONT_SMALL(FONT_WEIGHT_REGULAR)
        
        valueLabel.text = text as String?
        valueLabel.numberOfLines = 0
        valueLabel.lineBreakMode = .byWordWrapping
        valueLabel.textColor = color
        valueLabel.sizeToFit()
        
        if (valueLabel.frame.size.height <  self.frame.size.height)
        {
            valueLabel.frame = CGRect(x: valueLabel.frame.origin.x, y: 0, width: valueLabel.frame.size.width, height: self.frame.size.height)
            button.frame = self.bounds
        }
        else
        {
            valueLabel.frame = CGRect(x: valueLabel.frame.origin.x, y: 0, width: valueLabel.frame.size.width, height: valueLabel.frame.size.height + 10)
            self.frame = CGRect(x: self.frame.origin.x , y: self.frame.origin.y , width: max( valueLabel.frame.origin.x + valueLabel.frame.size.width, self.frame.size.width) , height: self.frame.size.height )
            button.bounds = self.bounds
            button.frame = self.bounds
        }
        
        button.addTarget(self, action: #selector(UICustomCheckBoxView.checkboxButton(_:)), for: .touchUpInside)
        self.adjustSize()
    }
    
    func adjustSize()
    {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: min(self.frame.size.width, valueLabel.frame.origin.x + valueLabel.frame.size.width) , height: self.frame.size.height)
        button.frame = self.bounds
        valueLabel.frame = CGRect(x: valueLabel.frame.origin.x, y: 0, width: min(valueLabel.frame.size.width , self.frame.size.width - valueLabel.frame.origin.x) , height: self.frame.size.height)
        var checkButtonRect:CGRect = checkButton.frame;
        checkButtonRect.origin.y = (self.frame.size.height - checkButton.frame.size.height)/2;
        checkButton.frame = checkButtonRect
    }
    
    func attachLabel(_ text:String)
    {
        self .attachLabel(text, color: UIColor.textColor())
    }
    
    //    func setSelectedImageName(imageName:String)
    //    {
    //        var selectedImage:UIImage
    //        selectedImage = UIImage(named:imageName)!
    ////        checkButton.setImage(selectedImage, forState: .Selected)
    //    }
    //
    //    func setNotSelectedImageName(imageName:String)
    //    {
    //        var notselectedImage:UIImage
    //        notselectedImage = UIImage(named:imageName)!
    ////        checkButton.setImage(notselectedImage, forState: .Normal)
    //    }
    
    @IBAction func checkboxButton(_ sender:UIButton)
    {
        if (checkboxSelected == false)
        {
            checkButton.setOn(true, animated: true)
            //            checkButton.selected = true
            checkboxSelected = true;
        }
        else
        {
            checkButton.setOn(false, animated: true)
            //            checkButton.selected = false
            checkboxSelected = false;
        }
        
        if self.delegate != nil
        {
            self.delegate.checkBoxValueChanged(checkboxSelected)
        }
    }
    
    
    func setSelected(_ value:Bool)
    {
        checkButton.setOn(value, animated: false)
        //        checkButton.selected = value
        if (value)
        {
            checkboxSelected = true
        }
        else
        {
            checkboxSelected = false
        }
    }
    
    func setTextsColor(_ color:UIColor)
    {
        valueLabel.textColor = color
    }
    
    func isSelected() -> Bool
    {
        return checkboxSelected //checkButton.selected
    }
    
    func addTargetToSubString(_ substring:String , target:AnyObject , selector:Selector)
    {
        let string:NSString = title!
        let buttonRect = self.boundingRectForCharacterRange(valueLabel, range:string.range(of: substring))
        
        let tAndCButton = UIButton(frame: CGRect( x: self.valueLabel.frame.origin.x + buttonRect.origin.x , y: 0 , width: buttonRect.size.width , height: self.frame.size.height ))
        tAndCButton.addTarget( target , action:selector , for: .touchUpInside)
        tAndCButton.backgroundColor = UIColor.clear
        self.addSubview(tAndCButton)
        self.bringSubviewToFront(tAndCButton)
    }
    
    func boundingRectForCharacterRange(_ label:UILabel ,range:NSRange) -> CGRect
    {
//        self.valueLabel.setTextColor(.red, range: range)//(UIColor.buttonBackgroundColor() , string:STR.TERMS_AND_CONDITION)
        
        let textStorage:NSTextStorage = NSTextStorage(string:label.text!)
        let layoutManager:NSLayoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer:NSTextContainer = NSTextContainer(size: label.bounds.size)
        //        textContainer.lineFragmentPadding = 0
        layoutManager.addTextContainer(textContainer)
        
        var glyphRange:NSRange = NSRange()
        // Convert the range for glyphs.
        layoutManager.characterRange(forGlyphRange: range , actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in:textContainer)
    }
    
    
    
    
}
