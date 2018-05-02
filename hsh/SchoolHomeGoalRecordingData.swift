//
//  SchoolHomeGoalRecordingData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class SchoolHomeGoalRecordingData: UIViewController {

   
    @IBOutlet weak var schoolGoal: UITextField!
    @IBOutlet weak var teacherRatings: UILabel!
    @IBOutlet weak var homeGoal: UITextField!
    @IBOutlet weak var homeRatings: UILabel!
    var ref : DatabaseReference!
    var currentDate : String!
    let user = Auth.auth().currentUser
    var user_email : String!
    var encodedUserEmail : String!
    var teacher : String!
    var home : String!
    var archiveFlag:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        schoolGoal.layer.borderWidth = 1.0
        schoolGoal.layer.borderColor = UIColor.black.cgColor
        schoolGoal.layer.cornerRadius = 10
        
        homeGoal.layer.borderWidth = 1.0
        homeGoal.layer.borderColor = UIColor.black.cgColor
        homeGoal.layer.cornerRadius = 10

        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
        let date = Date()
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd-MM-YYYY"
        self.currentDate = formatterDate.string(from: date)
    }
    @IBAction func teacherRatingChanged(_ sender: UISlider) {
        teacher = String(Int(sender.value))
        teacherRatings.text = teacher
    }
    
    @IBAction func homeRatingChanged(_ sender: UISlider) {
        home = String(Int(sender.value))
        homeRatings.text = home
    }
    @IBAction func submitButton(_ sender: UIButton) {
        let schoolHomeData = ["SchoolGoal" : schoolGoal.text, "TeacherRatings" : teacher, "HomeGoal" : homeGoal.text, "ParentRatings" : home]
        if archiveFlag != 1{
        ref = Database.database().reference().child("DailyHomeWork");
        ref.child(encodedUserEmail).child("Week6").child("School and Home Goal").child(currentDate).setValue(schoolHomeData)
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
