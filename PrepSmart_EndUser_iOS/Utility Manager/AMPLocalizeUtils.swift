//
//  AMPLocalizeUtils.swift
//  FannanArtist
//
//  Created by mac on 13/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AMPLocalizeUtils: NSObject {

    static let defaultLocalizer = AMPLocalizeUtils()
    var appbundle = Bundle.main
    
    func setSelectedLanguage(lang: String) {
        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            appbundle = Bundle.main
            return
        }
        appbundle = Bundle(path: langPath)!
    }
    
    func stringForKey(key: String) -> String {
       // let string = "    example  "
        let trimmed = key.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        print(">" + trimmed + "<")
        return appbundle.localizedString(forKey: key, value: "", table: nil)
    }
}
