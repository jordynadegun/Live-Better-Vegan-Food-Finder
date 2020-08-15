//
//  LoginScreenViewController.swift
//  Live Better Final Project
//
//  Created by Jordyn Adegun on 8/13/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import UIKit
import Firebase

class LoginScreenViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e = error {
                    print(debugPrint("Error signing in"))
                } else {
                    //Navigate to the Main ViewController
                    self.performSegue(withIdentifier: "loginTransitionToMapView", sender: self)
                }
            }
            
        }
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}
