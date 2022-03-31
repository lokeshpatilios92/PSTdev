//
//  File.swift
//  PrepSmart_EndUser_iOS
//
//  Created by m@k on 06/03/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//
import Foundation

// MARK: - RecipeCommentStruct
struct RecipeCommentStruct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var commentedUserList: [CommentedUserList]?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case commentedUserList = "commented_user_list"
    }
}

// MARK: - CommentedUserList
struct CommentedUserList: Codable {
    var userID: Int?
    var profilePic: String?
    var userName: String?
    var rating: Int?
    var userComment, dateAndTime: String?
    var helpfulCount, notHelpfulCount, reportCount: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case profilePic = "profile_pic"
        case userName = "user_name"
        case rating
        case userComment = "user_comment"
        case dateAndTime = "date_and_time"
        case helpfulCount = "helpful_count"
        case notHelpfulCount = "not_helpful_count"
        case reportCount = "report_count"
    }
}
