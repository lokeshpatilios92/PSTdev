//
//  MyChef_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 25/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
/*struct MyChef_Struct : Codable {
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


}*/


// MARK: - MyChefStruct
struct MyChef_Struct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var blogList: [BlogList]?
    var recipeList, recipePackList, recipePlanList: [RecipeList]?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message, blogList, recipeList, recipePackList, recipePlanList
    }
}

// MARK: - BlogList
struct BlogList: Codable {
    var blogID, chefID: Int?
    var blogTitle: String?
    var categoryID: Int?
    var categoryName, tags, blogBody, addedDate: String?
    var imageURL, videoURL: [ImageURLElement]?
    var userData: UserDataStruct?
    var commentsCount, isTopblog: Int?

    enum CodingKeys: String, CodingKey {
        case blogID = "blog_id"
        case chefID = "chef_id"
        case blogTitle = "blog_title"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case tags
        case blogBody = "blog_body"
        case addedDate = "added_date"
        case imageURL = "image_url"
        case videoURL = "video_url"
        case userData = "user_data"
        case commentsCount = "comments_count"
        case isTopblog = "is_topblog"
    }
}

// MARK: - ImageURLElement
struct ImageURLElement: Codable {
    var id: Int?
    var url: String?
}

// MARK: - UserData
struct UserDataStruct: Codable {
    var userID: Int?
    var userName: String?
    var userPic: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userPic = "user_pic"
    }
}



