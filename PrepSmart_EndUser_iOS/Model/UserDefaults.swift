//
//  UserDefaults.swift
//  FannanArtist
//
//  Created by mac on 13/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

extension UserDefaults{
    //MARK: Save User Data
    func setLangCode(value: String){
        set(value, forKey: UserDefaultsKeys.langCode.rawValue)
        //synchronize()
    }

    //MARK: Retrieve User Data
    func getLangCode() -> String{
        return string(forKey: UserDefaultsKeys.langCode.rawValue) ?? "en"
    }
}

enum UserDefaultsKeys : String {
    case langCode
}
