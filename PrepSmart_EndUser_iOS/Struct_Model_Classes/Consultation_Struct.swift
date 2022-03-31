//
//  Consultation_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 23/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct Consultation_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let booking_list : [Booking_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case booking_list = "booking_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        booking_list = try values.decodeIfPresent([Booking_list].self, forKey: .booking_list)
    }

}
struct Booking_list : Codable {
    let consultation_id : Int?
    let booking_date : String?
    let booking_status_id : Int?
    let booking_status : String?
    let issue : String?
    let user_id : Int?
    let user_name : String?
    let user_pic : String?
    let user_contact : String?
    let user_email : String?
    let chef_reply : String?
    let is_active : Int?
    let is_archived : Int?

    enum CodingKeys: String, CodingKey {

        case consultation_id = "consultation_id"
        case booking_date = "booking_date"
        case booking_status_id = "booking_status_id"
        case booking_status = "booking_status"
        case issue = "issue"
        case user_id = "user_id"
        case user_name = "user_name"
        case user_pic = "user_pic"
        case user_contact = "user_contact"
        case user_email = "user_email"
        case chef_reply = "chef_reply"
        case is_active = "is_active"
        case is_archived = "is_archived"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        consultation_id = try values.decodeIfPresent(Int.self, forKey: .consultation_id)
        booking_date = try values.decodeIfPresent(String.self, forKey: .booking_date)
        booking_status_id = try values.decodeIfPresent(Int.self, forKey: .booking_status_id)
        booking_status = try values.decodeIfPresent(String.self, forKey: .booking_status)
        issue = try values.decodeIfPresent(String.self, forKey: .issue)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        user_pic = try values.decodeIfPresent(String.self, forKey: .user_pic)
        user_contact = try values.decodeIfPresent(String.self, forKey: .user_contact)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
        chef_reply = try values.decodeIfPresent(String.self, forKey: .chef_reply)
        is_active = try values.decodeIfPresent(Int.self, forKey: .is_active)
        is_archived = try values.decodeIfPresent(Int.self, forKey: .is_archived)
    }

}
