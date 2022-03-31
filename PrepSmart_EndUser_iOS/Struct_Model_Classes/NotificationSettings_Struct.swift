//
//  NotificationSettings_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 23/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct NotificationSettings_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let user_data : [User_data]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case user_data = "user_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        user_data = try values.decodeIfPresent([User_data].self, forKey: .user_data)
    }

}
struct User_data : Codable {
    let setting_id : Int?
    let notification_type_name : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case setting_id = "setting_id"
        case notification_type_name = "notification_type_name"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        setting_id = try values.decodeIfPresent(Int.self, forKey: .setting_id)
        notification_type_name = try values.decodeIfPresent(String.self, forKey: .notification_type_name)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
