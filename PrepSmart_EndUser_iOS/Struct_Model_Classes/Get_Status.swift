//
//  Get_Status.swift
//  FannanArtist
//
//  Created by mac on 12/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
struct Get_Status : Codable {
    var message = ""
    var status  = Bool()
   
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        
    }
}

struct VersionStruct : Codable {
    var message = ""
    var status  = ""
    var data = ""
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }
}

struct ForgotPassword_Struct : Codable {
    var message = ""
    var status  = Bool()
    var access_token = ""
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case access_token = "access_token"
    }
}

struct GetWeeklyPlan_Struct : Codable {
    var message = ""
    var status  = Bool()
    var status_code = 0
    var pdf_path = ""
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case status_code = "status_code"
        case pdf_path = "pdf_path"
    }
}


struct UpdateConsultation_Struct : Codable {
    var message = ""
    var status  = Bool()
    var status_code = 0
    var consulatation_status = ""
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case status_code = "status_code"
        case consulatation_status = "consulatation_status"
    }
}

struct AppRating_Struct : Codable {
    var message = ""
    var status  = Bool()
    var status_code = 0
    
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case status_code = "status_code"
       
    }
}

struct DeleteItemsFromalreadyHaveShopListStruct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
    }
}
