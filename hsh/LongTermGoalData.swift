//
//  LongTermGoalData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/22/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LongTermGoalData: UIViewController {

    @IBOutlet weak var bigThing1: UITextField!
    @IBOutlet weak var pointValue1: UITextField!
    @IBOutlet weak var bigThings2: UITextField!
    @IBOutlet weak var pointValue2: UITextField!
    
    @IBOutlet weak var behavior1: UITextField!
    @IBOutlet weak var definition1: UITextView!
    @IBOutlet weak var behavior2: UITextField!
    
    @IBOutlet weak var definition2: UITextView!
    
    var ref : DatabaseReference!
    var currentDate : String!
    let user = Auth.auth().currentUser
    var user_email : String!
    var encodedUserEmail : String!
    var archiveFlag:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
        let date = Date()
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd-MM-YYYY"
        self.currentDate = formatterDate.string(from: date)
        definition1.layer.cornerRadius = 10
        definition1.layer.masksToBounds = true
        
        definition2.layer.cornerRadius = 10
        definition2.layer.masksToBounds = true
        
        bigThing1.layer.cornerRadius = 10
        bigThing1.layer.masksToBounds = true
        
        bigThings2.layer.cornerRadius = 10
        bigThings2.layer.masksToBounds = true
        
    }
    @IBAction func submitButton(_ sender: UIButton) {
        let longTermGoalData1 = ["pointValue" : pointValue1.text, "Behavior" : behavior1.text, "Definition" : definition1.text]
        let longTermGoalData2 = ["pointValue" : pointValue2.text, "Behavior" : behavior2.text, "Definition" : definition2.text]
        if archiveFlag != 1 {
        ref = Database.database().reference().child("DailyHomeWork");
        ref.child(encodedUserEmail).child("Week8").child("Long Term Goal").child(currentDate).child(bigThing1.text!).setValue(longTermGoalData1)
        ref.child(encodedUserEmail).child("Week8").child("Long Term Goal").child(currentDate).child(bigThings2.text!).setValue(longTermGoalData2)
    }
        else{
            let alert = UIAlertController(title: "Message", message: "You cannot redo your previous homework", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
