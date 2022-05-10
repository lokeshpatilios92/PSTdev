//
//  File.swift
//  PrepSmart_EndUser_iOS
//
//  Created by apple on 09/05/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import Foundation

// MARK: - DayWiseWeeklyPlanNutritionixDetailsStruct
struct DayWiseWeeklyPlanNutritionixDetailsStruct: Codable {
    var status: Bool?
    var statusCode, message: String?
    var dayWiseWeeklyPlanNutritionixDetails: DayWiseWeeklyPlanNutritionixDetails?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case dayWiseWeeklyPlanNutritionixDetails = "day_wise_weekly_plan_nutritionix_details"
    }
}

// MARK: - DayWiseWeeklyPlanNutritionixDetails
struct DayWiseWeeklyPlanNutritionixDetails: Codable {
    var calorificValue: String?
    var carbsValue, proteinsValue, fatValue, totalFatPercentage: Int?
    var totalProteinPercentage, totalCarbPercentage: Int?

    enum CodingKeys: String, CodingKey {
        case calorificValue = "calorific_value"
        case carbsValue = "carbs_value"
        case proteinsValue = "proteins_value"
        case fatValue = "fat_value"
        case totalFatPercentage = "total_fat_percentage"
        case totalProteinPercentage = "total_protein_percentage"
        case totalCarbPercentage = "total_carb_percentage"
    }
}
