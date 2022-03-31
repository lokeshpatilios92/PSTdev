//
//  MySubscription_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 23/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct MySubscription_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let my_subscriptions : [My_subscriptions]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case my_subscriptions = "my_subscriptions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        my_subscriptions = try values.decodeIfPresent([My_subscriptions].self, forKey: .my_subscriptions)
    }

}
struct My_subscriptions : Codable {
    let id : Int?
    let cost : Int?
    let type : Int?
    let image_url : String?
    let reviews : Int?
    let total_recipe : Int?
    let recipe_name : String?
    let chef_name : String?
    let recipe_owner_name : String?
    let recipe_image_url : String?
    let plan_name : String?
    let subscription_for : String?
    let plan_description : String?
    let is_price_updated : String?
    let price_update_date : String?
    let updated_price : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cost = "cost"
        case type = "type"
        case image_url = "image_url"
        case reviews = "reviews"
        case total_recipe = "total_recipe"
        case recipe_name = "recipe_name"
        case chef_name = "chef_name"
        case recipe_owner_name = "recipe_owner_name"
        case recipe_image_url = "recipe_image_url"
        case plan_name = "plan_name"
        case subscription_for = "subscription_for"
        case plan_description = "plan_description"
        case is_price_updated = "is_price_updated"
        case price_update_date = "price_update_date"
        case updated_price = "updated_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        reviews = try values.decodeIfPresent(Int.self, forKey: .reviews)
        total_recipe = try values.decodeIfPresent(Int.self, forKey: .total_recipe)
        recipe_name = try values.decodeIfPresent(String.self, forKey: .recipe_name)
        chef_name = try values.decodeIfPresent(String.self, forKey: .chef_name)
        recipe_owner_name = try values.decodeIfPresent(String.self, forKey: .recipe_owner_name)
        recipe_image_url = try values.decodeIfPresent(String.self, forKey: .recipe_image_url)
        plan_name = try values.decodeIfPresent(String.self, forKey: .plan_name)
        subscription_for = try values.decodeIfPresent(String.self, forKey: .subscription_for)
        plan_description = try values.decodeIfPresent(String.self, forKey: .plan_description)
        is_price_updated = try values.decodeIfPresent(String.self, forKey: .is_price_updated)
        price_update_date = try values.decodeIfPresent(String.self, forKey: .price_update_date)
        updated_price = try values.decodeIfPresent(String.self, forKey: .updated_price)
    }

}
