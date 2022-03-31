//
//  HelpTopics_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 15/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct HelpTopic_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let all_topics : [All_topics]?
    let recommonded_topics : [Recommonded_topics]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case all_topics = "all_topics"
        case recommonded_topics = "recommonded_topics"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        all_topics = try values.decodeIfPresent([All_topics].self, forKey: .all_topics)
        recommonded_topics = try values.decodeIfPresent([Recommonded_topics].self, forKey: .recommonded_topics)
    }

}
struct Recommonded_topics : Codable {
    let id : Int?
    let name : String?
    let desc : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
    }

}
struct All_topics : Codable {
    let id : Int?
    let name : String?
    let desc : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
    }

}
