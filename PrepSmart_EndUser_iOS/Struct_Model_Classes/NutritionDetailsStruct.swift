//
//  File.swift
//  PrepSmart_EndUser_iOS
//
//  Created by m@k on 29/03/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import Foundation

// MARK: - NutritionDetailsStruct
struct NutritionDetailsStruct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var recipeNutritionixInfo: RecipeNutritionixInfo?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case recipeNutritionixInfo = "recipe_nutritionix_info"
    }
}

// MARK: - RecipeNutritionixInfo
struct RecipeNutritionixInfo: Codable {
    var nfCalories, nfTotalFat, nfSaturatedFat, nfCholesterol: String?
    var nfSodium, nfDietaryFiber, nfSugars, nfProtein: String?
    var nfPotassium, servingWeightGrams, nfTotalCarbohydrate: String?

    enum CodingKeys: String, CodingKey {
        case nfCalories = "nf_calories"
        case nfTotalFat = "nf_total_fat"
        case nfSaturatedFat = "nf_saturated_fat"
        case nfCholesterol = "nf_cholesterol"
        case nfSodium = "nf_sodium"
        case nfDietaryFiber = "nf_dietary_fiber"
        case nfSugars = "nf_sugars"
        case nfProtein = "nf_protein"
        case nfPotassium = "nf_potassium"
        case servingWeightGrams = "serving_weight_grams"
        case nfTotalCarbohydrate = "nf_total_carbohydrate"
    }
}
