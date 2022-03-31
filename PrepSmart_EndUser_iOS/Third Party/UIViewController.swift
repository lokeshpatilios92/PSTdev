//
//  UIViewController.swift
//  FannanArtist
//
//  Created by mac on 14/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
//class Validation : NSObject {
    
    func tabBarIsVisible() -> Bool {
        guard let tabBar = tabBarController?.tabBar else { return false }
        return tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
    
    
    func date_Format3(timeStamp: Double, dateformat: String) -> String
    {
       if let dte = Date(timeIntervalSince1970: timeStamp/1000) as? Date
        {
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.timeZone = NSTimeZone.local
            dayTimePeriodFormatter.dateFormat = dateformat
            if let dateString:String = dayTimePeriodFormatter.string(from: dte)  as? String
            {
                return dateString
            }
            else
            {
                return "NA"
            }
        }
        else
        {
            return "NA"
        }
    }
    
    
    func date_CheckDiffrence(prevDateTstmp: Double , nextDateTstmp: Double) -> Bool
    {
        if let prevDte = Date(timeIntervalSince1970: prevDateTstmp/1000) as? Date, let nextDte = Date(timeIntervalSince1970: nextDateTstmp/1000) as? Date
        {
            let dayTimePeriodFormatter = DateFormatter()
            
            dayTimePeriodFormatter.dateFormat = "dd MMM yyyy"
            let date1 = dayTimePeriodFormatter.string(from: prevDte)
            let date2 = dayTimePeriodFormatter.string(from: nextDte)
            
            if date1 == date2
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
        
    }
    
    
    func date_FormatChat(timeStamp: Double) -> String
    {
       if let dte = Date(timeIntervalSince1970: timeStamp/1000) as? Date
        {
            let dayTimePeriodFormatter = DateFormatter()
            
            if Calendar.current.isDateInToday(dte) == true
            {
                return "today"
            }
            else if Calendar.current.isDateInYesterday(dte) == true
            {
                return "yesterday"
            }
            else
            {
                dayTimePeriodFormatter.dateFormat = "dd MMMM"
                
                guard let dateString = dayTimePeriodFormatter.string(from: dte)  as? String else
                {
                    return "NA"
                }
                
                return dateString
            }
        }
        else
        {
            return "NA"
        }
    }

    
    
    
    
    
    func tStamp_to_DateMethod( timeSt : Double )  -> String
    {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        //dateFormatter.dateFormat = .default_type
       
        //dateFormatter.locale =  Locale(identifier: "en_US_POSIX")
        
        if let time_double = Double(timeSt)  as? Double {
            
            let date_TimeStamp = Date(timeIntervalSince1970:time_double/1000)
            
            dateFormatter.dateFormat = "dd MMM yyyy hh:mm"
            if let dte = dateFormatter.string(from: date_TimeStamp) as? String, dte.isEmpty == false
            {
                return dte
            }
            return dateFormatter.string(from:Date())
        }
        else
        {
            return dateFormatter.string(from:Date())
        }
    }
    
    
    func convertDateFormater(date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        return  dateFormatter.string(from: date ?? Date()) ?? ""
    }
    
    //Check url valid or not
    func isValidUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
    
    func rating_Mathod(ratingStr : String!)  -> String!
    {
        
        if let rat_double = Double(ratingStr!)
        {
            let desimal_Str = String(format:"%.1f", rat_double )
            return   "("+"\(desimal_Str)"+"/5)"
        }
        else
        {
            return   "("+"\(0)"+"/5)"
        }
        
    }
    func rat_Mathod(ratingStr : String!)  -> Double!
    {
        
        if let rat_double = Double(ratingStr!) {
            let desimal_Str = String(format:"%.1f", rat_double)
            return Double(desimal_Str)!
        }
        else
        {
            return 0.0
        }
        
        
        
        
    }
    
    func decimal(with string: String) -> NSDecimalNumber {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        return formatter.number(from: string) as? NSDecimalNumber ?? 0
    }
    
    //Email Validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Username Validation
    func isValidUsername(Input:String) -> Bool {
        let RegEx = "\\A\\w{7,18}\\z"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    //Mobile Validation
    func isValidMobile(value: String) -> Bool {
                let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
                let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
                let result = phoneTest.evaluate(with: value)
                return result
            }
    
    
    /*Password Validation
     1 - Password length is 8.
     2 - One Alphabet in Password.
     3 - One Special Character in Password.
     
     ^                                          -Start Anchor.
     (?=.*[A-Z].*[A-Z])                         -Ensure string has two uppercase letters.
     (?=.[$@$#!%?&])                            -Ensure string has one special character.
     (?=.*[0-9].*[0-9])                         -Ensure string has two digits.
     (?=.*[a-z].*[a-z].?*[a-z])                 -Ensure string has three lowercase letters.
     {8,}                                       -Ensure password length is 8.
     $                                          -End Anchor. */
    func isPasswordValid( password : String) -> Bool
    {
        if password.count >= 6
        {
            return true
        }
        else
        {
            return false
        }
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*(a-z))(?=.*[$@$#!%*?&])(A-Za-z\\d$@$#!%*?&]){6,}")
//        return passwordTest.evaluate(with: password)
    }
    
  
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize.init(width: newWidth, height: newHeight))
        image.draw(in: CGRect.init(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    func RBSquareImage(image: UIImage) -> UIImage {
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0
        
        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0
            
        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }
        
        let cropSquare = CGRect.init(x: x, y: y, width: edge, height: edge)
        let imageRef = image.cgImage!.cropping(to: cropSquare);
        
        return UIImage.init(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }
    
    func randomString(length: Int) -> String {
        
        
        let letters : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = letters.count
        var randomString:String = ""
        for _ in 0 ..< length {
            let rand = Int.random(in: 0..<len)
            randomString += letters.map { String($0) }[rand]
        }
        return randomString
    }
    
    func conv_Str_Int_Mathod(str_In_V : String!)  -> Int!
    {
        if  let Int_Str = Int(str_In_V)
        {
            return Int_Str
        }
        else
        {
            return 0
        }
        
    }
    func double_Convert_Mathod(dobStr : String!)  -> Double!
    {
        
        if let doudle_val = Double(dobStr) {
            
            return doudle_val
            
        } else {
            
            return 0.0
        }
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
    func timeStamp_Str_Mathod( timeSt : String! )  -> String
    {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.dateFormat =  "dd MMM yyyy hh:mm a"
        if let timeStr = timeSt
        {
            if let time_double = Double(timeStr) {
                let dateTimeStamp = Date(timeIntervalSince1970:time_double  ) //UTC time
                let dateString = dateFormatter.string(from:dateTimeStamp )
                return dateString
            }
            else
            {
                let dateString = dateFormatter.string(from:Date() )
                return dateString
            }
        }else
        {
            let dateString = dateFormatter.string(from:Date() )
            return dateString
        }
        
        
        
    }
    func timeStamp_Str_MathodGMT( timeSt : String! )  -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
     //   dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.dateFormat =  "dd MMM yyyy hh:mm a"
        if let timeStr = timeSt
        {
            if let time_double = Double(timeStr) {
                let dateTimeStamp = Date(timeIntervalSince1970:time_double) //UTC time
                let dateString = dateFormatter.string(from:dateTimeStamp )
                return dateString
            }
            else
            {
                let dateString = dateFormatter.string(from:Date() )
                return dateString
            }
        }else
        {
            let dateString = dateFormatter.string(from:Date() )
            return dateString
        }
        
        
        
    }
    
    func timeStamp_Str_MathodGMT2( timeSt : String!)  -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
       // dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.dateFormat =  "E, MMM d, yyyy"
        if let timeStr = timeSt
        {
            if let time_double = Double(timeStr) {
                let dateTimeStamp = Date(timeIntervalSince1970:time_double) //UTC time
                let dateString = dateFormatter.string(from:dateTimeStamp )
                return dateString
            }
            else
            {
                let dateString = dateFormatter.string(from:Date() )
                return dateString
            }
        }else
        {
            let dateString = dateFormatter.string(from:Date() )
            return dateString
        }
        
        
        
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func Get_Timestamp(Date_input:String) -> String
    {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="E, MMM d, yyyy  h:mm a"
        let date = dfmatter.date(from:Date_input)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        TimeZone.ReferenceType.default = TimeZone(abbreviation: "UTC")!
        print(date)
        let dateint:Int = Int(dateStamp)
        print(dateint)
        let dateSt:String = String(dateint)
        print(dateSt)
        return dateSt
    }
    
    func Get_TimestampGMT(Date_input:String) -> String
    {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="E, MMM d, yyyy  h:mm a"
        let date = dfmatter.date(from:Date_input)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        TimeZone.ReferenceType.default = TimeZone(abbreviation: "GMT")!
        print(date)
        let dateint:Int = Int(dateStamp)
        print(dateint)
        let dateSt:String = String(dateint)
        print(dateSt)
        return dateSt
    }
}

 
extension UIViewController
{
    
    
    func dateDiffCheck(fromtStamp: Double, totStamp: Double) -> Bool
    {
        guard let frmDate = Date(timeIntervalSince1970: fromtStamp) as? Date else
        {
            return false
        }
        
        guard let toDate = Date(timeIntervalSince1970: totStamp) as? Date else
        {
            return false
        }
        
        let diff = Calendar.current.dateComponents([.day], from: frmDate, to: toDate)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    
  
}

