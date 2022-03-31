//
//  ETPLTextFiled.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 07/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

class ETPLTextFiled: KKTextFiled {
    var line:UIView!
    var activityIndicator:UIActivityIndicatorView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        self.initialize("",rightImageName: "")
    }
    
    override init(frame:CGRect , leftImageName:String! , rightImageName:String! )
    {
        super.init(frame:frame)
        self.initialize(leftImageName , rightImageName: rightImageName)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.initialize("" , rightImageName:"")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.line.frame = CGRect(x: 0,y: self.frame.size.height - 1 , width: self.frame.size.width , height: 1 )
    }
    
    override func initialize( _ leftImageName:String! , rightImageName:String! )
    {
        super.initialize(leftImageName, rightImageName: rightImageName)
        
        self.line = UIView(frame: CGRect(x: 0,y: self.frame.size.height - 1 , width: self.frame.size.width , height: 1 ))
        self.line.backgroundColor = UIColor.seperatorColor() //backgroundColor() //
        self.addSubview(self.line)
        self.bringSubviewToFront(line)
        self.clearButtonMode = .whileEditing
        self.font = UIFont.REGULAR_FONT()
        self.canCopyPaste = false
    }
    
    func startSearching()
    {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.frame.size.width - Constants.LEFT_VIEW_WIDTH , y: 0, width: Constants.LEFT_VIEW_WIDTH , height: self.frame.size.height))
        self.rightView = activityIndicator
        self.rightViewMode = .always
        activityIndicator.style = .gray
        activityIndicator.tintColor = UIColor.black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        self.rightViewMode = .always
        //        self.clearButtonMode = .Never
    }
    
    func stopSearching()
    {
        self.clearButtonMode = .whileEditing
        self.rightView = nil
        self.rightViewMode = .never
        activityIndicator.stopAnimating()
    }
    
}
