//
//  DateWiseWeeklyPlan_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 28/12/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
/*
struct DateWiseWeeklyPlan_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let weekly_plan_id : Int?
    let weekly_plan_details : Weekly_plan_details?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case weekly_plan_id = "weekly_plan_id"
        case weekly_plan_details = "weekly_plan_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        weekly_plan_id = try values.decodeIfPresent(Int.self, forKey: .weekly_plan_id)
        weekly_plan_details = try values.decodeIfPresent(Weekly_plan_details.self, forKey: .weekly_plan_details)
    }

}
struct Weekly_plan_details : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let tags : String?
    let plan_note : String?
    let pdf_file : String?
    let category : [String]?
    let diet_type : [String]?
    let days : [Days]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case tags = "tags"
        case plan_note = "plan_note"
        case pdf_file = "pdf_file"
        case category = "category"
        case diet_type = "diet_type"
        case days = "days"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        plan_note = try values.decodeIfPresent(String.self, forKey: .plan_note)
        pdf_file = try values.decodeIfPresent(String.self, forKey: .pdf_file)
        category = try values.decodeIfPresent([String].self, forKey: .category)
        diet_type = try values.decodeIfPresent([String].self, forKey: .diet_type)
        days = try values.decodeIfPresent([Days].self, forKey: .days)
    }

}

struct Recipe_list : Codable {
    let weekly_recipe_id : Int?
    let recipe_id : Int?
    let recipe_name : String?
    let total_servings : String?
    let recipe_img : String?
    let calorific_value : String?
    let carbs_value : Int?
    let proteins_value : Int?
    let fat_value : Int?

    enum CodingKeys: String, CodingKey {

        case weekly_recipe_id = "weekly_recipe_id"
        case recipe_id = "recipe_id"
        case recipe_name = "recipe_name"
        case total_servings = "total_servings"
        case recipe_img = "recipe_img"
        case calorific_value = "calorific_value"
        case carbs_value = "carbs_value"
        case proteins_value = "proteins_value"
        case fat_value = "fat_value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weekly_recipe_id = try values.decodeIfPresent(Int.self, forKey: .weekly_recipe_id)
        recipe_id = try values.decodeIfPresent(Int.self, forKey: .recipe_id)
        recipe_name = try values.decodeIfPresent(String.self, forKey: .recipe_name)
        total_servings = try values.decodeIfPresent(String.self, forKey: .total_servings)
        recipe_img = try values.decodeIfPresent(String.self, forKey: .recipe_img)
        calorific_value = try values.decodeIfPresent(String.self, forKey: .calorific_value)
        carbs_value = try values.decodeIfPresent(Int.self, forKey: .carbs_value)
        proteins_value = try values.decodeIfPresent(Int.self, forKey: .proteins_value)
        fat_value = try values.decodeIfPresent(Int.self, forKey: .fat_value)
    }

}
*/
// MARK: - GetDateWiseWeeklyPlanDetailsStruct
/*struct DateWiseWeeklyPlan_Struct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var weeklyPlanID: Int?
    var weeklyPlanDetails: WeeklyPlanDetails?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case weeklyPlanID = "weekly_plan_id"
        case weeklyPlanDetails = "weekly_plan_details"
    }
}

//// MARK: - WeeklyPlanDetails
//struct WeeklyPlanDetailsdata: Codable {
//    var id: Int?
//    var name, weeklyPlanDetailsDescription, tags, planNote: String?
//    var pdfFile: String?
//    var category: [CategoryModel]?
//    var dietType: [DietType]?
//    var days: [DayData]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case weeklyPlanDetailsDescription = "description"
//        case tags
//        case planNote = "plan_note"
//        case pdfFile = "pdf_file"
//        case category
//        case dietType = "diet_type"
//        case days
//    }
//}

// MARK: - Day
struct DayData: Codable {
    var dayID: Int?
    var dayName: String?
    var calorificValue, carbsValue, proteinsValue, fatValue: Int?
    var totalFatPercentage, totalProteinPercentage, totalCarbPercentage: String?
    var mealList: [WeeklyPlanDetailsMealList]?
    var dayDate: String?

    enum CodingKeys: String, CodingKey {
        case dayID = "day_id"
        case dayName = "day_name"
        case calorificValue = "calorific_value"
        case carbsValue = "carbs_value"
        case proteinsValue = "proteins_value"
        case fatValue = "fat_value"
        case totalFatPercentage = "total_fat_percentage"
        case totalProteinPercentage = "total_protein_percentage"
        case totalCarbPercentage = "total_carb_percentage"
        case mealList = "meal_list"
        case dayDate = "day_date"
    }
}

// MARK: - MealList
struct WeeklyPlanDetailsMealList: Codable {
    var mealID: Int?
    var mealName: String?
    var calorificValue: String?
    var carbsValue, proteinsValue, fatValue: Int?
    var recipeList: [WeeklyPlanDetailsRecipeList]?

    enum CodingKeys: String, CodingKey {
        case mealID = "meal_id"
        case mealName = "meal_name"
        case calorificValue = "calorific_value"
        case carbsValue = "carbs_value"
        case proteinsValue = "proteins_value"
        case fatValue = "fat_value"
        case recipeList = "recipe_list"
    }
}


// MARK: - RecipeList
struct WeeklyPlanDetailsRecipeList: Codable {
    var weeklyRecipeID, recipeID: Int?
    var recipeName: String?
    var totalServings: String?
    var recipeImg: String?
    var calorificValue: String?
    var carbsValue, proteinsValue, fatValue: Int?

    enum CodingKeys: String, CodingKey {
        case weeklyRecipeID = "weekly_recipe_id"
        case recipeID = "recipe_id"
        case recipeName = "recipe_name"
        case totalServings = "total_servings"
        case recipeImg = "recipe_img"
        case calorificValue = "calorific_value"
        case carbsValue = "carbs_value"
        case proteinsValue = "proteins_value"
        case fatValue = "fat_value"
    }
}

*/

