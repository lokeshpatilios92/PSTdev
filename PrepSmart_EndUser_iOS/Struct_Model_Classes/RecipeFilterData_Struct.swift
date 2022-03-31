//
//  RecipeFilterData_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 18/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct RecipeFilterData_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
   var category_list : [Category_list]?
   var diet_type : [Diet_type]?
   var courses : [Courses]?
   var tag_list : [Tag_list]?
   var recipe_type : [Recipe_type]?
   var seasons : [Seasons]?
   var main_ingredient : [Main_ingredient]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case category_list = "category_list"
        case diet_type = "diet_type"
        case courses = "courses"
        case tag_list = "tag_list"
        case recipe_type = "recipe_type"
        case seasons = "seasons"
        case main_ingredient = "main_ingredient"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        category_list = try values.decodeIfPresent([Category_list].self, forKey: .category_list)
        diet_type = try values.decodeIfPresent([Diet_type].self, forKey: .diet_type)
        courses = try values.decodeIfPresent([Courses].self, forKey: .courses)
        tag_list = try values.decodeIfPresent([Tag_list].self, forKey: .tag_list)
        recipe_type = try values.decodeIfPresent([Recipe_type].self, forKey: .recipe_type)
        seasons = try values.decodeIfPresent([Seasons].self, forKey: .seasons)
        main_ingredient = try values.decodeIfPresent([Main_ingredient].self, forKey: .main_ingredient)
    }

}
struct Main_ingredient : Codable {
    let id : Int?
    let name : String?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
struct Recipe_type : Codable {
    let type_id : Int?
    let type : String?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {

        case type_id = "type_id"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type_id = try values.decodeIfPresent(Int.self, forKey: .type_id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
struct Seasons : Codable {
    let id : Int?
    let name : String?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
struct Tag_list : Codable {
    let tag_id : Int?
    let tag : String?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {

        case tag_id = "tag_id"
        case tag = "tag"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag_id = try values.decodeIfPresent(Int.self, forKey: .tag_id)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
    }

}
struct Category_list : Codable {
    let cat_id : Int?
    let cat_name : String?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {

        case cat_id = "cat_id"
        case cat_name = "cat_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cat_id = try values.decodeIfPresent(Int.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
    }

}
struct Courses : Codable {
    let course_type_id : Int?
    let course_type_name : String?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {

        case course_type_id = "course_type_id"
        case course_type_name = "course_type_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        course_type_id = try values.decodeIfPresent(Int.self, forKey: .course_type_id)
        course_type_name = try values.decodeIfPresent(String.self, forKey: .course_type_name)
    }

}
struct Diet_type : Codable {
    let diet_type_id : Int?
    let diet_type_name : String?
    var isSelected: Bool?

    enum CodingKeys: String, CodingKey {

        case diet_type_id = "diet_type_id"
        case diet_type_name = "diet_type_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        diet_type_id = try values.decodeIfPresent(Int.self, forKey: .diet_type_id)
        diet_type_name = try values.decodeIfPresent(String.self, forKey: .diet_type_name)
    }

}
