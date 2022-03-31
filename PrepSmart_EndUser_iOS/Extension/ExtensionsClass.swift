//
//  ExtensionsClass.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

//MARK: String Extension
extension String
{
    func contains(find: String) -> Bool
    {
        return self.range(of:find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool
    {
        return self.range(of: find , options: String.CompareOptions.caseInsensitive , range: nil, locale: nil) != nil
    }
    
    func substring(_ r: Range<Int>) -> String
    {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return self.substring(with: Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex)))
    }
    
    func stringByURLEncoding() -> String?
    {
        let characters = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        characters.removeCharacters(in: "&")
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: characters as CharacterSet) else
        {
            return nil
        }
        return encodedString
    }
    
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
    
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "\n", options: .regularExpression, range: nil)
    }
}

//MARK: UIButton
extension UIButton {
    
    func fullRange() -> NSRange
    {
        return NSMakeRange(0, (title(for: state) ?? "").count)
    }
    
    // MARK: Range Formatter
    func setTextColor(_ color: UIColor, range: NSRange?)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        setAttributedTitle(text, for: state)
        //        attributedText = text
    }
    
    func setFont(_ font: UIFont, range: NSRange?)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        setAttributedTitle(text, for: state)
    }
    
    func setTextUnderline(_ color: UIColor, range: NSRange?)
    {
        setTextUnderline(color, range: range, byWord: false)
    }
    
    func setTextUnderline(_ color: UIColor, range: NSRange?, byWord: Bool)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        var style = NSUnderlineStyle.single.rawValue
        if byWord { style = style | NSUnderlineStyle.byWord.rawValue }
        text.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: style as Int), range: range)
        text.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
        setAttributedTitle(text, for: state)
    }
    
    func setTextWithoutUnderline(range: NSRange?)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.removeAttribute(NSAttributedString.Key.underlineStyle, range: range)
        setAttributedTitle(text, for: state)
    }
    
    func setSuperscriptWithFont( color: UIColor, font: UIFont , offset:CGFloat, range: NSRange? )
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttributes( [NSAttributedString.Key.font:font ,NSAttributedString.Key.baselineOffset:offset , NSAttributedString.Key.foregroundColor:color ] , range: range )
        setAttributedTitle(text, for: state)
    }
    
    // MARK: String Formatter
    func rangeOf(_ string: String) -> NSRange?
    {
        let range = NSString(string: title(for: state) ?? "").range(of: string)
        return range.location != NSNotFound ? range : nil
    }
    
    //    MARK: Custom Func
    func setTextColor(_ color: UIColor, string: String) {
        setTextColor(color, range: rangeOf(string))
    }
    
    func setFont(_ font: UIFont, string: String) {
        setFont(font, range: rangeOf(string))
    }
    
    func setTextUnderline(_ color: UIColor, string: String) {
        setTextUnderline(color, range: rangeOf(string))
    }
    
    // MARK: Helpers
    fileprivate func mutableAttributedString() -> NSMutableAttributedString {
        if attributedTitle(for: state) != nil {
            return NSMutableAttributedString(attributedString: attributedTitle(for: state) ?? NSAttributedString.init(string: ""))
        } else {
            return NSMutableAttributedString(string: title(for: state) ?? "")
        }
    }
}




