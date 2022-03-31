//
//  MyChef_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 25/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct MyChef_Struct : Codable {
    var status : Bool?
    var status_code : Int?
    var message : String?
    var blogList : [String]?
    var recipeList : [RecipeList]?
    var recipePackList : [String]?
    var recipePlanList : [RecipeList]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case blogList = "blogList"
        case recipeList = "recipeList"
        case recipePackList = "recipePackList"
        case recipePlanList = "recipePlanList"
    }


}
