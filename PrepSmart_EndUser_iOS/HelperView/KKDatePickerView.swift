//
//  KKDatePickerView.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 17/05/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

extension ETPLSTR
{
    static let PLACEHOLDER_SET = "Set"
}

protocol KKDatePickerViewDelegate
{
    func datePickerSelectedDate( title:String , date:Date)
    func datePickerOnCancelled()
}

extension KKDatePickerViewDelegate
{
    func datePickerOnCancelled()
    {
        
    }
}

class KKDatePickerView: UIView , UITextFieldDelegate
{
    var title:String = ""
    var dialogView:UIView!
    var datePicker:UIDatePicker!
    var closeButton:UIButton!
    var submitButton:UIButton!
    var delegate:KKDatePickerViewDelegate!
    var hidePopUpButton:UIButton!
    
    init( )
    {
        super.init(frame: CGRect(x: 0, y: 0, width: UtilityManager.getWidth(), height: UtilityManager.getHeight()) )
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize()
    {
        self.frame = CGRect(x: 0, y: 0, width: UtilityManager.getWidth(), height: UtilityManager.getHeight())
        
        hidePopUpButton = UIButton(frame: CGRect(x: 0, y: 0, width: UtilityManager.getWidth(), height: UtilityManager.getHeight()))
        hidePopUpButton.backgroundColor = .clear
        hidePopUpButton.setTitle("", for: .normal)
        hidePopUpButton.addTarget(self, action: #selector(self.onClickClose) , for: .touchUpInside)
        self.addSubview(hidePopUpButton)
        
        self.dialogView = self.getDiaogueView()
        
        self.dialogView!.layer.shouldRasterize = true
        self.dialogView!.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.dialogView!.layer.opacity = 0.5
        self.dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.addSubview(self.dialogView)
    }
    
    func getDiaogueView() -> UIView
    {
        var selfX:CGFloat = UtilityManager.isIphone() ? 30:100
        
        if( UtilityManager.getWidth() <= 320 )
        {
            selfX = 10
        }
        
        let selfY:CGFloat = UtilityManager.isIphone() ? 20:30
        let space:CGFloat =  UtilityManager.isIphone() ? 10:20
        
        let x:CGFloat = UtilityManager.isIphone() ? 10:15
        var y:CGFloat = space
        
        let fpView = UIView(frame: CGRect(x: selfX ,y: selfY ,width: UtilityManager.getWidth() - 2*selfX  , height: 200))
        fpView.backgroundColor = UIColor.white
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: fpView.frame.width, height:  UtilityManager.isIphone() ? 40:60 ) )
        fpView.addSubview(headerView)
        
        closeButton = UIButton(frame: CGRect(x: headerView.frame.size.width - headerView.frame.size.height , y: 0 ,width: headerView.frame.size.height ,height: headerView.frame.size.height ))
        closeButton.setImage(#imageLiteral(resourceName: "closebitton"), for: .normal)
        closeButton.addTarget(self, action: #selector(KKDatePickerView.onClickClose) , for: .touchUpInside)
        headerView.addSubview(closeButton)
        
        
        let contentWidth:CGFloat = fpView.frame.size.width - 2*x
        
        y += headerView.frame.size.height + space
        
        datePicker = UIDatePicker(frame: CGRect(x:x*2 , y:y , width: fpView.frame.width - x*4 , height: UtilityManager.isIphone() ? 150:200 ) )
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        datePicker.tintColor = UIColor.textColor()
        fpView.addSubview(datePicker)
        
        y += datePicker.frame.size.height + space
        
        submitButton = UIButton(frame: CGRect(x: x , y: y ,width: contentWidth ,height: Constants.BUTTON_HEIGHT ))
        
        submitButton.setTitle( ETPLSTR.PLACEHOLDER_SET.uppercased() , for: .normal)
        submitButton.addTarget(self , action: #selector( KKDatePickerView.onClickSetDate ), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.appOrangeColor()//UIColor.appBlueColor()
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        
        fpView.addSubview(submitButton)
        y += submitButton.frame.size.height + x
        
        fpView.layer.cornerRadius = Constants.cornerRadius
        fpView.clipsToBounds = true
        
        fpView.frame = CGRect(x:fpView.frame.origin.x,y: fpView.frame.origin.y ,width: fpView.frame.size.width ,height: y )
        fpView.center = self.center
        
        return fpView
    }
    
    func show()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.addSubview(self)
        appDelegate.window?.endEditing(true)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
        },
            completion: nil
        )
    }
    
    func hide()
    {
        let currentTransform = self.dialogView.layer.transform
        
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + M_PI * 270 / 180), 0, 0, 0)
        
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [] ,
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.opacity = 0
        }) { (finished: Bool) -> Void in
            self.removeFromSuperview()
        }
    }
    
    @objc func onClickClose()
    {
        self.hide()
        if self.delegate != nil
        {
            self.delegate.datePickerOnCancelled()
        }
    }
    
    @objc func onClickSetDate()
    {
        self.hide()
        if self.delegate != nil
        {
            self.delegate.datePickerSelectedDate(title: self.title , date: self.datePicker.date )
        }
    }
}
