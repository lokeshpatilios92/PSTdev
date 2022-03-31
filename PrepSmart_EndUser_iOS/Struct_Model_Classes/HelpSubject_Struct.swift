//
//  HelpSubject_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 15/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct HelpSubject_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let help_subjects : [Help_subjects]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case help_subjects = "help_subjects"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        help_subjects = try values.decodeIfPresent([Help_subjects].self, forKey: .help_subjects)
    }

}
struct Help_subjects : Codable {
    let id : Int?
    let name : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
