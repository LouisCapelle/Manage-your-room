//
//  ownerPageViewController.swift
//  TestApp
//
//  Created by Louis CAPELLE on 11/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ownerPageViewController: UIViewController {

    var myUserUid = Auth.auth().currentUser?.uid
    var roomItems: [Room] = []
    
    var nameKey = ""
    var nameName = ""
    var adress = ""
    
    public func alertView(title: String, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func seeMyRoom(_ sender: Any) {
        
        FirebasRef().rootUser.child((Auth.auth().currentUser?.uid)!).child("rooms").observe(.value, with: {snapshot in
            print(snapshot.value!)
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let roomItem = Room(snapshot: snapshot) {
         
                }
            }
        })

    }
    
    
    
    @IBAction func addRoom(_ sender: Any) {
        
        Auth.auth().addStateDidChangeListener(){ auth, user in
            if user != nil{
                
                self.createRoomInDB(user: (auth.currentUser ?? nil)!, nameOfRoom: "")
                
            }
        }
    }
    
    func createRoomInDB(user: User, nameOfRoom: String){
        
        var dict = [String: AnyObject]()
        
        let adress = "Mon Cul"
        dict["adress"] = adress as AnyObject
        let name = "Nom de merde"
        dict["name"] = name as AnyObject
        
        FirebaseBDD.shared.createRoom(id: user.uid,name: nameOfRoom, dict: dict)
        }
}
