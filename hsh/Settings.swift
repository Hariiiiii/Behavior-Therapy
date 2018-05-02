//
//  Settings.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/3/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import  Firebase
import FirebaseAuth

class Settings: UIViewController {

    @IBOutlet weak var oldPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var oldPasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
   
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        if let controller =  self.storyboard?.instantiateViewController(withIdentifier: "homeScreen"){
            self.present(controller, animated: false, completion: nil)
        }
    }
    let user = Auth.auth().currentUser
    var user_email : String!
    typealias Completion = (Error?) -> Void
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPasswordLabel.isHidden = true
        newPasswordLabel.isHidden = true
        oldPasswordText.isHidden = true
        newPasswordText.isHidden = true
        
        changeEmailButton.layer.cornerRadius = 10
        changeEmailButton.clipsToBounds = true
        
        changePasswordButton.layer.cornerRadius = 10
        changePasswordButton.clipsToBounds = true
        
        resetPasswordButton.layer.cornerRadius = 10
        resetPasswordButton.clipsToBounds = true
        
        if let user = user {
            self.user_email = user.email!
        }
    }

    
    
    
    @IBAction func changePassword(_ sender: UIButton) {
        oldPasswordLabel.isHidden = false
        newPasswordLabel.isHidden = false
        oldPasswordText.isHidden = false
        newPasswordText.isHidden = false
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        let credential = EmailAuthProvider.credential(withEmail: self.user_email!, password: oldPasswordText.text!)
        print(self.user_email!, oldPasswordText.text!)
        
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
            if error == nil {
                Auth.auth().currentUser?.updatePassword(to: self.newPasswordText.text!) { (errror) in
                    let alert = UIAlertController(title: "Success", message: "Password has been changed successfully", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            } else {
                print(error as Any)
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
