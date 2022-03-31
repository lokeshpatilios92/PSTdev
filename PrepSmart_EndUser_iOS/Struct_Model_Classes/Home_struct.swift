//
//  Home_struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 12/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeStruct = try? newJSONDecoder().decode(HomeStruct.self, from: jsonData)

import Foundation

// MARK: - HomeStruct
struct HomeStruct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var dashbaordData: DashbaordData?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case dashbaordData = "dashbaord_data"
    }
}

// MARK: - DashbaordData
struct DashbaordData: Codable {
    var recipeCountInPlan: Int?
    var daysList: [DaysList]?
    var keyFeatures, otherFeature: [Feature]?

    enum CodingKeys: String, CodingKey {
        case recipeCountInPlan
        case daysList = "days_list"
        case keyFeatures = "key_features"
        case otherFeature = "other_feature"
    }
}

// MARK: - DaysList
struct DaysList: Codable {
    var dayID: Int?
    var dayName, dayDate: String?
    var recipesInDayCount: Int?
    var todaysRecipeList: [TodaysRecipeList]?

    enum CodingKeys: String, CodingKey {
        case dayID = "day_id"
        case dayName = "day_name"
        case dayDate = "day_date"
        case recipesInDayCount = "recipes_in_day_count"
        case todaysRecipeList
    }
}

// MARK: - TodaysRecipeList
struct TodaysRecipeList: Codable {
    var recipeID: Int?
    var recipeName: String?
    var recipeImg: String?

    enum CodingKeys: String, CodingKey {
        case recipeID = "recipe_id"
        case recipeName = "recipe_name"
        case recipeImg = "recipe_img"
    }
}

// MARK: - Feature
struct Feature: Codable {
    var feature: String?
}
