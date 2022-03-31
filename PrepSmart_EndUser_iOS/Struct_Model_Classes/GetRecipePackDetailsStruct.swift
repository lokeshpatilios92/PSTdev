//
//  File.swift
//  PrepSmart_EndUser_iOS
//
//  Created by m@k on 13/03/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import Foundation

// MARK: - GetRecipePackDetailsStruct
struct GetRecipePackDetailsStruct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var recipePackID: Int?
    var name, getRecipePackDetailsStructDescription, tag: String?
    var dietType: [DietType]?
    var category: [Category_list]
    var season: [Season]?
    var listOfRecipes: [ListOfRecipe]?
    var packSortList, packFilterList: [String]?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case recipePackID = "recipe_pack_id"
        case name
        case getRecipePackDetailsStructDescription = "description"
        case tag, dietType, category, season, listOfRecipes, packSortList, packFilterList
    }
}


// MARK: - ListOfRecipe
struct ListOfRecipe: Codable {
    var itemID, recipeID: Int?
    var recipeName: String?
    var chefID: Int?
    var recipeImage: String?
    var recipeLabel: String?
    var isTagImagePresent, ratting, likeCount, prepsmartFlag: Int?
    var season: String?
    var recipeType: Int?
    var createdAt: String?
    var seasonFlag, trending, premium, bestSelling: Int?
    var isTop, subscriptionStatus: Int?

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case recipeID = "recipe_id"
        case recipeName = "recipe_name"
        case chefID = "chef_id"
        case recipeImage = "recipe_image"
        case recipeLabel = "recipe_label"
        case isTagImagePresent = "is_tag_image_present"
        case ratting
        case likeCount = "like_count"
        case prepsmartFlag = "prepsmart_flag"
        case season
        case recipeType = "recipe_type"
        case createdAt = "created_at"
        case seasonFlag = "season_flag"
        case trending, premium, bestSelling
        case isTop = "is_top"
        case subscriptionStatus = "subscription_status"
    }
}


