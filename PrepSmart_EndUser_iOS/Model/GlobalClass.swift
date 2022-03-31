//
//  GlobalClass.swift
//  FannanArtist
//
//  Created by mac on 15/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class GlobalClass{
    
    class var sharedManager: GlobalClass {
        struct Static {
            static let instance = GlobalClass()
        }
      return Static.instance
    }
    
    //MARK:- Global Variables
 
    public var token = ""
    public var logindicObj : UserLogin_Struct?
    public var get_status = Get_Status()
    public static var lat_str = "0.0"
    public static var long_str = "0.0"
    public var currentJobNavigation = 0
    
    public var strDeviceToken :String?   = String()
    public var strFBDeviceToken :String? = String()
    public var strFBDeviceId = ""
    public var strDeviceID :String?   =   "1234"
    
    public var contentArr : [String] = []
}
