//
//  SupportSubject_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 15/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct SupportSubject_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let support_subject : [Support_subject]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case support_subject = "support_subject"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        support_subject = try values.decodeIfPresent([Support_subject].self, forKey: .support_subject)
    }

}
struct Support_subject : Codable {
    let subject_id : Int?
    let subject : String?

    enum CodingKeys: String, CodingKey {

        case subject_id = "subject_id"
        case subject = "subject"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subject_id = try values.decodeIfPresent(Int.self, forKey: .subject_id)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
    }

}
