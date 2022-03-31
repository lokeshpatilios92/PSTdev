//
//  UserLogin_Struct.swift
//  FannanArtist
//
//  Created by mac on 12/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
struct UserLogin_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let userData : UserData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case userData = "userData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(UserData.self, forKey: .userData)
    }

}


struct UserData : Codable {
    let user_id : Int?
    let name : String?
    let login_media : Int?
    let media_token : String?
    let email_id : String?
    let following : Int?
    let followers : Int?
    let total_recipe : Int?
    let membership_id : Int?
    let membership_name : String?
    let profile_pic : String?
    let access_token : String?
    let zipcode : Int?
    let contact_number : String?
    let profile_status : Int?
    let email_status : Int?
    let diet_types : [Diet_types]?
    let user_metric_unit_setting : Int?
    let intNotificationCount : Int?

    enum CodingKeys: String, CodingKey {

        case user_id = "user_id"
        case name = "name"
        case login_media = "login_media"
        case media_token = "media_token"
        case email_id = "email_id"
        case following = "following"
        case followers = "followers"
        case total_recipe = "total_recipe"
        case membership_id = "membership_id"
        case membership_name = "membership_name"
        case profile_pic = "profile_pic"
        case access_token = "access_token"
        case zipcode = "zipcode"
        case contact_number = "contact_number"
        case profile_status = "profile_status"
        case email_status = "email_status"
        case diet_types = "diet_types"
        case user_metric_unit_setting = "user_metric_unit_setting"
        case intNotificationCount = "intNotificationCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        login_media = try values.decodeIfPresent(Int.self, forKey: .login_media)
        media_token = try values.decodeIfPresent(String.self, forKey: .media_token)
        email_id = try values.decodeIfPresent(String.self, forKey: .email_id)
        following = try values.decodeIfPresent(Int.self, forKey: .following)
        followers = try values.decodeIfPresent(Int.self, forKey: .followers)
        total_recipe = try values.decodeIfPresent(Int.self, forKey: .total_recipe)
        membership_id = try values.decodeIfPresent(Int.self, forKey: .membership_id)
        membership_name = try values.decodeIfPresent(String.self, forKey: .membership_name)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
        zipcode = try values.decodeIfPresent(Int.self, forKey: .zipcode)
        contact_number = try values.decodeIfPresent(String.self, forKey: .contact_number)
        profile_status = try values.decodeIfPresent(Int.self, forKey: .profile_status)
        email_status = try values.decodeIfPresent(Int.self, forKey: .email_status)
        diet_types = try values.decodeIfPresent([Diet_types].self, forKey: .diet_types)
        user_metric_unit_setting = try values.decodeIfPresent(Int.self, forKey: .user_metric_unit_setting)
        intNotificationCount = try values.decodeIfPresent(Int.self, forKey: .intNotificationCount)
    }

}

struct Diet_types : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
