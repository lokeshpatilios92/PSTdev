//
//  ChefProfile_Struct.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 26/11/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

/*
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
    let avg_ratings : Ratting?
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
*/
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
    let my_tags : [My_tags]?
    let top_premium_recipe : [JSONAny]?
    let top_recipe : [JSONAny]?
    let top_recipe_pack : [Top_recipe_pack]?
    let top_blog : [BlogList]?
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
    let avg_ratings : Ratting?
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

struct My_tags : Codable {
    let tag_id : Int?
    let tag_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case tag_id = "tag_id"
        case tag_name = "tag_name"
    }
}
    struct Top_recipe_pack : Codable {
        let item_id : Int?
        let item_title : String?
        let item_image : String?
        let item_label : String?
        let is_tag_image_present : Int?
        let extra_image_list : [String]?
        let ratting : Int?
        let like_count : Int?
        let prepsmart_flag : Int?
        let season : String?
        let created_at : String?
        let season_flag : Int?
        let trending : Int?
        let premium : Int?
        let bestSelling : Int?
        let is_top : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case item_id = "item_id"
            case item_title = "item_title"
            case item_image = "item_image"
            case item_label = "item_label"
            case is_tag_image_present = "is_tag_image_present"
            case extra_image_list = "extra_image_list"
            case ratting = "ratting"
            case like_count = "like_count"
            case prepsmart_flag = "prepsmart_flag"
            case season = "season"
            case created_at = "created_at"
            case season_flag = "season_flag"
            case trending = "trending"
            case premium = "premium"
            case bestSelling = "bestSelling"
            case is_top = "is_top"
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

// MARK: - Encode/decode helpers



class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


// MARK: - ChefProfileStruct
/*struct ChefProfile_Struct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var userData: UserData?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case userData = "user_data"
    }
}

// MARK: - UserData
struct chef_Data: Codable {
    var userID, emailID, userName: String?
    var userPic: String?
    var contactNumber, bio: String?
    var consultationDuration, consultationCost: Int?
    var consultationCurrency: String?
    var commentsCount, recipeCount, blogCount, subscribersCount: Int?
    var myTags: [MyTag]?
    var topPremiumRecipe, topRecipe: [String]?
    var topRecipePack: [TopRecipePack]?
    var topBlog: [String]?
    var affiliateProdUrls: [AffiliateProdURL]?
    var topTags: [TopTag]?
    var siteURL, fbURL, googleURL, pinterestURL: String?
    var twitterURL, linkedinURL, instaURL, amazonURL: String?
    var totalRatings: Int?
    var avgRatings, monthlySubscriptionCost, addedDate: String?
    var chefSubscribeStatus: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case emailID = "email_id"
        case userName = "user_name"
        case userPic = "user_pic"
        case contactNumber = "contact_number"
        case bio
        case consultationDuration = "consultation_duration"
        case consultationCost = "consultation_cost"
        case consultationCurrency = "consultation_currency"
        case commentsCount = "comments_count"
        case recipeCount = "recipe_count"
        case blogCount = "blog_count"
        case subscribersCount = "subscribers_count"
        case myTags = "my_tags"
        case topPremiumRecipe = "top_premium_recipe"
        case topRecipe = "top_recipe"
        case topRecipePack = "top_recipe_pack"
        case topBlog = "top_blog"
        case affiliateProdUrls = "affiliate_prod_urls"
        case topTags = "top_tags"
        case siteURL = "site_url"
        case fbURL = "fb_url"
        case googleURL = "google_url"
        case pinterestURL = "pinterest_url"
        case twitterURL = "twitter_url"
        case linkedinURL = "linkedin_url"
        case instaURL = "insta_url"
        case amazonURL = "amazon_url"
        case totalRatings = "total_ratings"
        case avgRatings = "avg_ratings"
        case monthlySubscriptionCost = "monthly_subscription_cost"
        case addedDate = "added_date"
        case chefSubscribeStatus = "chef_subscribe_status"
    }
}

// MARK: - AffiliateProdURL
struct AffiliateProdURL: Codable {
    var id: Int?
    var name: String?
    var productURL: String?
    var productImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case productURL = "product_url"
        case productImage = "product_image"
    }
}

// MARK: - MyTag
struct MyTag: Codable {
    var tagID: Int?
    var tagName: String?

    enum CodingKeys: String, CodingKey {
        case tagID = "tag_id"
        case tagName = "tag_name"
    }
}

// MARK: - TopRecipePack
struct TopRecipePack: Codable {
    var itemID: Int?
    var itemTitle: String?
    var itemImage: String?
    var itemLabel: String?
    var isTagImagePresent: Int?
    var extraImageList: [String]?
    var ratting, likeCount, prepsmartFlag: Int?
    var season, createdAt: String?
    var seasonFlag, trending, premium, bestSelling: Int?
    var isTop: Int?

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case itemTitle = "item_title"
        case itemImage = "item_image"
        case itemLabel = "item_label"
        case isTagImagePresent = "is_tag_image_present"
        case extraImageList = "extra_image_list"
        case ratting
        case likeCount = "like_count"
        case prepsmartFlag = "prepsmart_flag"
        case season
        case createdAt = "created_at"
        case seasonFlag = "season_flag"
        case trending, premium, bestSelling
        case isTop = "is_top"
    }
}

// MARK: - TopTag
struct TopTag: Codable {
    var tagName: String?
    var count: Int?

    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
        case count
    }
}
*/
