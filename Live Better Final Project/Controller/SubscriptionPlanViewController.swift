//
//  SubscriptionPlanViewController.swift
//  Live Better Final Project
//
//  Created by Jordyn Adegun on 8/7/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import UIKit
import StoreKit
import FirebaseAuth
import Firebase



class SubscriptionPlanViewController: UIViewController, UITextFieldDelegate, SKPaymentTransactionObserver {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
    }
    
    let prodcutID = "08072020"
    var discounts = ""
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        subscribeToMonthlyPlan()
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if let e = error {
                    print(e.localizedDescription)
                    return
                } else {
                    //Navigate to the Main ViewController
                    self.performSegue(withIdentifier: "signUpTransitionToMapView", sender: self)
                }
            }
        }
    }
    func subscribeToMonthlyPlan() {
        if SKPaymentQueue.canMakePayments() {
            //can make payments
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = prodcutID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            //can not make payments
            print("User can not make payment")
        }
    }
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //user's payment was successful
                print("Successful transaction")
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                //payment did not go through
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                     print("Transaction failed due to error: \(errorDescription)")
                    self.view.isUserInteractionEnabled = false
                }
                  SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
}


