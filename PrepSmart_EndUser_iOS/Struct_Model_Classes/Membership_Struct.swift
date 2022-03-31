//
//  Membership_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 11/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation

struct Membership_Struct : Codable {
    var status : Bool?
    var status_code : Int?
    var message : String?
    var membership_list : Membership_list?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case membership_list = "membership_list"
    }
}

struct Membership_list : Codable {
    var basic_plan : Basic_plan?
    var pro : Pro?
    var pro_plus : Pro_plus?
    var basic_plan_new : Basic_plan_new?
    
    enum CodingKeys: String, CodingKey {
        case basic_plan = "basic_plan"
        case pro = "pro"
        case pro_plus = "pro_plus"
        case basic_plan_new = "basic_plan_(new)"
    }
}

struct Basic_plan : Codable {
    var monthly : Monthly?
    var annually : Annually?
    
    enum CodingKeys: String, CodingKey {
        case monthly = "monthly"
        case annually = "annually"
    }
}

struct Pro : Codable {
    var monthly : Monthly?
    var annually : Annually?
    
    enum CodingKeys: String, CodingKey {
        case monthly = "monthly"
        case annually = "annually"
    }
}

struct Pro_plus : Codable {
    var monthly : Monthly?
    var annually : Annually?
    enum CodingKeys: String, CodingKey {
        case monthly = "monthly"
        case annually = "annually"
    }
}

struct Basic_plan_new : Codable {
    var monthly : Monthly?
    var annually : Annually?
    
    enum CodingKeys: String, CodingKey {
        case monthly = "monthly"
        case annually = "annually"
    }
}

struct Monthly : Codable {
    var id : Int?
    var name : String?
    var price : Int?
    var duration : Int?
    var description : String?
    var features : [Features]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case duration = "duration"
        case description = "description"
        case features = "features"
    }
}

struct Annually : Codable {
    var id : Int?
    var name : String?
    var price : Int?
    var duration : Int?
    var description : String?
    var features : [Features]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case duration = "duration"
        case description = "description"
        case features = "features"
    }
}

struct Features : Codable {
    var id : Int?
    var name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
