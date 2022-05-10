//
//  File.swift
//  PrepSmart_EndUser_iOS
//
//  Created by apple on 14/03/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import Foundation
// MARK: - GetWeeklyPlanTemplateDetailsStruct
struct GetWeeklyPlanTemplateDetailsStruct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var weeklyPlanDetails: WeeklyPlanDetails?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case weeklyPlanDetails = "weekly_plan_details"
    }
}

// MARK: - WeeklyPlanDetails
struct WeeklyPlanDetails: Codable {
    var id: Int?
    var name, weeklyPlanDetailsDescription, tags, planNote: String?
    var pdfFile: String?
    var category: [Category_list]?
    var dietType: [DietType]?
    var days: [Day]?

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
struct Day: Codable {
    var dayID: Int?
    var dayName, calorificValue: String?
    var carbsValue, proteinsValue, fatValue: Int?
    var totalFatPercentage, totalProteinPercentage, totalCarbPercentage: TotalPercentage?
    var mealList: [MealList]?

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
    }
}

// MARK: - MealList
struct MealList: Codable {
    var mealID: Int?
    var mealName: String?
    var calorificValue, carbsValue, proteinsValue, fatValue: Int?
    var recipeList: [RecipeListData]?
    var isExpandable:Bool = false
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
struct RecipeListData: Codable {
    var weeklyRecipeID, recipeID: Int?
    var recipeName, totalServings: String?
    var recipeImg: String?
    var calorificValue, carbsValue, proteinsValue, fatValue: Int?
    var addedDate, addedDay: String?

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
        case addedDate = "added_date"
        case addedDay = "added_day"
    }
}

enum TotalPercentage: Codable {
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
        throw DecodingError.typeMismatch(TotalPercentage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TotalPercentage"))
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
