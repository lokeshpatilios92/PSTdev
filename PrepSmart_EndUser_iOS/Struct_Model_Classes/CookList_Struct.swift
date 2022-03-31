//
//  CookList_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 24/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct CookList_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let cooklist_details : Cooklist_details?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case cooklist_details = "cooklist_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        cooklist_details = try values.decodeIfPresent(Cooklist_details.self, forKey: .cooklist_details)
    }

}
struct Cooklist_details : Codable {
    let id : Int?
    let name : String?
    let days : [Days]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case days = "days"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        days = try values.decodeIfPresent([Days].self, forKey: .days)
    }

}
struct Days : Codable {
    let day_id : Int?
    let day_name : String?
    let day_date : String?
    let calorific_value : Int?
    let carbs_value : Int?
    let proteins_value : Int?
    let fat_value : Int?
    let meal_list : [Meal_list]?

    enum CodingKeys: String, CodingKey {

        case day_id = "day_id"
        case day_name = "day_name"
        case day_date = "day_date"
        case calorific_value = "calorific_value"
        case carbs_value = "carbs_value"
        case proteins_value = "proteins_value"
        case fat_value = "fat_value"
        case meal_list = "meal_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day_id = try values.decodeIfPresent(Int.self, forKey: .day_id)
        day_name = try values.decodeIfPresent(String.self, forKey: .day_name)
        day_date = try values.decodeIfPresent(String.self, forKey: .day_date)
        calorific_value = try values.decodeIfPresent(Int.self, forKey: .calorific_value)
        carbs_value = try values.decodeIfPresent(Int.self, forKey: .carbs_value)
        proteins_value = try values.decodeIfPresent(Int.self, forKey: .proteins_value)
        fat_value = try values.decodeIfPresent(Int.self, forKey: .fat_value)
        meal_list = try values.decodeIfPresent([Meal_list].self, forKey: .meal_list)
    }

}

struct Meal_list : Codable {
    let meal_id : Int?
    let meal_name : String?
    let calorific_value : Int?
    let carbs_value : Int?
    let proteins_value : Int?
    let fat_value : Int?
    let recipe_list : [Recipe_list1]?

    enum CodingKeys: String, CodingKey {

        case meal_id = "meal_id"
        case meal_name = "meal_name"
        case calorific_value = "calorific_value"
        case carbs_value = "carbs_value"
        case proteins_value = "proteins_value"
        case fat_value = "fat_value"
        case recipe_list = "recipe_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meal_id = try values.decodeIfPresent(Int.self, forKey: .meal_id)
        meal_name = try values.decodeIfPresent(String.self, forKey: .meal_name)
        calorific_value = try values.decodeIfPresent(Int.self, forKey: .calorific_value)
        carbs_value = try values.decodeIfPresent(Int.self, forKey: .carbs_value)
        proteins_value = try values.decodeIfPresent(Int.self, forKey: .proteins_value)
        fat_value = try values.decodeIfPresent(Int.self, forKey: .fat_value)
        recipe_list = try values.decodeIfPresent([Recipe_list1].self, forKey: .recipe_list)
    }

}
struct Recipe_list1 : Codable {
    let weekly_recipe_id : Int?
    let recipe_id : Int?
    let recipe_name : String?
    let total_servings : String?
    let recipe_img : String?
    let cooking_time : Int?
    let calorific_value : Int?
    let carbs_value : Int?
    let proteins_value : Int?
    let fat_value : Int?
    let chef_id : Int?
    let ingredients_list : [IngredientsList]?
    let instruction : [Instruction]?

    enum CodingKeys: String, CodingKey {

        case weekly_recipe_id = "weekly_recipe_id"
        case recipe_id = "recipe_id"
        case recipe_name = "recipe_name"
        case total_servings = "total_servings"
        case recipe_img = "recipe_img"
        case cooking_time = "cooking_time"
        case calorific_value = "calorific_value"
        case carbs_value = "carbs_value"
        case proteins_value = "proteins_value"
        case fat_value = "fat_value"
        case chef_id = "chef_id"
        case ingredients_list = "ingredients_list"
        case instruction = "instruction"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weekly_recipe_id = try values.decodeIfPresent(Int.self, forKey: .weekly_recipe_id)
        recipe_id = try values.decodeIfPresent(Int.self, forKey: .recipe_id)
        recipe_name = try values.decodeIfPresent(String.self, forKey: .recipe_name)
        total_servings = try values.decodeIfPresent(String.self, forKey: .total_servings)
        recipe_img = try values.decodeIfPresent(String.self, forKey: .recipe_img)
        cooking_time = try values.decodeIfPresent(Int.self, forKey: .cooking_time)
        calorific_value = try values.decodeIfPresent(Int.self, forKey: .calorific_value)
        carbs_value = try values.decodeIfPresent(Int.self, forKey: .carbs_value)
        proteins_value = try values.decodeIfPresent(Int.self, forKey: .proteins_value)
        fat_value = try values.decodeIfPresent(Int.self, forKey: .fat_value)
        chef_id = try values.decodeIfPresent(Int.self, forKey: .chef_id)
        ingredients_list = try values.decodeIfPresent([IngredientsList].self, forKey: .ingredients_list)
        instruction = try values.decodeIfPresent([Instruction].self, forKey: .instruction)
    }

}
struct Instruction : Codable {
    let instruction_id : Int?
    let step : Int?
    let status : Int?
    let step_instruction : String?
    let items : [Items]?

    enum CodingKeys: String, CodingKey {

        case instruction_id = "instruction_id"
        case step = "step"
        case status = "status"
        case step_instruction = "step_instruction"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        instruction_id = try values.decodeIfPresent(Int.self, forKey: .instruction_id)
        step = try values.decodeIfPresent(Int.self, forKey: .step)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        step_instruction = try values.decodeIfPresent(String.self, forKey: .step_instruction)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }

}
struct Items : Codable {
    let item_id : Int?
    let item_name : String?

    enum CodingKeys: String, CodingKey {

        case item_id = "item_id"
        case item_name = "item_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        item_id = try values.decodeIfPresent(Int.self, forKey: .item_id)
        item_name = try values.decodeIfPresent(String.self, forKey: .item_name)
    }

}
