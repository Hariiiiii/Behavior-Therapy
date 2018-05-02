//
//  IndependentPlayData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class IndependentPlayData: UIViewController {

    @IBOutlet weak var activity: UITextField!
    @IBOutlet weak var checkIn: UILabel!
    @IBOutlet weak var response: UITextField!
    var interval : String!
    let user = Auth.auth().currentUser
    var user_email : String!
    var encodedUserEmail : String!
    var ref : DatabaseReference!
    var currentDate : String!
    var archiveFlag :Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
        let date = Date()
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd-MM-YYYY"
        self.currentDate = formatterDate.string(from: date)
    }
    @IBAction func checkInTimes(_ sender: UISlider) {
        checkIn.text = String(Int(sender.value))
        interval = String(Int(sender.value))
    }
    @IBAction func submitButton(_ sender: UIButton) {
        let independentLogData = ["assignedActivity" : activity.text, "checkInIntervals" : interval, "childResponse" : response.text]
        if archiveFlag != 1 {
        ref = Database.database().reference().child("DailyHomeWork");
        ref.child(encodedUserEmail).child("Week3").child("Differential Attention and Independent Play").child(currentDate).setValue(independentLogData)
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
