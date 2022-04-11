//
//  ShoppingList_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 23/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct ShoppingList_Struct : Codable {
    var status : Bool?
    var status_code : Int?
    var message : String?
    var weekly_plan_id : Int?
    var shopping_list : [Shopping_list]?
    var alreadyHaveList : [Shopping_list]?
    var searchShoppingList : [Shopping_list]?
    

    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case weekly_plan_id = "weekly_plan_id"
        case shopping_list = "shopping_list"
        case alreadyHaveList = "already_have_list"
        case searchShoppingList =  "search_shopping_list"
    }
}
struct Shopping_list : Codable {
    var category_id : Int?
    var category_name : String?
    var grocery_list : [Grocery_list]?

    
    enum CodingKeys: String, CodingKey {
        
        case category_id = "category_id"
        case category_name = "category_name"
        case grocery_list = "grocery_list"
    }
}
struct Grocery_list : Codable {
    var ingredient_id : Int?
    var grocery_id : Int?
    var name : String?
    var quantity : String?
    var unit : String?
    var m_quantity : String?
    var m_unit : String?
    var weekly_plan_id : WeeklyPlanID??
    var recipes_names : String?
    
    enum CodingKeys: String, CodingKey {
        case grocery_id =  "grocery_id"
        case ingredient_id = "ingredient_id"
        case name = "name"
        case quantity = "quantity"
        case unit = "unit"
        case m_quantity = "m_quantity"
        case m_unit = "m_unit"
        case weekly_plan_id = "weekly_plan_id"
        case recipes_names = "recipes_names"
    }
}

enum WeeklyPlanID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(WeeklyPlanID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for WeeklyPlanID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct DownloadShopListStruct: Codable {
    var headers: [String]?
    var original: Original?
    var exception: JSONNull?
}

// MARK: - Original
struct Original: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
    }
}
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