struct DateWiseWeeklyPlan_Struct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var weeklyPlanID: Int?
    var weeklyPlanDetails: WeeklyPlanDetailsData?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case weeklyPlanID = "weekly_plan_id"
        case weeklyPlanDetails = "weekly_plan_details"
    }
}

// MARK: - WeeklyPlanDetails
struct WeeklyPlanDetailsData: Codable {
    var id: Int?
    var name, weeklyPlanDetailsDescription, tags, planNote: String?
    var pdfFile: String?
    var category: [String]?
    var dietType: [DietTypeData]?
    var days: [Daydata]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case weeklyPlanDetailsDescription = "description"
        case tags
        case planNote = "plan_note"
        case pdfFile = "pdf_file"
        case category
        case dietType = "diet_type"
        case days
    }
}

// MARK: - Day
struct Daydata: Codable {
    var dayID: Int?
    var dayName: String?
    var calorificValue, carbsValue, proteinsValue, fatValue: Int?
    var totalFatPercentage, totalProteinPercentage, totalCarbPercentage: String?
    var mealList: [MealListData]?
    var dayDate: String?

    enum CodingKeys: String, CodingKey {
        case dayID = "day_id"
        case dayName = "day_name"
        case calorificValue = "calorific_value"
        case carbsValue = "carbs_value"
        case proteinsValue = "proteins_value"
        case fatValue = "fat_value"
        case totalFatPercentage = "total_fat_percentage"
        case totalProteinPercentage = "total_protein_percentage"
        case totalCarbPercentage = "total_carb_percentage"
        case mealList = "meal_list"
        case dayDate = "day_date"
    }
}

// MARK: - MealList
struct MealListData: Codable {
    var mealID: Int?
    var mealName: MealName?
    var calorificValue: String?
    var carbsValue, proteinsValue, fatValue: Int?
    var recipeList: [RecipeListWeeklyPlan]?

    enum CodingKeys: String, CodingKey {
        case mealID = "meal_id"
        case mealName = "meal_name"
        case calorificValue = "calorific_value"
        case carbsValue = "carbs_value"
        case proteinsValue = "proteins_value"
        case fatValue = "fat_value"
        case recipeList = "recipe_list"
    }
}

enum MealName: String, Codable {
    case breakfast = "Breakfast"
    case dinner = "Dinner"
    case lunch = "Lunch"
    case other = "Other"
    case snacks = "Snacks"
}

// MARK: - RecipeList
struct RecipeListWeeklyPlan: Codable {
    var weeklyRecipeID, recipeID: Int?
    var recipeName: String?
    var totalServings: String?
    var recipeImg: String?
    var calorificValue: String?
    var carbsValue, proteinsValue, fatValue: Int?

    enum CodingKeys: String, CodingKey {
        case weeklyRecipeID = "weekly_recipe_id"
        case recipeID = "recipe_id"
        case recipeName = "recipe_name"
        case totalServings = "total_servings"
        case recipeImg = "recipe_img"
        case calorificValue = "calorific_value"
        case carbsValue = "carbs_value"
        case proteinsValue = "proteins_value"
        case fatValue = "fat_value"
    }
}

enum RecipeName: String, Codable {
    case ch = "Ch"
    case test2 = "Test2"
    case vadaPav = "Vada pav"
}

// MARK: - DietType
struct DietTypeData: Codable {
    var dietTypeID: Int?
    var dietTypeName: String?

    enum CodingKeys: String, CodingKey {
        case dietTypeID = "diet_type_id"
        case dietTypeName = "diet_type_name"
    }
}
