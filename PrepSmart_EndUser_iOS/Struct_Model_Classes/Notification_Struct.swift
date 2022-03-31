//
//  Notification_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 12/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct Notification_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let notification_list : [Notification_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case notification_list = "notification_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        notification_list = try values.decodeIfPresent([Notification_list].self, forKey: .notification_list)
    }

}
struct Notification_list : Codable {
    let notification_id : Int?
    let notification_type : Int?
    let title : String?
    let message : String?
    let datetime : String?
    let read_status : Int?

    enum CodingKeys: String, CodingKey {

        case notification_id = "notification_id"
        case notification_type = "notification_type"
        case title = "title"
        case message = "message"
        case datetime = "datetime"
        case read_status = "read_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notification_id = try values.decodeIfPresent(Int.self, forKey: .notification_id)
        notification_type = try values.decodeIfPresent(Int.self, forKey: .notification_type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        read_status = try values.decodeIfPresent(Int.self, forKey: .read_status)
    }

}