//MARK: ViewController Extension
import SwiftMessages
extension UIViewController
{
    func showAnimation() -> Void {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimation() -> Void {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        });
    }
    
    func addKeyboardNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardDidShow(notification:)) , name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardDidHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotificationObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func dismissKeyboardOnTap() {
        let tapper:UITapGestureRecognizer = UITapGestureRecognizer(target: view, action:#selector(UIView.endEditing(_:)))
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
    }
    
    @objc func keyboardDidShow(notification:Notification) {
        
    }
    
    @objc func keyboardDidHide(notification:Notification) {
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showCustomPopUp(mesgText : String?, topImageName : UIImage?, bottomImageName : UIImage?, customDelegate: CustomPopUpViewControllerDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "CustomPopUpViewController") as! CustomPopUpViewController
        
        vc.mesgText         = mesgText //ETPLSTR.ALERT_PASSWORD_CHANGE_SUCCESS
        vc.topImageName     = topImageName //"smile"
        vc.bottomImageName  = bottomImageName //""
        
        vc.customDelegate = customDelegate //as? CustomPopUpViewControllerDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showCustomOkCancelPopUp(titleText: String, mesgText : String, okButtonName : String, cancelButtonName : String, leftCornerImage: UIImage?, customDelegate : CustomOkCancelPopUpViewControllerDelegate?) {
        let vc = UIStoryboard.Blogs_Module.instantiateViewController(withIdentifier: "CustomOkCancelPopUpViewController") as! CustomOkCancelPopUpViewController
        vc.leftCornerImage  = leftCornerImage
        vc.titleText        = titleText
        vc.msgText          = mesgText
        vc.okButtonName     = okButtonName
        vc.cancelButtonName = cancelButtonName
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    
    
    func showCustomRaitngPopUp(customDelegate : RatingsPopUpViewControllerDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "RatePrepsmartPopUpVC") as! RatePrepsmartPopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showCustomRateRecipePopUp(customDelegate : CustomRateRecipePopUpDelegate?) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "RateRecipePopUpVC") as! RateRecipePopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    
    func showCustomChangePasswordPopUp(customDelegate : CustomPopUpChangePasswordDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "ChangePasswordPopUpVc") as! ChangePasswordPopUpVc
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    
    
    func showCustomKeyFeaturePopUp(customDelegate : CustomKeyFeaturePopUpDelegate?, DataDict:HomeStruct) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "KeyFeaturePopUpVC") as! KeyFeaturePopUpVC
        vc.customDelegate = customDelegate
        vc.homeData = DataDict
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showCustomResetSettingsPopUp(customDelegate : CustomResetSettingsPopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "ResetSettingsPopUpVC") as! ResetSettingsPopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showCookScreenPopUpVC(customDelegate : CustomCookScreenPopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "CookScreenPopUpVC") as! CookScreenPopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    
    func showRateThisRecipePopUpVC(customDelegate : CustomRateThisRecipePopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "RateThisRecipePopUpVC") as! RateThisRecipePopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showRecipeCompletedVC(customDelegate : CustomRecipeCompletedViewControllerDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "RecipeCompletedViewController") as! RecipeCompletedViewController
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showOneLabelAndTwoButtonPopUp(setTitleText: String?,isHiddenLeftButton : Bool?,setRightButtonTitle : String?, setLeftButtonTitle : String? ,customDelegate : CustomOneLabelAndTwoButtonPopUpDelegate?) {
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "OneLabelAndTwoButtonPopUpVC") as! OneLabelAndTwoButtonPopUpVC
        
        vc.customDelegate = customDelegate
        vc.setTitleLabelText = setTitleText
        vc.isHiddenLeftButton = isHiddenLeftButton
        vc.setRightButtonTitle = setRightButtonTitle
        vc.setLeftButtonTitle = setLeftButtonTitle
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showAddToPopUpVC(customDelegate : CustomAddToPopUpVCDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AddToPopUpVC") as! AddToPopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showAddToMealPopUpVC(customDelegate : CustomAddToMealPopUpVCDelegate?) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "AddToMealPopUpVC") as! AddToMealPopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    

    func showAlertPopUpWithTwoButtonDelegate(title:String?,message:String?,customDelegate : AlertPopUpWithTwoButtonDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AlertPopUpWithTwoButton") as! AlertPopUpWithTwoButton
        vc.customDelegate = customDelegate
        vc.titleText = title
        vc.mesgText = message
    }
    
    func showSpecifyDaysVC(customDelegate : CustomSpecifyDaysVCDelegate?) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "SpecificDaysVC") as! SpecificDaysVC
        
        vc.customDelegate = customDelegate
        

        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    

    func TwoButtonAndNoteDelegate(title:String?,note:String?,customDelegate : TwoButtonAndNotePopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "TwoButtonAndNotePopUpVC") as! TwoButtonAndNotePopUpVC
        vc.customDelegate = customDelegate
        vc.titleText = title
        vc.noteText = note
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
        }
    
    func showSelectDateRangeVC(btn_text : String?,customDelegate : CustomSelectDateRangeVCDelegate?) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "SelectDateRangeVC") as! SelectDateRangeVC
        
        vc.customDelegate = customDelegate
        vc.btn_text = btn_text
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }

    func showLoadPlanTemplatePopUpVC(customDelegate : CustomLoadPlanTemplatePopUpDelegate?) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "LoadPlanTemplatePopUpVC") as! LoadPlanTemplatePopUpVC
        
        vc.customDelegate = customDelegate
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }

    func ShowReportThisRecipePopUpVC(customDelegate : ReportThisRecipePopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "ReportThisRecipePopUpVC") as! ReportThisRecipePopUpVC
        vc.customDelegate = customDelegate
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func SaveOptionsPopUpVC(customDelegate : SaveOptionsPopUpVCDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "SaveOptionsPopUpVC") as! SaveOptionsPopUpVC
        vc.customDelegate = customDelegate
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showAmazonLoginPopUpVC(customDelegate : CustomAmazonLoginPopUpDelegate?) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "AmazonLoginPopUpVC") as! AmazonLoginPopUpVC
        
        vc.customDelegate = customDelegate
        
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showAlertWithOkButtonPopUpVC(setTitle : String?, setMessage : String?, setButtonTitle : String?,customDelegate : CustomAlertWithOkButtonPopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AlertWithOkButtonPopUpVC") as! AlertWithOkButtonPopUpVC
        
        vc.customDelegate = customDelegate
        
        vc.setTitle = setTitle
        vc.setMessage = setMessage
        vc.setButtonTitle = setButtonTitle
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showAlertAddWeeklyPlanVC() {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AlertAddWeeklyPlanVC") as! AlertAddWeeklyPlanVC
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showAlertLoadPlanTempletVC() {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AlertLoadPlanTempletVC") as! AlertLoadPlanTempletVC
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    //    func showConfigurePopUp() {
    //        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "ConfigurePopUpViewController") as! ConfigurePopUpViewController
    //
    //        vc.customDelegate = self as? ConfigurePopUpViewControllerDelegate
    //
    //        vc.view.frame = self.view.bounds;
    //        vc.willMove(toParent: self)
    //        self.view.addSubview(vc.view)
    //        self.addChild(vc)
    //        vc.didMove(toParent: self)
    //    }

//    func showConfigurePopUp() {
//        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "ConfigurePopUpViewController") as! ConfigurePopUpViewController
//        
//        vc.customDelegate = self as? ConfigurePopUpViewControllerDelegate
//        
//        vc.view.frame = self.view.bounds;
//        vc.willMove(toParent: self)
//        self.view.addSubview(vc.view)
//        self.addChild(vc)
//        vc.didMove(toParent: self)
//    }

    
    func showWarning(title:String,warningMessage:String){
        
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureTheme(backgroundColor: UIColor.appOrangeColor(), foregroundColor: UIColor.white)
        success.configureContent(title: title, body: warningMessage, iconImage: #imageLiteral(resourceName: "profiel"))
        
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .center
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
        
    }
    
    
    func showCalendarViewController(setTopLabel : String?,customDelegate : CustomCalendarViewController?) {
        let vc = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        
        vc.customDelegate = customDelegate
        vc.setTopLabel = setTopLabel
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showLogOutPopUp(leftBtnTitle: String?, rightBtnTitle: String?, lblText : String?, isLogOut : Bool?, customDelegate: UnsubscribeRecipePopUpVCDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "UnsubscribeRecipePopUpVC") as! UnsubscribeRecipePopUpVC
        
      //  vc.setData(leftBtnTitle: leftBtnTitle ?? "", rightBtnTitle: rightBtnTitle ?? "", lblText: lblText ?? "", isLogOut: isLogOut)
        vc.customDelegate = customDelegate
        vc.leftBtnTitle = leftBtnTitle
        vc.rightBtnTitle = rightBtnTitle
        vc.lblText = lblText
        vc.isLogOut = isLogOut
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showLogOutPopUp1(leftBtnTitle: String?, rightBtnTitle: String?, lblText : String?, isLogOut : Bool?, customDelegate: UnsubscribeRecipePopUpVCDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "UnsubscribeRecipePopUpVC") as! UnsubscribeRecipePopUpVC
        
      //  vc.setData(leftBtnTitle: leftBtnTitle ?? "", rightBtnTitle: rightBtnTitle ?? "", lblText: lblText ?? "", isLogOut: isLogOut)
        vc.customDelegate = customDelegate
        vc.leftBtnTitle = leftBtnTitle
        vc.rightBtnTitle = rightBtnTitle
        vc.lblText = lblText
        vc.isLogOut = isLogOut
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(vc, animated: true, completion: nil)
    }
    
    
    func showDeleteAndChangeRecipePopUp(leftBtnTitle: String, rightBtnTitle: String, lblText : String, customDelegate: DeleteAndChangeRecipePopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "DeleteAndChangeRecipePopUpVC") as! DeleteAndChangeRecipePopUpVC
        
//        vc.setData(titleLabelText: lblText, leftBtnText: leftBtnTitle, rightBtnText: rightBtnTitle)
        vc.customDelegate = customDelegate
        vc.btn_confirmText = rightBtnTitle
        vc.btn_cancelText = leftBtnTitle
        vc.titleLabelText = lblText
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    
    func showConsultationCompletePopUp(lbl_text: String?, bottomButton: String?,customDelegate : ConsultationCompletePopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "ConsultationCompletePopUpVC") as! ConsultationCompletePopUpVC
        
        vc.customDelegate = customDelegate
        vc.textLbl = lbl_text
        vc.btnTitle = bottomButton
//        vc.setData(lbl_text: lbl_text ?? "", bottomButton: bottomButton ?? "")
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    
    func OneImageOneLabelAndOneButtonPopUp(lbl_text: String?, bottomButton: String?,topImage : UIImage?,customDelegate : OneImageOneLabelAndOneButtonVCDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "OneImageOneLabelAndOneButtonVC") as! OneImageOneLabelAndOneButtonVC
        
        vc.customDelegate = customDelegate
//        vc.setData(lbl_txt: lbl_text ?? "", bottomBtnText: bottomButton ?? "", topImage: topImage ?? UIImage())
        vc.setTopImage = topImage
        vc.setDetailLabelMsg = lbl_text
        vc.setButtonText = bottomButton
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }

    
    func showTopTagsPopUp(customDelegate : CustomTopTagsPopUpDelegate?, chefTopTags:[Top_tags]) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "TopTagsPopUpVC") as! TopTagsPopUpVC
        vc.toptags = chefTopTags
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    func showAddIngredientsPopUp(customDelegate : CustomAddIngredientPopUpDelegate?) {
           let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AddIngredientPopUpVC") as! AddIngredientPopUpVC
           
           vc.view.frame = self.view.bounds;
           vc.willMove(toParent: self)
           self.view.addSubview(vc.view)
           self.addChild(vc)
           vc.didMove(toParent: self)
       }
    
    func showAddNewInstructionPopUp(customDelegate : CustomAddIngredientPopUpDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AddNewInstructionPopUpVC") as! AddNewInstructionPopUpVC
        
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
}
    
//MARK: View Extension
extension UIView
{
    func addShadow(radius:CGFloat) {
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12.0
        self.layer.shadowOpacity = 0.7
        self.layer.cornerRadius = radius
    }
    func addSubViewWithBlurBg(_ view:UIView)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if UIAccessibility.isReduceTransparencyEnabled == false
        {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light )
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            
            appDelegate.window?.addSubview(blurEffectView)
            appDelegate.window?.addSubview(view)
        }
        else
        {
            appDelegate.window?.addSubview(view)
        }
    }
    
    func removeSubViewWithBlurBg()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if UIAccessibility.isReduceTransparencyEnabled == false
        {
            for subview in (appDelegate.window?.subviews)!
            {
                if ( subview.isKind(of: UIBlurEffect.classForCoder()) == true )
                {
                    subview.removeFromSuperview()
                    break
                }
            }
            self.removeFromSuperview()
        }
        else
        {
            self.removeFromSuperview()
        }
    }
    
    //MARK:- Shake Animation
    func shake()
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    //Get Safe Area Frame
    public var safeAreaFrame: CGRect {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame
        }
        return bounds
    }
}

