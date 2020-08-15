//
//  NewRestaurantViewController.swift
//  Live Better Final Project
//
//  Created by Jordyn Adegun on 7/25/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class NewRestaurantViewController: UIViewController {
    //Outlets
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var hoursTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var restaurantTxtField: UITextField!
    @IBOutlet weak var websiteTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        Firestore.firestore().collection("Restaurants Philadelphia").addDocument(data:
               ["Address" : addressTxtField.text!,
                "Hours" : hoursTxtField.text!,
                "Phone" : phoneTxtField.text!,
                "Restaurant" : restaurantTxtField.text!,
                "Website" : websiteTxtField.text!
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding restaurant: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
       
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
   
}
