//
//  RCYmDatamanager.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/5.
//


import Foundation
import SwifterSwift
import UIKit

 
struct RCYEmojiItem: Codable {
    var title1: String?
    var title2: String?
//    var isPro: Bool?
//
}


class RCYiymDataManager: NSObject {
    static let `default` = RCYiymDataManager()
    var currentColorIndex: Int = 0
    

    
    
    
    
    
    
    
    var randomBgColorList: [String] = ["#FFF483", "#FDCDFF", "#82F6AC", "#FFCDCB"]
    var repeatWordsList: [String] = ["Star", "Bear", "Fast", "Line", "Face", "Help", "Fear", "Such", "Move", "Come", "Miss", "Baby", "Kiss", "Feel", "Dear"]
    
    func nextColorStr() -> String {
        let colorStr = randomBgColorList[currentColorIndex]
        currentColorIndex += 1
        if currentColorIndex == randomBgColorList.count {
            currentColorIndex = 0
        }
        return colorStr
    }
     
    var emojiList : [RCYEmojiItem] {
        return RCYiymDataManager.default.loadJson([RCYEmojiItem].self, name: "emoji") ?? []
    }
//
    
    
    override init() {
        super.init()
         
        
    }
     
    
}

extension RCYiymDataManager {
    
}


extension RCYiymDataManager {
    func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try! JSONDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                debugPrint(error)
            }
        }
        return nil
    }
    
    func loadJson<T: Codable>(_:T.Type, path:String) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            do {
                return try PropertyListDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            return loadJson(T.self, path: path)
        }
        return nil
    }
    
}



public func MyColorFunc(_ red:CGFloat,_ gren:CGFloat,_ blue:CGFloat,_ alpha:CGFloat) -> UIColor? {
    let color:UIColor = UIColor(red: red/255.0, green: gren/255.0, blue: blue/255.0, alpha: alpha)
    return color
}


 