//MARK: UIImagePickerController Extension
extension UIImagePickerController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationBar.topItem?.rightBarButtonItem?.isEnabled = true
    }
    open override var shouldAutorotate: Bool {
        return false
    }
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UtilityManager.isIphone() == true {
            return .portrait
        }
        else{
            return .landscape
        }
    }
}

//MARK: UILable
extension UILabel {
    
    func fullRange() -> NSRange
    {
        return NSMakeRange(0, (text ?? "").count)
    }
    
    // MARK: Range Formatter
    func setTextColor(_ color: UIColor, range: NSRange?)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        attributedText = text
    }
    
    func setFont(_ font: UIFont, range: NSRange?)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedText = text
    }
    
    func setTextUnderline(_ color: UIColor, range: NSRange?)
    {
        setTextUnderline(color, range: range, byWord: false)
    }
    
    func setTextUnderline(_ color: UIColor, range: NSRange?, byWord: Bool)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        var style = NSUnderlineStyle.single.rawValue
        if byWord { style = style | NSUnderlineStyle.byWord.rawValue }
        text.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: style as Int), range: range)
        text.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
        attributedText = text
    }
    
    func setTextWithoutUnderline(range: NSRange?)
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.removeAttribute(NSAttributedString.Key.underlineStyle, range: range)
        attributedText = text
    }
    
    func setSuperscriptWithFont(color: UIColor, font: UIFont , offset:CGFloat, range: NSRange? )
    {
        guard let range = range else { return }
        let text = mutableAttributedString()
        text.addAttributes( [NSAttributedString.Key.font:font ,NSAttributedString.Key.baselineOffset:offset , NSAttributedString.Key.foregroundColor:color ] , range: range )
        attributedText = text
    }
    
    // MARK: String Formatter
    func rangeOf(_ string: String) -> NSRange?
    {
        let range = NSString(string: text ?? "").range(of: string)
        return range.location != NSNotFound ? range : nil
    }
    
    //    MARK: Custom Func
    func setTextColor(_ color: UIColor, string: String) {
        setTextColor(color, range: rangeOf(string))
    }
    
    func setFont(_ font: UIFont, string: String) {
        setFont(font, range: rangeOf(string))
    }
    
    func setTextUnderline(_ color: UIColor, string: String) {
        setTextUnderline(color, range: rangeOf(string))
    }
    
    // MARK: Helpers
    fileprivate func mutableAttributedString() -> NSMutableAttributedString {
        if attributedText != nil {
            return NSMutableAttributedString(attributedString: attributedText!)
        } else {
            return NSMutableAttributedString(string: text ?? "")
        }
    }
    
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
}

