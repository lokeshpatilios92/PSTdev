//
//  AppData_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 21/01/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import Foundation
struct AppData_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let intro_data : [Intro_data]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case intro_data = "intro_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        intro_data = try values.decodeIfPresent([Intro_data].self, forKey: .intro_data)
    }

}
struct Intro_data : Codable {
    let id : Int?
    let title : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
