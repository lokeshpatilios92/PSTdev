////
////  ServerRequestManager.swift
////  RYDEHOP
////
////  Created by SBC on 14/12/18.
////  Copyright © 2018 oms. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class ServerRequestManager: NSObject {
//
//    let baseUrl = "https://home.sotstag.com/" //"https://sotstag.net/"
//    let uuidString = UIDevice.current.identifierForVendor!.uuidString
//
//    func saveLocationCoordinates(url:String,completion:@escaping (_ response:Dictionary<String,AnyObject>,_ error:NSError?) -> Void) {
//        print("\(#function)_#NS")
//        let uRL = URL(string: String(format: url))!
//        let headers : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//        
//        Alamofire.request(uRL, method:HTTPMethod.post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
//
//            let json = response.result.value as? [String: Any]
//
//            if json == nil{
//                completion(json! as Dictionary<String, AnyObject>,NSError(domain: "error", code: 100, userInfo: nil))
//            }
//            else{
//                completion(json! as Dictionary<String, AnyObject>,response.result.error as NSError?)
//            }
//        })
//    }
//    
//    func postDataFromServer(url:String,dictionary:NSDictionary, view:UIViewController, onComplition:@escaping (JSON?,NSError?)->Void){
//        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        let serverURL = URL(string: urlString!)
//        print("URL:",serverURL)
//      // print(dictionary)
//        
//        let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//        
//        MBProgressHUD.showAdded(to: view.view, animated: true)
//        let parameters:Parameters = dictionary as! Parameters
//        
//        Alamofire.request(serverURL!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON(completionHandler:{ response in
//            switch response.result{
//                
//            case .success:
//                MBProgressHUD.hide(for: view.view, animated: true)
//                
//                let jsonData = JSON(response.result.value!)
//                onComplition(jsonData,nil)
//                break
//            case .failure(let error):
//                MBProgressHUD.hide(for: view.view, animated: true)
//                
//                print(error.localizedDescription)
//                let errorObj = NSError(domain: error.localizedDescription, code: 0, userInfo:nil)
//                onComplition(nil,errorObj)
//                break
//            }
//        })
//    }
//    
//    //Get Data with view
//    func getRequestDataFromServer(url:String,view:UIViewController, onComplition:@escaping (JSON?,NSError?)->Void){
//
//        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        let serverURL = URL(string: urlString!)
//        print("URL:",serverURL)
//        
//        let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//        
//        MBProgressHUD.showAdded(to: view.view, animated: true)
//        
//        Alamofire.request(serverURL!, method:.get, parameters: nil, encoding:URLEncoding.default, headers:header).responseJSON(completionHandler:{ response in
//            
//            
//            switch response.result{
//                
//            case .success:
//                MBProgressHUD.hide(for: view.view, animated: true)
//                
//                let jsonData = JSON(response.result.value!)
//                onComplition(jsonData,nil)
//                break
//            case .failure(let error):
//                MBProgressHUD.hide(for: view.view, animated: true)
//                
//                print(error.localizedDescription)
//                let errorObj = NSError(domain: error.localizedDescription, code: 0, userInfo:nil)
//                onComplition(nil,errorObj)
//                break
//            }
//        })
//    }
//    
//    func uploadLeadAttachmentData(parameters:Dictionary<String, AnyObject>,urL:String,imageFile:UIImage,completion:@escaping (_ response:Dictionary<String,AnyObject>,_ error:NSError?) -> Void) {
//        print("\(#function)_#NS")
//        let imageData = imageFile.jpegData(compressionQuality: 0.1)
//        let uRL = urL
//        print(uRL)
//        //        let headers : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            // import image to request
//            multipartFormData.append(imageData!, withName: "file", fileName: "image1.jpeg", mimeType: "image/jpeg")
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
//            }
//            
//        }, to: uRL,
//           encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    print("SUCCESS IMG UPLOAD")
//                    //print(response)
//                    if let json = response.result.value as? [String: Any] {
//                        //completion(json as [Dictionary],response.result.error as NSError?)
//                        completion(json as Dictionary<String, AnyObject>,response.result.error as NSError?)
//                        //  self.getProfileDetails()
//                    }
//                    else {
//                        print("Failed")
//                    }
//                    // print(response.result.value!)
//                }
//            case .failure(let error):
//                print("FAILED IMG UPLOAD")
//                print(error)
//                
//                //print(error)
//            }
//        })
//    }
//    
//    
////    Custome services for Registration and survey
//    func makeGETRequest(url: String, completionHandler: @escaping (_ responseData: [String:Any], _ error: Error?) -> ()) {
//        
//        //create the url with NSURL
//        let url = URL(string: url)! //change the url
//        
//        //create the session object
//        let session = URLSession.shared
//        
//        //now create the URLRequest object using the url object
//        let request = URLRequest(url: url)
//        
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//            
//            guard error == nil else {
//                return
//            }
//            
//            guard let data = data else {
//                return
//            }
//            
//            do {
//                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
//                    completionHandler(json, nil)
//                }
//                
//            } catch let error {
//                print(error.localizedDescription)
//                completionHandler([:], error)
//            }
//        })
//        task.resume()
//    }
//    
//    func makePOSTRequest(url: String, parameters: Data, completionHandler: @escaping (_ responseData: [String:Any], _ error: Error?) -> ())
//    {
//        //create the url with NSURL
//        let url = URL(string: url)! //change the url
//        
//        //create the session object
//        let session = URLSession.shared
//        
//        //now create the URLRequest object using the url object
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST" //set http method as POST
//        
//        request.httpBody = parameters
//        
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        //request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//            
//            guard error == nil else {
//                return
//            }
//            
//            guard let data = data else {
//                return
//            }
//            
//            do {
//                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
//                    print(json)
//                    completionHandler(json, nil)
//                }
//                
//            } catch let error {
//                print(error.localizedDescription)
//                completionHandler([:], error)
//            }
//        })
//        task.resume()
//    }
//    
//    func postDataFromServerWithoutLoader(url:String,dictionary:NSDictionary, view:UIViewController, onComplition:@escaping (JSON?,NSError?)->Void){
//        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        let serverURL = URL(string: urlString!)
//        print("URL:",serverURL)
//        // print(dictionary)
//        
//        let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//        let parameters:Parameters = dictionary as! Parameters
//        
//        Alamofire.request(serverURL!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON(completionHandler:{ response in
//            switch response.result{
//                
//            case .success:
//                let jsonData = JSON(response.result.value!)
//                onComplition(jsonData,nil)
//                break
//            case .failure(let error):
//
//                print(error.localizedDescription)
//                let errorObj = NSError(domain: error.localizedDescription, code: 0, userInfo:nil)
//                onComplition(nil,errorObj)
//                break
//            }
//        })
//    }
//}
//
//
