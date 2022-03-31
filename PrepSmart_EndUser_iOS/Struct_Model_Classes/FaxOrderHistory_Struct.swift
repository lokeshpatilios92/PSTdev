//
//  FaxOrderHistory_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 22/12/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct FaxOrderHistory_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let order_history : [Order_history]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case order_history = "order_history"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        order_history = try values.decodeIfPresent([Order_history].self, forKey: .order_history)
    }

}

struct Order_history : Codable {
    let id : Int?
    let order_id : Int?
    let item_id : Int?
    let ingredient_id : Int?
    let ingredient_name : String?
    let qty : Int?
    let price : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case order_id = "order_id"
        case item_id = "item_id"
        case ingredient_id = "ingredient_id"
        case ingredient_name = "ingredient_name"
        case qty = "qty"
        case price = "price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        item_id = try values.decodeIfPresent(Int.self, forKey: .item_id)
        ingredient_id = try values.decodeIfPresent(Int.self, forKey: .ingredient_id)
        ingredient_name = try values.decodeIfPresent(String.self, forKey: .ingredient_name)
        qty = try values.decodeIfPresent(Int.self, forKey: .qty)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
    }

}
