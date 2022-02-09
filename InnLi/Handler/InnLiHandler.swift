//
//  InnLiHandler.swift
//  REpeatCom
//
//  Created by comre on 2022/01/05.
//  Copyright © 2022 REpeat. All rights reserved.
//

import UIKit
import WebKit

class InnLiHandler: NSObject {
    class func clearWebCache () {
        
        let storage:HTTPCookieStorage = HTTPCookieStorage.shared
        for cookie in storage.cookies ?? [] {
            storage.deleteCookie(cookie)
        }
     
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
}
