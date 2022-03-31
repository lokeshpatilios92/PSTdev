//
//  FAQStruct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 15/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import Foundation
struct FAQStruct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let faq_list : [Faq_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case faq_list = "faq_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        faq_list = try values.decodeIfPresent([Faq_list].self, forKey: .faq_list)
    }

}

struct Faq_list : Codable {
    let faq_id : Int?
    let faq_question : String?
    let faq_answer : String?

    enum CodingKeys: String, CodingKey {

        case faq_id = "faq_id"
        case faq_question = "faq_question"
        case faq_answer = "faq_answer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        faq_id = try values.decodeIfPresent(Int.self, forKey: .faq_id)
        faq_question = try values.decodeIfPresent(String.self, forKey: .faq_question)
        faq_answer = try values.decodeIfPresent(String.self, forKey: .faq_answer)
    }

}
