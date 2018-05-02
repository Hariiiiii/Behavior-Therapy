//
//  TrophyBoardData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/21/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import DLRadioButton
import FirebaseAuth
import FirebaseDatabase
class TrophyBoardData: UIViewController {

    @IBOutlet weak var instructions: UITextView!
    @IBOutlet weak var dailyGoal: UITextField!
    var dailyScore = 0
    var previousScore = 0
    var ref : DatabaseReference!
    var refTotal : DatabaseReference!
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
        dailyGoal.layer.borderWidth = 1.0
        dailyGoal.layer.borderColor = UIColor.black.cgColor
        dailyGoal.layer.cornerRadius = 10
        
        let contentText = "The assignment this week involves completion of the Trophy Board.•Trophy Board Instructions:•List your new daily goal on the form, and move the prior goal to the first mastered goal line. Your child’s new daily goal can earn up to 2 points. The prior goal can earn up to one bonus point each day.•If you are not adding a new goal, just use the top line of the form and continue to monitor your prior daily goal"
        var alignedContent = contentText.replacingOccurrences(of: ".", with: "\n")
        alignedContent = alignedContent.replacingOccurrences(of: ":", with: "\n \n")
        instructions.text = alignedContent
        //content.translatesAutoresizingMaskIntoConstraints = true
        instructions.isScrollEnabled = false
        instructions.sizeToFit()
        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
        let date = Date()
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd-MM-YYYY"
        self.currentDate = formatterDate.string(from: date)
    }
    @IBAction func dailyOption1(_ sender: DLRadioButton) {
        dailyScore = 2
    }
    @IBAction func dailyOption2(_ sender: DLRadioButton) {
        dailyScore = 1
    }
    @IBAction func dailyOption3(_ sender: DLRadioButton) {
        dailyScore = 0
    }
    
    @IBAction func previousOption1(_ sender: DLRadioButton) {
        previousScore = 1
    }
    @IBAction func previousOption2(_ sender: DLRadioButton) {
        previousScore = 0
    }
    @IBAction func previousOption3(_ sender: DLRadioButton) {
        previousScore = -1
    }
    @IBAction func submitButton(_ sender: UIButton) {
        if archiveFlag != 1 {
        let trophyData = ["dailyGoal" : dailyGoal.text!, "score" : String(dailyScore)] as [String : Any]
        ref = Database.database().reference().child("DailyHomeWork");
        ref.child(encodedUserEmail).child("Week7").child("Trophy Board").child(currentDate).setValue(trophyData)
        var total = 0
        let totalInitial = self.dailyScore + self.previousScore
    
        refTotal = Database.database().reference().child("DailyHomeWork");
        refTotal?.child(encodedUserEmail).child("Week7").child("Trophy Board").child("totalScore").observeSingleEvent(of : .value, with: { (snapshot) in
            if let snap = snapshot.value as? Int{
                total = snap
                total = total + self.dailyScore + self.previousScore
                self.refTotal.child(self.encodedUserEmail).child("Week7").child("Trophy Board").child("totalScore").setValue(total)
            }
            else{
                self.refTotal.child(self.encodedUserEmail).child("Week7").child("Trophy Board").child("totalScore").setValue(totalInitial)
            }
        })
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
