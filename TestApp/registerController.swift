//
//  registerController.swift
//  TestApp
//
//  Created by Louis Capelle on 10/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class registerController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwirdText: UITextField!
    @IBOutlet weak var firstanmeText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    
    public func alertView(title: String, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        performSegue(withIdentifier: "toAcceuil", sender: self)
        
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailText.text ?? "", password: passwirdText.text!){(AuthDataResult, error) in
            if error != nil{
                self.alertView(title: "Error", message: error?.localizedDescription)
            }
            if let utilisateur = AuthDataResult?.user{
                self.alertView(title: "Success", message: "You have been registered")
                self.createUserInDB(user: utilisateur)
                self.performSegue(withIdentifier: "toAcceuil", sender: self)
            }
        }
    }
    
    
    func createUserInDB(user: User){
        
        var dict = [String: AnyObject]()
        
        if let mail = user.email{
            dict["email"] = mail as AnyObject
        }
        if let nameFirebase = user.displayName{
            dict["nameFirebase"] = nameFirebase as AnyObject
        }
        let age = ageText.text
        dict["age"] = age as AnyObject
        let firsname = firstanmeText.text
        dict["firstname"] = firsname as AnyObject
        let lastname = lastnameText.text
        dict["lastname"] = lastname as AnyObject
        let banned = "no"
        dict["banned"] = banned as AnyObject
        let role = "user"
        dict["role"] = role as AnyObject
        FirebaseBDD.shared.createUser(id: user.uid, dict: dict)
    }

}