//MARK: EXTENSION FOR URL CONSTRUCTION
extension URL {
    
    @discardableResult
    func append(_ queryItem: String, value: String?) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        // create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        // create query item if value is not nil
        guard let value = value else { return absoluteURL }
        let queryItem = URLQueryItem(name: queryItem, value: value)
        
        // append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // append updated query items array in the url component object
        urlComponents.queryItems = queryItems// queryItems?.append(item)
        
        // returns the url from new url components
        return urlComponents.url!
    }
}

extension UISearchBar
{
    
    func setMagnifyingGlassColorTo(color: UIColor)
    {
        // Search Icon
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
}

extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

//MARK : UIView
extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

//Check url is image or video
extension String {
    public func isImageType() -> Bool {
        // image formats which you want to check
        let imageFormats = ["jpg", "jpeg", "png", "gif"]
        
        if URL(string: self) != nil  {
            
            let extensi = (self as NSString).pathExtension
            
            return imageFormats.contains(extensi)
        }
        return false
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180.0
    }
}

//MARK: UITableViewCell
extension UITableViewCell {
    func showWarning(title:String,warningMessage:String){
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureTheme(backgroundColor: UIColor.appOrangeColor(), foregroundColor: UIColor.white)
        success.configureContent(title: title, body: warningMessage, iconImage: #imageLiteral(resourceName: "profiel"))
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .center
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }
}

extension UIScrollView {
    
    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}


extension Date {
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}

extension UIViewController {
    func DateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy"
        let myStringDate = formatter.string(from: yourDate!)
        return myStringDate
    }
    func DateToStringYYMMDD(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "yyyy-MM-dd"
        let myStringDate = formatter.string(from: yourDate!)
        return myStringDate
    }
}
