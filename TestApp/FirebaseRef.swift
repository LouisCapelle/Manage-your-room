//
//  FirebaseRef.swift
//  TestApp
//
//  Created by Louis Capelle on 10/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import FirebaseDatabase


class FirebasRef {
    
    let root = Database.database().reference()
    
    var rootUser: DatabaseReference{
        return root.child("user")
    }
    
    var rootRoom: DatabaseReference{
        return root.child("user").child("rooms")
    }
    
    func specificUser(id: String) -> DatabaseReference{
        return rootUser.child(id)
    }
    
}
