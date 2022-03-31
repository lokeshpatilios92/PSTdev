//
//  Profile_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 22/01/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

struct Profile_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let userData : UserData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case userData = "user_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(UserData.self, forKey: .userData)
    }

}

