//
//  Constants.swift
//  FannanArtist
//
//  Created by mac on 13/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

public var Notification_Name : Int?
public var previous_Notification_Name : Int?// = ""

class Constants: NSObject
{
    //MARK:- Api Constantsc100
    //static let baseUrl = "http://68.183.84.245:3000/api/" //- Testing
    static let baseUrl = "http://54.156.242.195/public/api/standard/" //- Production
    static let PUBLISHABLE_KEY = "pk_test_uZFqDfMq7lgVM66gyUVBChRO00bZq6PMCW"
    static let STRIPE_SECRET_KEY = "sk_test_tXlTzGNzX5OVHYNhjptona3U00OA049tix"
    
    static let about_Url = "https://fannanadmin.com/web/about_us/"
    static let terms_Url = "https://fannanadmin.com/web/terms_condition/"
    static let privacy_Url = "https://fannanadmin.com/web/privacy_policy/"
    static let faq_Url = "https://fannanadmin.com/web/faq/"
    static let refund_Url = " https://fannanadmin.com/web/refund_policy/"
    static let code_Conduct = "https://fannanadmin.com/web/code_of_conduct/"
    
    
    
    static let login_Api = "login"
    static let signUp_Api = "register"
    static let forgetPass_Api = "forgotPassword"
    static var getContents = "getContents"
    static let setPassword = "setPassword"
    static let profile = "profile"
    static let getMembershipData = "getMembershipData"
    static let getNotificationSetting = "getNotificationSetting"
    static let updateNotificationSettings = "updateNotificationSettings"
    static let changePass_Api = "changePassword"
    static let getDashboardData1 = "getDashboardData1"
    static let getHelpTopics = "getHelpTopics"
    static let getHelpSubjects = "getHelpSubjects"
    static let submitHelpRequest = "submitHelpRequest"
    static let getFAQ = "getFAQ"
    static let getSupportSubjects = "getSupportSubjects"
    static let submitSupport = "submitSupport"
    static let myStuff = "myStuff"
    static let findNewRecipes = "findNewRecipes"
    static let recipeFilterData = "recipeFilterData"
    static let getWeeklyPlanTemplateDetails = "getWeeklyPlanTemplateDetails"
    static let getWeeklyPlanTemplateNutritionixDetails = "getWeeklyPlanTemplateNutritionixDetails"
    static let getRecipePackDetails = "getRecipePackDetails"
    static let updateProfile = "updateProfile"
    static let downloadWeeklyPlan = "downloadWeeklyPlan"
    static let updateOrCreateWeeklyPlanTemplate = "updateOrCreateWeeklyPlanTemplate"
    static let getShoppingList = "getShoppingList"
    static let alreadyHaveShopList = "alreadyHaveShopList"
    static let downloadShopList = "downloadShopList"
    static let searchIngredientForShop = "searchIngredientForShop"
    static let getFilterWiseShoppingList = "getFilterWiseShoppingList"
    static let deleteItemsFromalreadyHaveShopList = "deleteItemsFromalreadyHaveShopList"
    static let getNotifications = "getNotifications"
    static let getMySubscriptions = "getMySubscriptions"
    static let updateSubscription = "updateSubscription"
    static let acceptsUpdatedSubscriptionCost = "acceptsUpdatedSubscriptionCost"
    static let getTransactions = "getTransactions"
    static let getConsultation = "getConsultation"
    static let updateConsulatationStatus = "updateConsulatationStatus"
    static let updateConsulatation = "updateConsulatation"
    static let getCookList = "getCookList"
    static let getChef = "getChef"
    static let getChefProfile = "getChefProfile"
    static let myChef = "myChef"
    static let addConsultation = "addConsultation"
    static let clearWeeklyPlanRecipes = "clearWeeklyPlanRecipes"
    static let getSettings = "getSettings"
    static let updateSettings = "updateSettings"
    static let resetSettings = "resetSettings"
    static let updateFoodInterest = "updateFoodInterest"
    static let getDietTypes = "getDietTypes"
    static let filteredRecipesList = "filteredRecipesList"
    static let listOfRestaurantDepot = "listOfRestaurantDepot"
    static let getStateList = "getStateList"
    static let getCityList = "getCityList"
    static let faxOrderHistory = "faxOrderHistory"
    static let getDateWiseWeeklyPlanDetails = "getDateWiseWeeklyPlanDetails"
    static let getRecipeDetails = "getRecipeDetails"
    static let getRecipeComments = "getRecipeComments"
    static let appRatings = "appRatings"
    static let getAppData = "getAppData"
    static let recipeRating = "recipeRating"
    static let addRecipeToMyStuff = "addRecipeToMyStuff"
    static let getRecipeNutritionixDetails = "getRecipeNutritionixDetails"
    static let addToFav = "addToFavorite"
    static let getRecipeList = "getRecipeList"
    static let addWeekPlanStep2 = "addWeekPlanStep2"
    static let blogComment = "blogComment"  
    static let keepOrDiscardExistingRecipeFromPlan = "keepOrDiscardExistingRecipeFromPlan"
    static let getMainIngredients = "getMainIngredientList"
    static let getCourse = "getCourse"
    
    static let chefSubscribePaymentIntent = "chefSubscribePaymentIntent"
    
    static let marginConstant:CGFloat = UtilityManager.isIphone() ? 15:20
    static let labelHeightConstant:CGFloat = UtilityManager.isIphone() ? 35:45
    static let BUTTON_HEIGHT:CGFloat = UtilityManager.isIphone() ? 50:60
    static let textFieldHeightConstant:CGFloat = UtilityManager.isIphone() ? 35 : 40
   
    static let buttonSpacingConstant:CGFloat = UtilityManager.isIphone() ? 70 : 100
    static let ImageView_Height:CGFloat = UtilityManager.isIphone() ? 70 : 100
    
    static let cornerRadius:CGFloat = UtilityManager.isIphone() ? 5:10
    static let LEFT_VIEW_WIDTH:CGFloat = UtilityManager.isIphone() ? 25:30
    
    static let bottomHeightConstant:CGFloat = UtilityManager.isIphone() ? 50 : 65
    
    static let PCButtonWidth:CGFloat = UtilityManager.isIphone() ? 49:59
    static let spacing:CGFloat = UtilityManager.isIphone() ? 10:20
    
    
    static let GoogleClientID = "424347979370-667mhqkscqa5cq14r874srro0g5lms92.apps.googleusercontent.com"
    
    // APP CONSTANTS
    static let PHONE_NUMER_PREFIX_COUNT = 4
    static let MIN_PHONE_NUMER_COUNT    = 10
    static let MAX_ZIP_CODE_COUNT       = 6
    static let MAX_PIN_NUMBER           = 4
    static let MAX_CVV_NUMBER           = 3
    static let MAX_CARD_NUMBER          = 18
    static let MIN_CARD_NUMBER          = 16
    static let MIN_PASSWORD             = 8
    static let MAX_PASSWORD             = 15
    static let MAX_ANSWER_COUNT         = 100

}


struct APIPara {
    static let email        = "email"
    static let id           = "id"
    static let user_name    = "user_name"
    static let user_id      = "user_id"
    static let company_name = "company_name"
    static let image        = "image"
    static let device_token = "device_token"
    static let device_type  = "device_type"
    static let media_name   = "media_name"
    static let password     = "password"
    static let longitude    = "longitude"
    static let latitude     = "latitude"
    static let device_OS    = "os"
    static let device       = "device"
    static let QR_id        = "id"
    static let type_id      = "type_id"
}
