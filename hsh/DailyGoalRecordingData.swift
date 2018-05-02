//
//  DailyGoalRecordingData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DailyGoalRecordingData: UIViewController {

    @IBOutlet weak var goal: UITextField!
    @IBOutlet weak var iWill: UITextView!
    @IBOutlet weak var myRating: UILabel!
    @IBOutlet weak var parentRating: UILabel!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var instructions: UITextView!
    var myRate : String!
    var parentRate : String!
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
        goal.layer.borderWidth = 1.0
        goal.layer.borderColor = UIColor.black.cgColor
        goal.layer.cornerRadius = 10
        goal.clipsToBounds = true
        
        iWill.layer.borderWidth = 1.0
        iWill.layer.borderColor = UIColor.black.cgColor
        iWill.layer.cornerRadius = 10
        
        notes.layer.borderWidth = 1.0
        notes.layer.borderColor = UIColor.black.cgColor
        notes.layer.cornerRadius = 10
        
        let contentText = "• Daily Goal Recording Form Instructions:List and define your daily goal at the top of the form.Your child’s daily goal can earn up to 2 points.• Complete your Daily Goal Recording Form each evening. You may print a large copy of the form to use with your child.You will also be prompted to add your ratings to the app each evening."
        var alignedContent = contentText.replacingOccurrences(of: ".", with: "\n")
        alignedContent = alignedContent.replacingOccurrences(of: ":", with: "\n \n")
        instructions.text = alignedContent
        //content.translatesAutoresizingMaskIntoConstraints = true
        
        instructions.sizeToFit()
        instructions.isScrollEnabled = false
        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
        let date = Date()
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd-MM-YYYY"
        self.currentDate = formatterDate.string(from: date)
       
    }
    @IBAction func myRatingsChanged(_ sender: UISlider) {
        myRating.text = String(Int(sender.value))
        myRate = String(Int(sender.value))
        
    }
    
    @IBAction func parentRatingsChanged(_ sender: UISlider) {
        parentRating.text = String(Int(sender.value))
        parentRate = String(Int(sender.value))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        let dailyGoalData = ["myGoal" : goal.text, "myRatings" : myRate, "notes" : notes.text, "parentRatings" : parentRate, "toMeetMyGoalIWill" : iWill.text]
        if archiveFlag != 1 {
        ref = Database.database().reference().child("DailyHomeWork");
        ref.child(encodedUserEmail).child("Week5").child("Daily Goal Recording").child(currentDate).setValue(dailyGoalData)
    }
        else{
            let alert = UIAlertController(title: "Message", message: "You cannot redo your previous homework", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
