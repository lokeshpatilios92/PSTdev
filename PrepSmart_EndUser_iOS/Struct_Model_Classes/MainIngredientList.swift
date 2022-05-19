//
//  MainIngredientList.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Shubham Gupta on 17/05/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import Foundation

struct MainIngredientList: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var mainIngredientList: [MainIngredient]?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case mainIngredientList = "main_ingredient_list"
    }
}

struct DietTypes: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var dietTypeList: [DietTypeList]?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case dietTypeList = "diettype_list"
    }
}

struct DietTypeList: Codable {
    var dietId: Int?
    var dietName: String?

    enum CodingKeys: String, CodingKey {
        case dietId = "diet_id"
        case dietName = "diet_name"
    }
}


struct Cources: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var courceList: [CourseList]?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case courceList = "courseList"
    }
}

struct CourseList: Codable {
    var id: Int?
    var name: String?
}
