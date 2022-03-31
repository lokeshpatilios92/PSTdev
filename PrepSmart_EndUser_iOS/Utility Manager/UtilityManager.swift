//
//  UtilityManager.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit
import CoreTelephony
import GoogleSignIn
import FacebookCore
import FacebookLogin


class UtilityManager: NSObject {
    static func isLogedIn() -> Bool {
        return UserDefaults.standard.bool(forKey:ETPLSTR.KEY_IS_LOGGED_IN)
    }
    
    static func isEndUserLogedIn() -> Bool {
        return UserDefaults.standard.bool(forKey:ETPLSTR.KEY_IS_ENDUSER_LOGGED_IN)
    }
    
    static func isEndUserLogedIn(value:Bool) {
        UserDefaults.standard.set(value, forKey: ETPLSTR.KEY_IS_ENDUSER_LOGGED_IN)
        UserDefaults.standard.synchronize()
    }
    
    static func isLogedIn(value:Bool) {
        UserDefaults.standard.set(value, forKey: ETPLSTR.KEY_IS_LOGGED_IN)
        UserDefaults.standard.synchronize()
    }
    
    static func isDeviceIphone() -> Bool {
        return UserDefaults.standard.bool(forKey:ETPLSTR.KEY_IS_LOGGED_IN)
    }
    
//    static func isDeviceIphone(value:Bool) {
//        UserDefaults.standard.set(value, forKey: ETPLSTR.KEY_IS_IPHONE)//set(value, forKey: ETPLSTR.KEY_IS_IPHONE)
//        UserDefaults.standard.synchronize()
//    }
    
    static func getSpace () -> CGFloat
    {
        return self.isIphone() ? 10:15
    }
    
    static func getWidth () -> CGFloat
    {
        return UIScreen.main.bounds.width;
    }
    
    static func getHeight () -> CGFloat
    {
        return UIScreen.main.bounds.height;
    }
    
    static func getScreenScale () -> CGFloat
    {
        return UIScreen.main.scale;
    }
    
    static func isIpod () -> Bool
    {
        return UI_USER_INTERFACE_IDIOM() == .phone ? true : false
        //        return UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? true:false
    }
    
    static func isIphone () -> Bool
    {
        return UI_USER_INTERFACE_IDIOM() == .phone ? true : false
        //        return UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? true:false
    }
    
    static func dismissKeyboardOnTap(_ view:UIView)
    {
        let tapper:UITapGestureRecognizer = UITapGestureRecognizer(target: view, action:#selector(UIView.endEditing(_:)))
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
    }
    
    static func dismissKeyboardOnTapWithDelegate(_ view:UIView) -> UITapGestureRecognizer
    {
        let tapper:UITapGestureRecognizer = UITapGestureRecognizer()
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
        return tapper
    }
    
    static func isValidEmail(_ emailAddress:String) -> Bool
    {
        let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailAddress)
    }
    
    static func isValidNumber(_ number:String) -> Bool
    {
        let numberRegex:String = "[0-9]"
        let numberTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberTest.evaluate(with: number)
    }
    
    static func isValidURL(string: String?) -> Bool
    {
        guard let urlString = string else {return false}
        guard let url = URL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url) {return false}
        else {return true}
    }
    

    static func getTitleLabel(_ text:String) -> UILabel
    {
        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
        titleLabel.text = text
        titleLabel.textColor = .white
        titleLabel.font = UIFont.FONT_NAVIGATION_TITLE()
        return titleLabel
    }
    
    static func getTitleLabelBlackColor(_ text:String) -> UILabel
    {
        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
        titleLabel.text = text
        titleLabel.textColor = .white // blueThemeColor()
        titleLabel.font = UIFont.FONT_NAVIGATION_TITLE()
        return titleLabel
    }
    
    static func logOutUser(){
        UtilityManager.isLogedIn(value: false)
        UtilityManager.isEndUserLogedIn(value: false)
        UserDefaults.standard.set("", forKey: ETPLSTR.KEY_USER_DEFAULT_USERID)
        GIDSignIn.sharedInstance.signOut()
//         let loginManager = LoginManager()
//        loginManager.logOut()
        
    }
    
    static func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.groupTableViewBackground.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    // MARK: Bage Button initiolization func

    
    
    static func jsonToString(json: [String:Any]) -> String {
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "") // <-- here is ur string
            return convertedString!
        } catch let myJSONError {
            print(myJSONError)
            return ""
        }
        
    }
//    static func 
//    let yourViewBorder = CAShapeLayer()
//    yourViewBorder.strokeColor = UIColor.white.cgColor
//    yourViewBorder.lineDashPattern = [2, 2]
//    yourViewBorder.frame = couponCodeInnerView.bounds
//    yourViewBorder.fillColor = nil
//    yourViewBorder.path = UIBezierPath.init(roundedRect: couponCodeInnerView.bounds, cornerRadius: 4.0).cgPath
//    //yourViewBorder.path = UIBezierPath(rect: couponCodeInnerView.bounds).cgPath
//    couponCodeInnerView.layer.addSublayer(yourViewBorder)
}
