//
//  Chef_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 25/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct GetChef_Struct : Codable {
    var status : Bool?
    var status_code : Int?
    var message : String?
    var chef_list : [Chef_list]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case chef_list = "chef_list"
    }
}

struct Chef_list : Codable {
    var chef_id : Int?
    var name : String?
    var chef_pic : String?
    var avg_ratings : Int?
    var total_ratings : Int?
    var total_recipes : Int?
    var total_blog : Int?
    var total_subscribers : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case chef_id = "chef_id"
        case name = "name"
        case chef_pic = "chef_pic"
        case avg_ratings = "avg_ratings"
        case total_ratings = "total_ratings"
        case total_recipes = "total_recipes"
        case total_blog = "total_blog"
        case total_subscribers = "total_subscribers"
    }
}
