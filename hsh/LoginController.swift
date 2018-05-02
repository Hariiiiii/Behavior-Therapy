//
//  LoginController.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 3/3/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    var isSignin: Bool = true
    
    override var   supportedInterfaceOrientations : UIInterfaceOrientationMask{
        
        return  .portrait
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        let borderColor = UIColor.black
        middleView.layer.borderColor = borderColor.cgColor
        middleView.layer.borderWidth = 1.0
        middleView.layer.cornerRadius = 10
        middleView.clipsToBounds = true
        
        userID.layer.borderColor = borderColor.cgColor
        userID.layer.borderWidth = 1.0
        userID.layer.cornerRadius = 10
        userID.clipsToBounds = true
        
        password.layer.borderColor = borderColor.cgColor
        password.layer.borderWidth = 1.0
        password.layer.cornerRadius = 10
        password.clipsToBounds = true
        
        signinButton.layer.cornerRadius = 10
        signinButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        isSignin = !isSignin
        
        if isSignin {
            signinButton.setTitle("SIGN IN", for: .normal)
        }
        
        else {
            signinButton.setTitle("REGISTER", for: .normal)
        }
    }
    @IBAction func signinPressed(_ sender: UIButton) {
        
        if let email = userID.text, let password = password.text {
            
            if isSignin {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    
                    if user != nil {
                        //If user found
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        //Error
                        let alert = UIAlertController(title: "Login Error", message: "Invalid Username/Password", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                })
            }
            else {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if user != nil {
                        //If user found
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        //Error
                    }
                })
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
