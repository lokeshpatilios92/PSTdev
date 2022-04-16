//
//  MyStuff_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 16/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct MyStuff_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let recipeBoxViewTypeList : [RecipeBoxViewTypeList]?
    let recipeList : [RecipeList]?
    let chefsList : [String]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case recipeBoxViewTypeList = "recipeBoxViewTypeList"
        case recipeList = "recipeList"
        case chefsList = "chefsList"
    }
}
struct RecipeBoxViewTypeList : Codable {
    let type_id : Int?
    let type_name : String?

    enum CodingKeys: String, CodingKey {

        case type_id = "type_id"
        case type_name = "type_name"
    }


}
struct RecipeList : Codable {
    let item_id : Int?
    let item_title : String?
    let item_image : String?
    let item_label : String?
    let is_tag_image_present : Int?
    let extra_image_list : [String]?
    let ratting :  Ratting?
    let like_count : Int?
    let prepsmart_flag : Int?
    let season : String?
    let recipe_type : Int?
    let chef_id : Int?
    let added_date : String?
    let fav_status : Int?
    let season_flag : Int?
    let trending : Int?
    let premium : Int?
    let bestSelling : Int?
    let is_top : Int?

    enum CodingKeys: String, CodingKey {

        case item_id = "item_id"
        case item_title = "item_title"
        case item_image = "item_image"
        case item_label = "item_label"
        case is_tag_image_present = "is_tag_image_present"
        case extra_image_list = "extra_image_list"
        case ratting = "ratting"
        case like_count = "like_count"
        case prepsmart_flag = "prepsmart_flag"
        case season = "season"
        case recipe_type = "recipe_type"
        case chef_id = "chef_id"
        case added_date = "added_date"
        case fav_status = "fav_status"
        case season_flag = "season_flag"
        case trending = "trending"
        case premium = "premium"
        case bestSelling = "bestSelling"
        case is_top = "is_top"
    }
}

enum Ratting: Codable {
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
        throw DecodingError.typeMismatch(Ratting.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Ratting"))
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


struct Recipes : Codable {
    let item_id : Int?
    let recipe_id : Int?
    let recipe_name : String?
    let recipe_image : String?
//    let calories : Int?
    let protein : Int?
    let carbohydrates :  Int?
    let recipe_type : Int?
    var totalQuantity : Int? = 0
}
