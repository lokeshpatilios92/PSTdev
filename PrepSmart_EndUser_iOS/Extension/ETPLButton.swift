//
//  ETPLButton.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

class ETPLButton: UIButton {
    var line : UIView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.initialize()
    }
    
    func initialize()
    {
        self.frame = CGRect( x: self.frame.origin.x , y: self.frame.origin.y , width: self.frame.size.width , height: self.frame.size.height)
        self.setTitleColor(UIColor.white , for: UIControl.State())
        self.titleLabel?.font = UIFont.FONT_BUTTON()
        self.layer.cornerRadius = 0//Constants.cornerRadius
        self.backgroundColor = UIColor.appOrangeColor()
        self.layer.masksToBounds = true
        self.layoutIfNeeded()
    }
    
    func drowUnderLine(color:UIColor)
    {
        //        self.line.frame = CGRect(x: 0,y: self.frame.size.height - 2 , width: self.frame.size.width , height: 2 )
        self.line = UIView(frame: CGRect(x: 0,y: self.frame.size.height - 1 , width: self.frame.size.width , height: 1 ))
        self.line.backgroundColor = color
        self.addSubview(self.line)
        self.bringSubviewToFront(line)
    }
}
