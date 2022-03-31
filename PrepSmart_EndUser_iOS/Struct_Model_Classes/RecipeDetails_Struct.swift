



// MARK: - RecipeDetailsStruct
struct RecipeDetailsStruct: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var imageList: [ImageList]?
    var videoURL: String?
    var recipeInfo: RecipeInfo?

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message
        case imageList = "image_list"
        case videoURL = "video_url"
        case recipeInfo = "recipe_info"
    }
}

// MARK: - ImageList
struct ImageList: Codable {
    var id: Int?
    var imagePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imagePath = "image_path"
    }
}

// MARK: - RecipeInfo
struct RecipeInfo: Codable {
    var recipeID: Int?
    var recipeName: String?
    var chefID, serving, ratting, likeCount: Int?
    var recipeDescription, audience, audienceType, amountCurrency: String?
    var monthlyCost: Int?
    var mainIngredients: [MainIngredient]?
    var dietType: [DietType]?
    var course: [Course]?
    var recipeLink: String?
    var tags: String?
    var ingredientsList: [IngredientsList]?
    var instructionList: [InstructionList]?
    var nutritionalInformation: [NutritionalInformation]?
    var pairWithList: [PairWithList]?
    var reviewAndComment: ReviewAndComment?
    var commentedUserFilterType: [CommentedUserFilterType]?
    var commentedUserList: [String]?
    var recipeNotes, notesIf: String?
    var cookingTime: Int?
    var season: [Season]?
    var youtubeThumbnails: String?
    var recipeTags: [RecipeTag]?
    var subscriptionStatus, recipeRatingStatus, myStuffRecipeStatus, chefSubscriptionStatus: Int?

    enum CodingKeys: String, CodingKey {
        case recipeID = "recipe_id"
        case recipeName = "recipe_name"
        case chefID = "chef_id"
        case serving, ratting
        case likeCount = "like_count"
        case recipeDescription = "recipe_description"
        case audience
        case audienceType = "audience_type"
        case amountCurrency = "amount_currency"
        case monthlyCost = "monthly_cost"
        case mainIngredients = "main_ingredients"
        case dietType = "diet_type"
        case course
        case recipeLink = "recipe_link"
        case tags
        case ingredientsList = "ingredients_list"
        case instructionList = "instruction_list"
        case nutritionalInformation = "nutritional_information"
        case pairWithList = "pair_with_list"
        case reviewAndComment = "review_and_comment"
        case commentedUserFilterType = "commented_user_filter_type"
        case commentedUserList = "commented_user_list"
        case recipeNotes = "recipe_notes"
        case notesIf = "notes_if"
        case cookingTime = "cooking_time"
        case season
        case youtubeThumbnails = "youtube_thumbnails"
        case recipeTags = "recipe_tags"
        case subscriptionStatus = "subscription_status"
        case recipeRatingStatus = "recipe_rating_status"
        case myStuffRecipeStatus = "my_stuff_recipe_status"
        case chefSubscriptionStatus = "chef_subscription_status"
    }
}

// MARK: - CommentedUserFilterType
struct CommentedUserFilterType: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Course
struct Course: Codable {
    var courseTypeID: Int?
    var courseTypeName: String?

    enum CodingKeys: String, CodingKey {
        case courseTypeID = "course_type_id"
        case courseTypeName = "course_type_name"
    }
}

// MARK: - DietType
struct DietType: Codable {
    var dietTypeID: Int?
    var dietTypeName: String?

    enum CodingKeys: String, CodingKey {
        case dietTypeID = "diet_type_id"
        case dietTypeName = "diet_type_name"
    }
}

// MARK: - IngredientsList
struct IngredientsList: Codable {
    var ingredientID, catID: Int?
    var quantity, unit, mQuantity, mUnit: String?
    var ingredientName: String?
    var assignedStep, isBrandedIngredient: Int?
    var nixItemID: String?

    enum CodingKeys: String, CodingKey {
        case ingredientID = "ingredient_id"
        case catID = "cat_id"
        case quantity, unit
        case mQuantity = "m_quantity"
        case mUnit = "m_unit"
        case ingredientName = "ingredient_name"
        case assignedStep = "assigned_step"
        case isBrandedIngredient = "is_branded_ingredient"
        case nixItemID = "nix_item_id"
    }
}

// MARK: - InstructionList
struct InstructionList: Codable {
    var instructionID, step: Int?
    var stepInstruction: String?
    var ingredientsList: [IngredientsListData]?

    enum CodingKeys: String, CodingKey {
        case instructionID = "instruction_id"
        case step
        case stepInstruction = "step_instruction"
        case ingredientsList = "ingredients_list"
    }
}

// MARK: - IngredientsList
struct IngredientsListData: Codable {
    var quantity, unit, mQuantity, mUnit: String?
    var ingredientName: String?

    enum CodingKeys: String, CodingKey {
        case quantity, unit
        case mQuantity = "m_quantity"
        case mUnit = "m_unit"
        case ingredientName = "ingredient_name"
    }
}

// MARK: - MainIngredient
struct MainIngredient: Codable {
    var mainIngredientID: Int?
    var mainIngredientName: String?

    enum CodingKeys: String, CodingKey {
        case mainIngredientID = "main_ingredient_id"
        case mainIngredientName = "main_ingredient_name"
    }
}

// MARK: - NutritionalInformation
struct NutritionalInformation: Codable {
    var totalFatPercentage, totalProteinPercentage, totalCarbPercentage, calorificValue: Int?
    var totalFat, totalProtein, totalCarb: Int?

    enum CodingKeys: String, CodingKey {
        case totalFatPercentage = "total_fat_percentage"
        case totalProteinPercentage = "total_protein_percentage"
        case totalCarbPercentage = "total_carb_percentage"
        case calorificValue = "calorific_value"
        case totalFat = "total_fat"
        case totalProtein = "total_protein"
        case totalCarb = "total_carb"
    }
}

// MARK: - RecipeTag
struct RecipeTag: Codable {
    var name: String?
}

// MARK: - ReviewAndComment
struct ReviewAndComment: Codable {
    var totalRating, avgRating, fiveStarPercentage, fourStarPercentage: Int?
    var threeStarPercentage, twoStarPercentage, oneStarPercentage: Int?

    enum CodingKeys: String, CodingKey {
        case totalRating = "total_rating"
        case avgRating = "avg_rating"
        case fiveStarPercentage = "five_star_percentage"
        case fourStarPercentage = "four_star_percentage"
        case threeStarPercentage = "three_star_percentage"
        case twoStarPercentage = "two_star_percentage"
        case oneStarPercentage = "one_star_percentage"
    }
}

// MARK: - Season
struct Season: Codable {
    var seasonID: Int?
    var seasonName: String?

    enum CodingKeys: String, CodingKey {
        case seasonID = "season_id"
        case seasonName = "season_name"
    }
}

// MARK: - PairWithList
struct PairWithList: Codable {
    var id: Int?
    var recipeName, image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case recipeName = "recipe_name"
        case image
    }
}
