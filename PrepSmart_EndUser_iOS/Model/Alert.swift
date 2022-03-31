//
//  Alert.swift
//  FannanArtist
//
//  Created by mac on 13/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    static var appDelegate = UIApplication.shared.delegate
    
    //MARK:- Response Messages
    static var msg_finish_booking : String{Helper.localize(locStr: "Are you sure you want to complete this booking?")}
    static var msgCash_payment    : String{Helper.localize(locStr: "Are you sure you want to do Cash payment?")}
    static var msgcwallet_payment : String{Helper.localize(locStr: "Are you sure you want to do wallet payment?")}
    static var msgsufficientamount: String{Helper.localize(locStr: "Oops its seem that your wallet amount is insufficient for total pay amount")}
    static var msg_finish_job      :String{Helper.localize(locStr:"Are you sure you want to finish this job?")}
    static var kMob_N_Valid        :String{Helper.localize(locStr:"Mobile number should be 7-16 digits.")}
    static var msg                 :String{Helper.localize(locStr:"Message")}
    static var des_Msg             :String{Helper.localize(locStr:"Please enter description")}
    static var Sign_Out_msg        :String{Helper.localize(locStr:"Are you sure you want to Sign Out?")}
    static var Network_Error_msg   :String{Helper.localize(locStr:"Oops! It seems like your device is not connected to the internet.")}
    static var Name_msg            :String{Helper.localize(locStr:"Please enter user name.")}
    static var Email_msg           :String{Helper.localize(locStr:"Please enter email id.")}
    static var Email_Mobile_msg           :String{Helper.localize(locStr:"Please enter a valid email/Mobile Number.")}
    static var Mobile_msg           :String{Helper.localize(locStr:"Please enter mobile number")}
    static var Pass_msg            :String{Helper.localize(locStr:"Please enter password.")}
    static var Con_pass_msg        :String{Helper.localize(locStr:"Please retype new password.")}
    static var Try_agn_msg         :String{Helper.localize(locStr:"Please try again after some time.")}
    static var Pass_not_macth      :String{Helper.localize(locStr:"Oops! Passwords do not match.")}
    static var Email_not_Vaild_msg :String{Helper.localize(locStr:"Please enter valid email id.")}
    static var amount_msg          :String{Helper.localize(locStr:"Please enter amount.")}
    static var select_Media        :String{Helper.localize(locStr:"Please select media to post.")}
    static var install_Whtsapp     :String{Helper.localize(locStr:"Whatsapp not installed in your device.")}
    static var kmsg                :String{Helper.localize(locStr:"Prep Smart")}
    static var kTitle              :String{Helper.localize(locStr:"Prep Smart")}
    static var kNetConnectionTitle :String{Helper.localize(locStr:"No Internet Connection")}
    static var kNetwork_Error      :String{Helper.localize(locStr:"Make sure your device is connected to the internet.")}
    static var kServer_Error       :String{Helper.localize(locStr:"Server error, please try again later.")}
    static var errorTitle          :String{Helper.localize(locStr:"Error")}
    static var emptyServices       :String{Helper.localize(locStr:"Please select services")}
    static var applePayErr         :String{Helper.localize(locStr:"Unable to present Apple Pay authorization.")}
    static var setupApplePay       :String{Helper.localize(locStr:"Please setup apple pay on your device first.")}
    static var codeEmpty           :String{Helper.localize(locStr:"Please enter code")}
    
    //App Message
    static var kEmpty_Email                         :String{Helper.localize(locStr: "Please enter your email.")}
    static var kInvalid_Email                       :String{Helper.localize(locStr: "Please enter valid email address.")}
    static var kEmpty_num                           :String{Helper.localize(locStr: "Please enter valid mobile number.")}
    static var kEmpty_Password                      :String{Helper.localize(locStr: "Please enter your password.")}
    static var kEmpty_Old_Password                  :String{Helper.localize(locStr: "Please enter your old password.")}
    static var kEmpty_New_Password                  :String{Helper.localize(locStr: "Please enter your new password.")}
    static var kEmpty_Confirm_Password              :String{Helper.localize(locStr: "Please enter your confirm Password.")}
    static var kPassword_Limit                      :String{Helper.localize(locStr: "Password must be greater than or equal to 6 characters.")}
    static var kPassword_ConfirmPassword_NotMatch   :String{Helper.localize(locStr: "Passwords should be same.")}
    static var kNewPassword_ConfirmPassword_NotMatch:String{Helper.localize(locStr: "Passwords do not match.")}
    static var passwordChange                       :String{Helper.localize(locStr: "Password reset sucessfully,you'll receive a new password on your registered email.")}
    
    //"Your password has been changed successfully."
    //"Applied seeker not found."
    
    static var kEmpty_Name                    :String{Helper.localize(locStr:"Please enter your name.")}
    static var kEmpty_LasName                 :String{Helper.localize(locStr:"Please enter your last name.")}
    static var kEmpty_gender                  :String{Helper.localize(locStr:"Please select gender.")}
    static var kEmpty_Mobile                  :String{Helper.localize(locStr:"Please enter your mobile number.")}
    static var kEmpty_Current_Address         :String{Helper.localize(locStr:"Please enter your current address.")}
    static var kLocation_Not_Select           :String{Helper.localize(locStr:"Please select preferd location.")}
    static var kJobType_Not_Select            :String{Helper.localize(locStr:"Please select job type.")}
    static var kQualification_Not_Select      :String{Helper.localize(locStr:"Please select qualification.")}
    static var kYearOfPassing_Not_Select      :String{Helper.localize(locStr:"Please select your year of passing")}
    static var kEmpty_Percentage              :String{Helper.localize(locStr:"Please enter your percentage.")}
    static var kAreaOfSector_Not_Select       :String{Helper.localize(locStr:"Please select area of sector.")}
    static var kEmpty_Organization_Location   :String{Helper.localize(locStr:"Please enter organization location.")}
    static var kEmpty_Organization_Address    :String{Helper.localize(locStr:"Please enter organization address.")}
    static var kEmpty_Organization_Description:String{Helper.localize(locStr:"Please enter organization description.")}
    static var kDesignation_Not_Select        :String{Helper.localize(locStr:"Please select designation.")}
    static var kJobLocation_Not_Select        :String{Helper.localize(locStr:"Please select job location.")}
    static var kSpecialization_Not_Select     :String{Helper.localize(locStr:"Please select specialization")}
    static var kExprience_Not_Select          :String{Helper.localize(locStr:"Please select experience.")}
    static var kEmpty_NoVacancies             :String{Helper.localize(locStr:"Please enter number of vacancies.")}
    static var kEmpty_Skills                  :String{Helper.localize(locStr:"Please enter skills required.")}
    static var kLastDateApplication_Not_Select:String{Helper.localize(locStr:"Please select last date of application.")}
    static var kHiringProcess_Not_Select      :String{Helper.localize(locStr:"Please select hiring process.")}
    static var kProfile_Not_Update            :String{Helper.localize(locStr:"Please update your profile before posting a job.")}
    static var date_msg                       :String{Helper.localize(locStr:"Please enter job date")}
    static var imageMsg                       :String{Helper.localize(locStr: "Please select image")}
    static var kProfile_update                :String{Helper.localize(locStr: "Please update your profile before moving further.")}
    static var kSign_Out                      :String{Helper.localize(locStr: "Are you sure you want to Sign Out?")}
    static var k_Job_Delete                   :String{Helper.localize(locStr: "Are you sure you want to delete this job?")}
    static var k_Job_confirm                  :String{Helper.localize(locStr: "Are you sure you want to confirm this job?")}
    static var k_Job_Reject                   :String{Helper.localize(locStr: "Are you sure you want to reject this job?")}
    static var k_Job_complete                 :String{Helper.localize(locStr: "Are you sure you want to Reject this job?")}
    static var kGuestLogin_Leave              :String{Helper.localize(locStr: "Signup/Login to use the account based features for Fannan , do you want to Login ?")}
    static var kConfirm_Job_Apply             :String{Helper.localize(locStr: "Are you sure you want to apply for this job?")}
    static var kDelete_Job                    :String{Helper.localize(locStr: "Are you sure you want to delete this job?")}
    static var k_email_validation             :String{Helper.localize(locStr: "Your account has been created successfully, you'll receive the verification link by email shortly.")}
    static var k_Job_Complete                 :String{Helper.localize(locStr: "Are you sure you want to complete this job?")}
    static var booking_msg                    :String{Helper.localize(locStr:  "This booking will charge")}
    static var booking_msg2               :String{Helper.localize(locStr: " If the Artist will confirm the request, then you can pay to confirm the order. Do you want to continue with the booking?")}
    static var ACCOUNT_NUM                :String{Helper.localize(locStr: "Oops! Please enter Account number.")}
    static var COUNTRY_MES                :String{Helper.localize(locStr: "Oops! Please enter country.")}
    static var CITY_MES                   :String{Helper.localize(locStr: "Oops! Please enter city.")}
    static var address_MES                :String{Helper.localize(locStr: "Oops! Please select address.")}
    static var IBAN_NUM                   :String{Helper.localize(locStr: "Oops! Please enter IBAN number.")}
    static var bank_Name_NUM              :String{Helper.localize(locStr: "Oops! Please enter bank Name.")}
    static var account_holder_NUM         :String{Helper.localize(locStr: "Oops! Please enter account holder Name.")}
    static var cancel_Booking             :String{Helper.localize(locStr: "Are you sure you want to cancel the job?")}
    static var accept_booking             :String{Helper.localize(locStr: "Are you sure you want to accept the job?")}
    static var decline_booking            :String{Helper.localize(locStr: "Are you sure you want to decline the job?")}
    static var reject_booking             :String{Helper.localize(locStr: "Are you sure you want to reject the job?")}
    static var start_booking              :String{Helper.localize(locStr: "Are you sure you want to start the job?")}
    static var postbook_msg               :String{Helper.localize(locStr: "Booking will charge you SAR ")}
    static var applied_msg                :String{Helper.localize(locStr: "Your job application has been submitted successfully.Please visit job history for more details.")}
    
    static var delete_jobs_msg            :String{Helper.localize(locStr: "You can't delete this job because Artists have applied already.")}
    
    static var edit_jobs_msg            :String{Helper.localize(locStr: "You can't edit this job because Artists have applied already.")}
    
    static var term_msg                   :String{Helper.localize(locStr: "Please accept terms and conditions.")}
    
    static var subcategory_msg            :String{Helper.localize(locStr: "Please select subcategories.")}
    
    static var jobCategory_msg      :String{Helper.localize(locStr: "Please select job category.")}
    static var hours_msg            :String{Helper.localize(locStr: "Please select job hours.")}
    static var roleMsg              :String{Helper.localize(locStr: "Please select a role")}
    static var locEnableMsg         :String{Helper.localize(locStr: "Your current location will be displayed on the map and used for nearby search Jobs.")}
    static var bioMsg               :String{Helper.localize(locStr: "Please enter your bio")}
    static var selectVdofromGallery :String{Helper.localize(locStr: "Select Video From Gallery")}
    static var selectProducts       :String{Helper.localize(locStr: "Please select services to continue")}
    static var bookMsg              :String{Helper.localize(locStr: "Artist booked successfully")}
    static var price_ChargingMsg :String{Helper.localize(locStr:"Hey, for this job the artist will charge")}
    static var emailSocial :String{Helper.localize(locStr:"No email found associated with the given account")}
    static var confirmedJob :String{Helper.localize(locStr:"Artist is confirmed for the job please pay the pending invoice for artist to start.")}
    
    static var EMTY_TITLE            :String{Helper.localize(locStr:"Please enter title.")}
    static var boiMsg                :String{Helper.localize(locStr:"Please enter bio.")}
    static var cityMsg               :String{Helper.localize(locStr:"Please enter city")}
    static var countryMsg            :String{Helper.localize(locStr:"Please enter country")}
    static var oldP_msg              :String{Helper.localize(locStr:"Please enter your old password.")}
    static var kEmpty_Description    :String{Helper.localize(locStr:"Please enter description.")}
    static var lastNameStr           :String{Helper.localize(locStr:"Please enter last name.")}
    static var kDelete_Qualification :String{Helper.localize(locStr:"Do you want to remove qualification?")}
    static var msgDeleteProduct      :String{Helper.localize(locStr:"Do you want to remove product?")}
    static var msgDeleteProfile      :String{Helper.localize(locStr:"Do you want to remove profile?")}
    static var ratemsg               :String{Helper.localize(locStr:"Please enter rate")}
    static var catemsg               :String{Helper.localize(locStr:"Please select category.")}
    static var gender_msg            :String{Helper.localize(locStr:"Please select gender.")}
    static var deleteGallery         :String{Helper.localize(locStr:"Do you want to remove gallery?")}
    static var deleteCertificate     :String{Helper.localize(locStr:"Do you want to remove Certificate?")}
    static var check_field           :String{Helper.localize(locStr:"Please check All Fields")}
    static var image_alert           :String{Helper.localize(locStr:"Please select image")}
    static var price_alert           :String{Helper.localize(locStr:"Please select price")}
    static var bidPrice           :String{Helper.localize(locStr:"Please enter bid price")}
    static var videoSaved            :String{Helper.localize(locStr:"Video was saved")}
    static var vdoFailed             :String{Helper.localize(locStr:"Video failed to save")}
    static var vdoUploadSuccess      :String{Helper.localize(locStr:"Video uploaded sucessfully")}
    
    static var job_time_Msg:String{Helper.localize(locStr:"It looks like you are finishing this job before the working time , job can only be finished 15 minutes before end time.")}
    static var pay_Success :String{Helper.localize(locStr:"Payment completed successfully")}
    
    //MARK:- Alert
    static func show(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert);
        
        //to change font of title and message.
        let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)]
        let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light)]
        
        let titleAttrString = NSMutableAttributedString(string: titleStr, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: messageStr, attributes: messageFont)
        
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func showH( titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        //vc.present(alert, animated: true, completion: nil)
        
        
        appDelegate?.window??.rootViewController?.present(alert, animated: true, completion: { })
    }
    static func show_no_internet(titleStr:String, messageStr:String) -> Void
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        
        app_delegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func showH(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        //vc.present(alert, animated: true, completion: nil)
        
        
        appDelegate?.window??.rootViewController?.present(alert, animated: true, completion: { })
    }
    
    static  func alert_PopMathod(vc: UIViewController, title:String!,message_Str : String! , action_Title:[String?] , action_Style:[UIAlertAction.Style] , action:[((UIAlertAction)->Void)])
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        //to change font of title and message.
        let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)]
        let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light)]
        
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: message_Str, attributes: messageFont)
        
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        for (index , title ) in action_Title.enumerated()
        {
            let titleString = NSMutableAttributedString(string: title ?? "", attributes: titleFont)
            
            let action = UIAlertAction(title: titleString.string, style: action_Style[index], handler: action[index])
            
            alert.addAction(action)
        }
        vc.present(alert, animated: false, completion: nil);
    }
    
    
    static  func actionSheet_PopMathod(vc: UIViewController, title:String!,message_Str : String! , action_Title:[String?] , action_Style:[UIAlertAction.Style] , action:[((UIAlertAction)->Void)])
    {
        let alert = UIAlertController(title: title, message: message_Str, preferredStyle: .actionSheet)
        for (index , title ) in action_Title.enumerated()
        {
            let action = UIAlertAction(title: title, style: action_Style[index], handler: action[index])
            alert.addAction(action)
        }
        vc.present(alert, animated: true, completion: nil);
    }
    
    static func showToast(message : String! , view_VC : UIViewController) {
        
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        
        toastLabel.numberOfLines = 0
        var  wid_str = toastLabel.intrinsicContentSize.width
        
        if wid_str > view_VC.view.frame.size.width
        {
            wid_str = view_VC.view.frame.width // - 30
            
            toastLabel.frame =   CGRect(x: 15 , y: view_VC.view.frame.size.height-150, width: wid_str-30, height: 90)
        }
        else
        {
            toastLabel.frame =   CGRect(x: (view_VC.view.frame.size.width/2 - wid_str/2)-15, y: view_VC.view.frame.size.height-150, width: wid_str+30, height: 55)
        }
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        
        
        view_VC.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    static func showMiddleToast(message : String! , view_VC : UIViewController) {
        
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        
        toastLabel.numberOfLines = 0
        var  wid_str = toastLabel.intrinsicContentSize.width
        
        if wid_str > view_VC.view.frame.size.width
        {
            wid_str = view_VC.view.frame.width // - 30
            
            toastLabel.frame =   CGRect(x: 15 , y: view_VC.view.frame.size.height/2, width: wid_str-30, height: 90)
        }
        else
        {
            toastLabel.frame =   CGRect(x: (view_VC.view.frame.size.width/2 - wid_str/2)-15, y: view_VC.view.frame.size.height/2, width: wid_str+30, height: 55)
        }
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        
        
        appDelegate?.window??.rootViewController?.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
   static func getCountryCallingCode(countryRegionCode:String)->String{

            let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
            let countryDialingCode = prefixCodes[countryRegionCode]
            return countryDialingCode ?? ""

    }
    
}
