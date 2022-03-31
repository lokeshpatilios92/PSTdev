//
//  ETPLDateFormater.swift
//  SotsTag
//
//  Created by Kaustubh_ETPL on 16/04/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//

import Foundation

class ETPLDateFormater {
   
    static func getFotmattedDateInString(_ date:Date? , format:String) -> String {
        if( date != nil )
        {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            //            let DateInFormat = formatter.string(from: date!)
            
            return formatter.string(from: date!)
        }
        else
        {
            return ""
        }
    }
    
    static func getDateFromString( date:String , formate:String ) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let date = dateFormatter.date(from: date)
        return date
    }
    
    
    static func getTweleveTime(time:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date12 = dateFormatter.date(from: time)!
        
        dateFormatter.dateFormat = "hh:mm a"
        let stringDate = dateFormatter.string(from: date12)
        
       return stringDate
    }
    
}
