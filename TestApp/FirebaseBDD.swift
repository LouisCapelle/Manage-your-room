//
//  FirebaseBDD.swift
//  TestApp
//
//  Created by Louis Capelle on 10/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirebaseBDD{

    static let shared = FirebaseBDD()
    
    
    func createUser(id: String, dict: [String:AnyObject]){
        
        FirebasRef().rootUser.child(id).updateChildValues(dict)
        
    }
    
    func createRoom(id: String, name: String, dict: [String:AnyObject]){

        FirebasRef().rootUser.child(id).child("rooms").child(name).updateChildValues(dict)

    }
}
