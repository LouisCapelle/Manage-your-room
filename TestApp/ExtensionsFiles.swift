//
//  ExtensionsFiles.swift
//  TestApp
//
//  Created by Louis Capelle on 10/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import Firebase

extension UIViewController{
    func hideKeyboard(_ selector: Selector){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension String {
    
    static func random(length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}


struct Room {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let adress: String
    
    init(name: String, adress: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.adress =  adress
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let adress = value["adress"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.adress = adress
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "adress": adress
        ]
    }
}



