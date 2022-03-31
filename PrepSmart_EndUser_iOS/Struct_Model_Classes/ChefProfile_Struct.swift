//
//  ChefProfile_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 26/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//


import Foundation
struct ChefProfile_Struct : Codable {
    let status : Bool?
    let status_code : Int?
    let message : String?
    let user_data : chef_Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case status_code = "status_code"
        case message = "message"
        case user_data = "user_data"
    }
}
struct chef_Data : Codable {
    let user_id : String?
    let email_id : String?
    let user_name : String?
    let user_pic : String?
    let contact_number : String?
    let bio : String?
    let consultation_duration : Int?
    let consultation_cost : Int?
    let consultation_currency : String?
    let comments_count : Int?
    let recipe_count : Int?
    let blog_count : Int?
    let subscribers_count : Int?
    let my_tags : [String]?
    let top_premium_recipe : [String]?
    let top_recipe : [String]?
    let top_recipe_pack : [String]?
    let top_blog : [String]?
    let affiliate_prod_urls : [Affiliate_prod_urls]?
    let top_tags : [Top_tags]?
    let site_url : String?
    let fb_url : String?
    let google_url : String?
    let pinterest_url : String?
    let twitter_url : String?
    let linkedin_url : String?
    let insta_url : String?
    let amazon_url : String?
    let total_ratings : Int?
    let avg_ratings : Int?
    let monthly_subscription_cost : String?
    let added_date : String?
    let chef_subscribe_status : Int?

    enum CodingKeys: String, CodingKey {

        case user_id = "user_id"
        case email_id = "email_id"
        case user_name = "user_name"
        case user_pic = "user_pic"
        case contact_number = "contact_number"
        case bio = "bio"
        case consultation_duration = "consultation_duration"
        case consultation_cost = "consultation_cost"
        case consultation_currency = "consultation_currency"
        case comments_count = "comments_count"
        case recipe_count = "recipe_count"
        case blog_count = "blog_count"
        case subscribers_count = "subscribers_count"
        case my_tags = "my_tags"
        case top_premium_recipe = "top_premium_recipe"
        case top_recipe = "top_recipe"
        case top_recipe_pack = "top_recipe_pack"
        case top_blog = "top_blog"
        case affiliate_prod_urls = "affiliate_prod_urls"
        case top_tags = "top_tags"
        case site_url = "site_url"
        case fb_url = "fb_url"
        case google_url = "google_url"
        case pinterest_url = "pinterest_url"
        case twitter_url = "twitter_url"
        case linkedin_url = "linkedin_url"
        case insta_url = "insta_url"
        case amazon_url = "amazon_url"
        case total_ratings = "total_ratings"
        case avg_ratings = "avg_ratings"
        case monthly_subscription_cost = "monthly_subscription_cost"
        case added_date = "added_date"
        case chef_subscribe_status = "chef_subscribe_status"
    }
}

struct Affiliate_prod_urls : Codable {
    let id : Int?
    let name : String?
    let product_url : String?
    let product_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case product_url = "product_url"
        case product_image = "product_image"
    }
}

struct Top_tags : Codable {
    let tag_name : String?
    let count : Int?

    enum CodingKeys: String, CodingKey {

        case tag_name = "tag_name"
        case count = "count"
    }
}
