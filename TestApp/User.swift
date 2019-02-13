//
//  User.swift
//  TestApp
//
//  Created by Louis Capelle on 10/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import FirebaseDatabase

class User{
    
    private var _ref: DatabaseReference
    private var _id: String!
    private var _email: String!
    private var _firstname: String!
    private var _lastname: String!
    private var _age: String!
    private var _banned: String!
    private var _role: String!
    
    var ref: DatabaseReference{return _ref}
    var id: String{return _id}
    var email: String {return _email}
    var firstaname: String {return _firstname}
    var lastname: String {return _lastname}
    var age: String {return _age}
    var banned: String {return _banned}
    var role: String {return _banned}
    
    init?(snapshot: DataSnapshot){
        
        guard let dict = snapshot.value as? [String: AnyObject] else {return}
        self._ref = snapshot.ref
        self._id = snapshot.key
        self._email = dict["email"] as? String ?? ""
        self._firstname = dict["firstname"] as? String ?? ""
        self._lastname = dict["lastname"] as? String ?? ""
        self._age =  dict["age"] as? String ?? ""
        self._banned = dict["banned"] as? String ?? ""
        self._role = dict["role"] as? String ?? ""
        
        return nil
    }
}
