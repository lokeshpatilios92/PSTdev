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
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case weekly_plan_id = "weekly_plan_id"
        case shopping_list = "shopping_list"
        case alreadyHaveList = "already_have_list"
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
    var name : String?
    var quantity : String?
    var unit : String?
    var m_quantity : String?
    var m_unit : String?
    var weekly_plan_id : Int?
    var recipes_names : String?
    
    enum CodingKeys: String, CodingKey {
        
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

