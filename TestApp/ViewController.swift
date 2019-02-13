//
//  ViewController.swift
//  TestApp
//
//  Created by Louis Capelle on 09/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var pwdTxt: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    public func alertView(title: String, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func toRegister(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: self)
        
    }
    
    @IBAction func connectAction(_ sender: Any) {
        
        setupActivity()
        Auth.auth().signIn(withEmail: emailTxt.text ?? "", password: pwdTxt.text ?? ""){(user, error) in
            
            if error != nil{
                self.activityIndicator.stopAnimating()
                self.alertView(title: "Error", message: error?.localizedDescription)
            }else{
                self.performSegue(withIdentifier: "toAcceuil", sender: self)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func setupActivity(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard(#selector(self.dismissKeyboard))
        
        Auth.auth().addStateDidChangeListener(){ auth, user in
            if user != nil{
                self.setupActivity()
                let userID = Auth.auth().currentUser?.uid
                
                FirebasRef().root.child("user").child(userID!).observeSingleEvent(of: .value, with: {(snapshot)in
                    
                    let value = snapshot.value as? NSDictionary
                    let role = value?["role"] as? String ?? ""
                    
                    self.activityIndicator.stopAnimating()
                    
                    switch role{
                        
                    case "user": self.performSegue(withIdentifier: "toAcceuil", sender: self)
                        
                    case "admin": self.performSegue(withIdentifier: "toAdminPage", sender: self)
                        
                    case "owner": self.performSegue(withIdentifier: "toOwnerPage", sender: self)
                        
                    default:
                        self.alertView(title: "Error", message: "No Role")
                        print("no role")
                    }
                
                    
                }){(error)in
                    print(error.localizedDescription)
                }
            }
        }
    }
}

