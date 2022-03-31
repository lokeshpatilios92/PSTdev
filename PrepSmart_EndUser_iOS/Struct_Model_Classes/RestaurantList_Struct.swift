//
//  RestaurantList_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 21/12/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct RestaurantList_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let restaurant_depo_list : [Restaurant_depo_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case restaurant_depo_list = "restaurant_depo_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        restaurant_depo_list = try values.decodeIfPresent([Restaurant_depo_list].self, forKey: .restaurant_depo_list)
    }

}
struct Restaurant_depo_list : Codable {
    let id : Int?
    let depo_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case depo_name = "depo_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        depo_name = try values.decodeIfPresent(String.self, forKey: .depo_name)
    }

}

struct StateList_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let state_list : [State_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case state_list = "state_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        state_list = try values.decodeIfPresent([State_list].self, forKey: .state_list)
    }

}

struct State_list : Codable {
    let id : Int?
    let name : String?

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

struct CityList_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let city_list : [City_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case city_list = "city_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        city_list = try values.decodeIfPresent([City_list].self, forKey: .city_list)
    }

}

struct City_list : Codable {
    let id : Int?
    let name : String?

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
