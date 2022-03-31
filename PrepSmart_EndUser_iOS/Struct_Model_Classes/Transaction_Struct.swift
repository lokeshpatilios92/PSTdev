//
//  Transaction_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 23/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct Transaction_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let transaction_history : [Transaction_history]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case transaction_history = "transaction_history"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        transaction_history = try values.decodeIfPresent([Transaction_history].self, forKey: .transaction_history)
    }

}
struct Transaction_history : Codable {
    let id : Int?
    let transaction_id : String?
    let date_time : String?
    let cost : Int?
    let subscription_type : Int?
    let reference_id : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case transaction_id = "transaction_id"
        case date_time = "date_time"
        case cost = "cost"
        case subscription_type = "subscription_type"
        case reference_id = "reference_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        subscription_type = try values.decodeIfPresent(Int.self, forKey: .subscription_type)
        reference_id = try values.decodeIfPresent(Int.self, forKey: .reference_id)
    }

}

