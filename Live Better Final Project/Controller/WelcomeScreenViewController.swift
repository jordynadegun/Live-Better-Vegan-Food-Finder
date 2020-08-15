//
//  WelcomeScreenViewController.swift
//  Live Better Final Project
//
//  Created by Jordyn Adegun on 8/13/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import UIKit
import Firebase

class WelcomeScreenViewController: UIViewController {

    @IBAction func subscribeButtonTapped(_ sender: Any) {
        
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
        override func viewDidAppear(_ animated: Bool) {
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "rootViewtoMapViewTransition", sender: self)

        }
        
    }
  

}
