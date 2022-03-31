//
//  SettingsStruct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 06/12/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct SettingsStruct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let user_setting : [User_setting]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case user_setting = "user_setting"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        user_setting = try values.decodeIfPresent([User_setting].self, forKey: .user_setting)
    }

}
struct User_setting : Codable {
    let setting_id : Int?
    let name : String?
    let desc : String?
    let user_setting_status : Int?

    enum CodingKeys: String, CodingKey {

        case setting_id = "setting_id"
        case name = "name"
        case desc = "desc"
        case user_setting_status = "user_setting_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        setting_id = try values.decodeIfPresent(Int.self, forKey: .setting_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        user_setting_status = try values.decodeIfPresent(Int.self, forKey: .user_setting_status)
    }

}
