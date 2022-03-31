////
////  ds.swift
////  DipeshNewProject
////
////  Created by mac on 30/07/19.
////  Copyright © 2019 mac. All rights reserved.
////
//

import SVProgressHUD
import Toaster

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum HttpMethod : String{
    case  GET
    case  POST
    case  DELETE
    case  PUT
}



enum requestResult {
    case success(Data , Any? )
    
    case failer(Error)
}

import Foundation
import Alamofire

class Api_Http_Class
{
    class var shareinstance : Api_Http_Class {
        
        struct singletone {
            static var instance = Api_Http_Class()
        }
        return singletone.instance
    }
    
    var request : URLRequest?
    var global_var = GlobalClass.sharedManager
    var session : URLSession?
    let lang = UserDefaults.standard.getLangCode()
    var headers:HTTPHeaders?
    
    public static var Manager : Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "http://142.93.219.251:4000/api/": .disableEvaluation]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
        return man
    }()
    
    // let loadView : LoadingView = LoadingView()
    
    func AlemfFireAPICall(methodName : String,params:  Dictionary<String, Any>? , method: HTTPMethod, completion:@escaping (requestResult) -> Void) {
        
        
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        
        
        if onjRechability.isReachable {
            
            var strUrl = String(format: "%@%@", Constants.baseUrl, methodName)
            
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 25
            
            //let login_token = GlobalClass.sharedManager.logindicObj.token
            let login_token = ""
            
            if methodName == Constants.login_Api || methodName == Constants.signUp_Api || methodName == Constants.forgetPass_Api || methodName == Constants.changePass_Api
            {
                self.headers = ["lang":lang,"Content-Type":"Application/Json"]
            }
            else
            {
                self.headers = ["lang":lang,"token":login_token ?? "","Content-Type":"Application/Json"]
            }
            
            switch method  {
                
            case .options:
                break;
                
            case .get:
                Alamofire.request(strUrl, method:  .get ,parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseData) in
                    
                    if((responseData.result.value) != nil) {
                        completion( .success(responseData.data!, responseData.result.value ) )
                        
                    }
                    else
                    {
                        completion( .failer(responseData.error!))
                        
                    }
                }
                break;
                
            case .post:
                
                Alamofire.request(strUrl, method:  .post ,parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseData) in
                    //print(self.paramsLanguage())
                    print(responseData.result)
                    print(responseData)
                    self.statusMessageMethod(data: responseData.data)
                    
                    if let dict = responseData.result.value as? NSDictionary
                    {
                        if let status = dict["status"] as? String, status == "5"
                        {
                            if let bundleID = Bundle.main.bundleIdentifier {
                                
                            }
                            
                            //                            UserDefaults.standard.removeObject(forKey: "PrepSmart")
                            //                            Toast.init(text: dict["message"] as? String).show()
                            //
                            //                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            //
                            //                            let splashVc:SplashVc = storyboard.instantiateViewController(withIdentifier: "SplashVc") as! SplashVc
                            //
                            //                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            //                            let navigationController = UINavigationController.init(rootViewController: splashVc)
                            //                            appDelegate.window?.rootViewController = navigationController
                            //                            appDelegate.window?.makeKeyAndVisible()
                        }
                        else
                        {
                            if((responseData.result.value) != nil) {
                                completion( .success(responseData.data!, responseData.result.value ) )
                            }
                            else
                            {
                                completion( .failer(responseData.error!))
                            }
                        }
                    }
                }
                
                SVProgressHUD.dismiss()
                break;
            case .head:
                break;
            case .put:
                break;
            case .patch:
                break;
            case .delete:
                break;
            case .trace:
                break;
            case .connect:
                break;
            }
            
        }
        else
        {
            Alert.show_no_internet(titleStr: "Message", messageStr: Alert.Network_Error_msg)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                SVProgressHUD.dismiss()
                Loader.sharedInstance.hideIndicator()
            }
            
            print(Alert.Network_Error_msg)
        }
    }
    
    
    func statusMessageMethod(data : Data?){
        
        if let statusData = data {
            do {
                GlobalClass.sharedManager.get_status = try  JSONDecoder().decode(Get_Status.self, from: statusData)
            } catch
            {
                print(error)
            }
        }
    }
    
    func AlemfFireMultiFromAPICall(methodName : String,params:  Dictionary<String, Any>? , method: HTTPMethod, img_pram: [String?]?, imageUpload_Arr : [UIImage?]? , media_pram: String?, video_url_Up_Arr: [URL?]?, success:@escaping ( Data?   , NSError? ) -> Void) {
        
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        //let lang = UserDefaults.standard.getlang()
        
        
        if onjRechability.isReachable {
            
            let strUrl = String(format: "%@%@", Constants.baseUrl, methodName)
            // let login_token = GlobalClass.sharedManager.logindicObj.token
            var login_token = ""
            if global_var.logindicObj?.userData?.access_token != nil
            {
                login_token = global_var.logindicObj?.userData?.access_token ?? ""
            }
            else
            {
                login_token = global_var.token
            }
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 50
            
            
            
            if methodName == Constants.login_Api || methodName == Constants.signUp_Api || methodName == Constants.forgetPass_Api || methodName == Constants.changePass_Api
            {
                self.headers = ["lang":lang,"Authorization":login_token ,"Content-Type":"application/x-www-form-urlencoded"]
            }
            else
            {
                self.headers = ["lang":lang,"Authorization":login_token ,"Content-Type":"application/x-www-form-urlencoded"]
            }
            
            switch method  {
                
            case .options:
                break;
                
            case .get:
                
                break;
                
            case .post:
                if onjRechability.isReachable {
                    
                    upload(multipartFormData: { (MultipartFormData) in
                        
                        //------------------------------------------------------//
                        // This condition send multipale image or single image  //
                        if let  img_pra  = img_pram
                        {
                            
                            for (ind,image) in (imageUpload_Arr?.enumerated())!
                            {
                                if let data = image!.jpegData(compressionQuality: 0.5) as NSData?
                                {
                                    if let imgpram = img_pra[ind]
                                    {
                                        MultipartFormData.append(data as Data, withName: imgpram , fileName: "file.png", mimeType: "image/jpeg")
                                    }
                                }
                            }
                        }
                        //------------------------------------------------------//
                        // This condition send multipale Video or single Video  //
                        if let  media_pra  = media_pram
                        {
                            
                            for (_,video_url) in (video_url_Up_Arr?.enumerated())!
                            {
                                
                                guard let video_Data = NSData(contentsOf: video_url! ) else {
                                    return
                                }
                                
                                MultipartFormData.append(video_Data  as Data, withName: media_pra, fileName:  "video.mp4", mimeType: "mov")
                                
                            }
                        }
                        //------------------------------------------------------//
                        if let params = params {
                            for (key, value) in params {
                                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key);
                            }
                        }
                        
                    }, to:strUrl,headers: self.headers,
                           encodingCompletion: { (result) in
                        
                        switch result {
                        case .success(let upload, _, _):
                            
                            
                            upload.uploadProgress(closure: { (Progress) in
                                if imageUpload_Arr != [] {
                                    SVProgressHUD.showProgress(Float(Progress.fractionCompleted), status: "Please wait")
                                }
                                print("Upload Progress: \(Progress.fractionCompleted)")
                            })
                            
                            upload.responseJSON { response in
                                
                                SVProgressHUD.dismiss()
                                if let dict = response.result.value as? NSDictionary
                                {
                                    if let status = dict["status"] as? String, status == "5"
                                    {
                                        if let bundleID = Bundle.main.bundleIdentifier {
                                            
                                        }
                                        
                                        //                                        UserDefaults.standard.removeObject(forKey: "PrepSmart")
                                        //                                        Toast.init(text: dict["message"] as? String).show()
                                        //
                                        //                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        //
                                        //                                        let splashVc:SplashVc = storyboard.instantiateViewController(withIdentifier: "SplashVc") as! SplashVc
                                        //
                                        //                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        //                                        let navigationController = UINavigationController.init(rootViewController: splashVc)
                                        //                                        appDelegate.window?.rootViewController = navigationController
                                        //                                        appDelegate.window?.makeKeyAndVisible()
                                    }
                                    else
                                    {
                                        if((response.data) != nil) {
                                            success(response.data  , response.error as NSError? )
                                        }  else  {
                                            success(response.data  , response.error as NSError?  )
                                        }
                                    }
                                }
                            }
                            break;
                        case .failure:
                            break;
                        }
                    })
                }
                SVProgressHUD.dismiss()
                break;
            case .head:
                break;
            case .put:
                break;
            case .patch:
                break;
            case .delete:
                break;
            case .trace:
                break;
            case .connect:
                break;
            }
        }
        else
        {
            Alert.show_no_internet(titleStr: "Message", messageStr: Alert.Network_Error_msg)
            SVProgressHUD.dismiss()
        }
    }
    
    
    func AlemfFireRowAPICall(methodName : String,params:  Dictionary<String, Any>? , method: HTTPMethod, completion:@escaping (requestResult) -> Void) {
        
        
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        let lang = UserDefaults.standard.getLangCode()
        
        if onjRechability.isReachable {
            
            var strUrl = String(format: "%@%@", Constants.baseUrl, methodName)
            //let login_token = GlobalClass.sharedManager.logindicObj.token
            var login_token = ""
            if global_var.logindicObj?.userData?.access_token != nil
            {
                login_token = global_var.logindicObj?.userData?.access_token ?? ""
            }
            else
            {
                login_token = global_var.token
            }
            
            
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 25
            
            
            if methodName == Constants.login_Api || methodName == Constants.signUp_Api || methodName == Constants.forgetPass_Api || methodName == Constants.changePass_Api
            {
                self.headers = ["lang":lang,"Authorization":login_token,"Content-Type":"application/x-www-form-urlencoded"]
            }
            else
            {
                self.headers = ["lang":lang,"Authorization":login_token ,"Content-Type":"application/x-www-form-urlencoded"]
            }
            
            switch method  {
                
            case .options:
                break;
                
            case .get:
                
                Alamofire.request(strUrl, method:  .get , parameters: params, encoding: URLEncoding.default, headers: self.headers).responseJSON { (responseData) in
                    
                    print(responseData.result)
                    print(responseData)
                    self.statusMessageMethod(data: responseData.data)
                    
                    if((responseData.result.value) != nil) {
                        completion( .success(responseData.data!, responseData.result.value ) )
                        
                    }
                    else
                    {
                        completion( .failer(responseData.error!))
                        
                    }
                }
                SVProgressHUD.dismiss()
                break;
            case .post:
                Alamofire.request(strUrl, method:  .post , parameters: params, encoding: URLEncoding.default , headers: self.headers).responseJSON { (responseData) in
                    //print(self.paramsLanguage())
                    print(responseData.result)
                    print(responseData)
                    self.statusMessageMethod(data: responseData.data)
                    
                    if let dict = responseData.result.value as? NSDictionary
                    {
                        if let status = dict["status"] as? NSNumber, status == 5
                        {
                            if let bundleID = Bundle.main.bundleIdentifier {
                                
                            }
                            
                            //                                    UserDefaults.standard.removeObject(forKey: "PrepSmart")
                            //                                    Toast.init(text: dict["message"] as? String).show()
                            //
                            //                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            //
                            //                                    let splashVc:SplashVc = storyboard.instantiateViewController(withIdentifier: "SplashVc") as! SplashVc
                            //
                            //                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            //                                    let navigationController = UINavigationController.init(rootViewController: splashVc)
                            //                                    appDelegate.window?.rootViewController = navigationController
                            //                                    appDelegate.window?.makeKeyAndVisible()
                        }
                        else
                        {
                            if((responseData.result.value) != nil) {
                                completion( .success(responseData.data!, dict))
                            }
                            else
                            {
                                completion( .failer(responseData.error!))
                            }
                        }
                    }
                }
                SVProgressHUD.dismiss()
                break;
            case .head:
                break;
            case .put:
                break;
            case .patch:
                break;
            case .delete:
                break;
            case .trace:
                break;
            case .connect:
                break;
            }
            
        }
        else
        {
            
            Toast.init(text:Alert.Network_Error_msg).show()
            SVProgressHUD.dismiss()
        }
    }
    
    //MARK: Save User Data
    
    func save_Data_NsUser_Default(  vc : UIViewController , dic_Data : NSDictionary )
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic_Data)
        
        UserDefaults.standard.setValue(data, forKey: "PrepSmart")
    }
    
    //MARK: - Get User Default Data
    func get_Data_NsUser_Default(vc : UIViewController  , completion: @escaping (Bool) -> ()){
        
        if  let outData = UserDefaults.standard.data(forKey: "PrepSmart")
        {
            
            do {
                if  let dic = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(outData)
                {
                    let dic_Code : NSDictionary = dic as! NSDictionary
                    
                    do
                    {
                        let dic = try JSONDecoder().decode(UserLogin_Struct.self, from: dic_Code.dict2json())
                        
                        GlobalClass.sharedManager.logindicObj = dic
                        
                        //Alert.showMiddleToast(message:   GlobalClass.sharedManager.get_status.message, view_VC: vc)
                        
                        completion(true)
                    }
                    catch
                    {
                        /*
                         let alert = UIAlertController(title: Alert().message, message: Alert().try_again, preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: StringConstants().ok, style: .default, handler: { (action) in
                         completion(false)
                         
                         }))
                         
                         vc.present(alert, animated: true, completion: nil)*/
                        Alert.show(vc: app_delegate.navi_obj ?? UIViewController(), titleStr: Alert.msg, messageStr: error.localizedDescription)
                        print(error.localizedDescription)
                    }
                    
                }
                else
                {
                    completion(false)
                }
            } catch {
                //handle error
                print(error)
            }
        }
        else
        {
            completion(false)
        }
        
    }
}



extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension NSDictionary {
    var json: Data {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let str_val =  String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
            
            if str_val == "Not a valid JSON"
            {
                return invalidJson.data(using: .utf8)!
            }
            else
            {
                return jsonData
            }
            
            
        }
        catch
        {
            return  invalidJson.data(using: .utf8)!
        }
    }
    
    func dict2json() -> Data {
        return json
    }
    
    
}



