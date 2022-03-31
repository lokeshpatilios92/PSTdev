//
//  PrivacyPolicy_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 11/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct PrivacyPolicy_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let content : [Content]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case content = "content"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        content = try values.decodeIfPresent([Content].self, forKey: .content)
    }

}

struct Content : Codable {
    let id : Int?
    let title : String?
    let content_data : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case content_data = "content_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        content_data = try values.decodeIfPresent(String.self, forKey: .content_data)
    }

}

