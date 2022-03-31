//
//  DietType_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 06/12/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct DietType_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let diettype_list : [Diettype_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case diettype_list = "diettype_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        diettype_list = try values.decodeIfPresent([Diettype_list].self, forKey: .diettype_list)
    }

}
struct Diettype_list : Codable {
    let diet_id : Int?
    let diet_name : String?

    enum CodingKeys: String, CodingKey {

        case diet_id = "diet_id"
        case diet_name = "diet_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        diet_id = try values.decodeIfPresent(Int.self, forKey: .diet_id)
        diet_name = try values.decodeIfPresent(String.self, forKey: .diet_name)
    }

}
