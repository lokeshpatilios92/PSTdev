//
//  FindNewRecipes_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 18/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct FindNewRecipe_Struct : Codable {
    var status : Bool?
    var status_code : Int?
    var message : String?
    var findRecipeCount : Int?
    var recipeBoxViewTypeList : [RecipeBoxViewTypeList]?
    var recipeList : [RecipeList]?
    var chefList : [ChefList]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case findRecipeCount = "findRecipeCount"
        case recipeBoxViewTypeList = "recipeBoxViewTypeList"
        case recipeList = "recipeList"
        case chefList = "chefList"
    }
}

struct ChefList : Codable {
    var chef_id : Int?
    var name : String?
    var chef_pic : String?
    var avg_ratings : Ratting?
    var total_ratings : Int?
    var total_recipes : Int?
    var total_blog : Int?
    var total_subscribers : Int?
    var monthly_subscription_cost : String?
    var added_date : String?

    enum CodingKeys: String, CodingKey {

        case chef_id = "chef_id"
        case name = "name"
        case chef_pic = "chef_pic"
        case avg_ratings = "avg_ratings"
        case total_ratings = "total_ratings"
        case total_recipes = "total_recipes"
        case total_blog = "total_blog"
        case total_subscribers = "total_subscribers"
        case monthly_subscription_cost = "monthly_subscription_cost"
        case added_date = "added_date"
    }
}
