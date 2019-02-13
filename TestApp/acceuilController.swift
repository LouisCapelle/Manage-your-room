//
//  acceuilController.swift
//  TestApp
//
//  Created by Louis Capelle on 10/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class acceuilController: UIViewController {
    
    public func alertView(title: String, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func signOut(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toConnect", sender: self)
            print("You have been signed out")
            alertView(title: "Success", message: "You have signed Out")
        }catch let error {
            alertView(title: "Error", message: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let userID = Auth.auth().currentUser?.uid
        
        FirebasRef().root.child("user").child(userID!).observeSingleEvent(of: .value, with: {(snapshot)in
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String ?? ""
            let firstname = value?["firstname"] as? String ?? ""
            let lastname = value?["lastname"] as? String ?? ""
            let age = value?["age"] as? String ?? ""
            let banned = value?["banned"] as? String ?? ""
            let role = value?["role"] as? String ?? ""
            
            
            print("Your mail: ", email)
            print("Your Firstaname: ", firstname)
            print("Your Lastname: ", lastname)
            print("Your Age: ", age)
            print("Your banned Status: ", banned)
            print("Your Role: ", role)
            let message = " email: " + email + " firstname: " + firstname + " lastname: " + lastname + " age: " + age + " banned status: " + banned + " role: " + role
            
            self.alertView(title: "Infos:", message: message)
        }){(error)in
            print(error.localizedDescription)
        }
    }
}
