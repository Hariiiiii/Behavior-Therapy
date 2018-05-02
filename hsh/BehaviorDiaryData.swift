//
//  BehaviorDiaryData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import DateTimePicker

class BehaviorDiaryData: UIViewController, UITextViewDelegate {

    @IBOutlet weak var problem: UITextField!
    @IBOutlet weak var before: UITextField!
    @IBOutlet weak var after: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    var selectedDate : String!
    var ref : DatabaseReference!
    var refScores : DatabaseReference!
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
        dateButton.layer.cornerRadius = 10
        dateButton.clipsToBounds = true
        
        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
        
        
       // Do any additional setup after loading the view.
    }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickDate(_ sender: UIButton) {
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.isDatePickerOnly = true
        picker.completionHandler = { date in
            let formatterDate = DateFormatter()
            formatterDate.dateFormat = "dd-MM-YYYY"
            self.selectedDate = formatterDate.string(from: date)
        }
    }
    
    @IBAction func submitbutton(_ sender: UIButton) {
        let behaviorData = ["problemBehavior" : problem.text , "whenAndWhere" : location.text , "beforeBehavior" : before.text , "afterBehavior" : after.text , "notes" : note.text]
        if archiveFlag != 1 {
        refScores = Database.database().reference().child("DailyHomeWork");
        refScores.child(encodedUserEmail).child("Week1").child("Behavior Diary Form").child(selectedDate).setValue(behaviorData)
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
