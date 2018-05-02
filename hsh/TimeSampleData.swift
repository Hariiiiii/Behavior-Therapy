//
//  TimeSampleData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/18/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import DateTimePicker
import FirebaseDatabase
import FirebaseAuth

class TimeSampleData: UIViewController {

    @IBOutlet weak var dateTimeButton: UIButton!
    @IBOutlet weak var Behavior: UITextField!
    @IBOutlet weak var Times: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var selectedDate : String!
    var selectedTime: String!
    var targetBehavior : String!
    var noOfTimes : String!
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
        dateTimeButton.layer.cornerRadius = 10
        dateTimeButton.clipsToBounds = true
        var picker: DateTimePicker?
        // Do any additional setup after loading the view.
        //User email
        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
    }
    @IBAction func pickDateTime(_ sender: UIButton) {
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.completionHandler = { date in
            let formatterDate = DateFormatter()
            let formatterTime = DateFormatter()
            formatterDate.dateFormat = "dd-MM-YYYY"
            formatterTime.dateFormat = "HH:mm"
            self.selectedDate = formatterDate.string(from: date)
            self.selectedTime = formatterTime.string(from: date)
        }
    }
    @IBAction func submitData(_ sender: UIButton) {
        self.targetBehavior = Behavior.text
        self.noOfTimes  = Times.text
        if archiveFlag != 1 {
        refScores = Database.database().reference().child("DailyHomeWork");
        let timeSample = ["targetBehavior" : targetBehavior , "noOfTimes" : noOfTimes , "selectedDate" : selectedDate , "selectedTime" : selectedTime]
    refScores.child(encodedUserEmail).child("Week1").child("Time Sample").child(selectedDate).child(selectedTime).setValue(timeSample)
        }
        else{
                let alert = UIAlertController(title: "Message", message: "You cannot redo your previous homework", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "timeToBehavior") {
            let vc = segue.destination as! BehaviorDiaryVideo
            vc.archiveFlag = 1
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
