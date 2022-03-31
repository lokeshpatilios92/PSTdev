//
//  Helper.swift
//  FannanArtist
//
//  Created by mac on 19/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class Helper
{
    static func localize(locStr: String) -> String
    {
        let str = AMPLocalizeUtils.defaultLocalizer.stringForKey(key: locStr)
        return str
    }
}

