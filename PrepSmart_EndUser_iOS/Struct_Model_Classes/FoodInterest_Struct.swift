//
//  FoodInterest_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 15/12/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct FoodInterest_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let food_interest : [Food_interest]?

  
        
    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case food_interest = "food_interest"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        food_interest = try values.decodeIfPresent([Food_interest].self, forKey: .food_interest)
    }

}
struct Food_interest : Codable {
    let diet_id : Int?
    let diet_name : String?
    let is_selected : Int?

    enum CodingKeys: String, CodingKey {

        case diet_id = "diet_id"
        case diet_name = "diet_name"
        case is_selected = "is_selected"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        diet_id = try values.decodeIfPresent(Int.self, forKey: .diet_id)
        diet_name = try values.decodeIfPresent(String.self, forKey: .diet_name)
        is_selected = try values.decodeIfPresent(Int.self, forKey: .is_selected)
    }

}
