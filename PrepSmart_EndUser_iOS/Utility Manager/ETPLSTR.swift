//
//  ETPLSTR.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import UIKit

class ETPLSTR: NSObject {

    
    static let KEY_PLA_URL              = "KEY_PLA_URL"
    static let KEY_BASEURL              = "KEY_BASEURL"
    static let KEY_KEEP_ME_LOGGED_IN    = "KEY_KEEP_ME_LOGGED_IN"
    static let KEY_USERNAME             = "KEY_USERNAME"
    static let KEY_PASSWORD             = "KEY_PASSWORD"
    
    static let KEY_IS_LOGGED_IN                 = "KEY_IS_LOGGED_IN"
    static let KEY_IS_ENDUSER_LOGGED_IN         = "KEY_IS_ENDUSER_LOGGED_IN"
    static let KEY_DEVICE_TOKEN                 = "KEY_DEVICE_TOKEN"
    static let KEY_SHOULD_UPDATE_ACCESS_TOKEN   = "KEY_SHOULD_UPDATE_ACCESS_TOKEN"
    static let KEY_PREVIOUS_ACCESS_TOKEN        = "KEY_PREVIOUS_ACCESS_TOKEN"
    static let KEY_USER_DEFAULT_USERID          = "KEY_USER_DEFAULT_USERID"
    static let KEY_USER_DEFAULT_USER_ROLE_ID    = "KEY_USER_DEFAULT_USER_ROLE_ID"
    static let KEY_user_role_id                 = "user_role_id"
    
    
    //    API Messages
    static let MSG_STYLE_CREATED_SUCCESSFULLY   = "Style created successfully."
    static let ERROR_NO_INTERNET_CONNECTION     = "The Internet connection appears to be offline."
    static let ERROR_SERVER_NOT_RESPONDING      = "The server is not responding. Please try again later."
    

    //    MARK: Buttons
    static let BUTTON_REGISTER               = "REGISTER"
    static let BUTTON_SUBMIT                 = "SUBMIT"
    static let BUTTON_RESET_PWD              = "RESET PASSWORD"
    static let BUTTON_FORGOT_PWD             = "Forgot Password?"
    static let BUTTON_CANCEL                 = "Cancel"
    static let BUTTON_UPDATE_PLAN            = "Upgrade Plan"
    static let BUTTON_UPDATE                 = "UPDATE"
    static let BUTTON_OK                     = "OK"
    
    //    MARK: Custom Alert Mesg
    static let ALERT_PASSWORD_CHANGE_SUCCESS = "Password changed successfully.\nPlease log in using your new credencials"
    static let ALERT_SIGNUP_REQUEST_MESG = "An activation link has been emailed to you. Please click the link to verify your account"
}
