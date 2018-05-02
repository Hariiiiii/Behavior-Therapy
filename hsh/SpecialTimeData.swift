//
//  SpecialTimeData.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import DLRadioButton
import FirebaseDatabase
import FirebaseAuth

class SpecialTimeData: UIViewController {

    @IBOutlet weak var option2: DLRadioButton!
    @IBOutlet weak var option1: DLRadioButton!
    @IBOutlet weak var activity: UITextField!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var enjoymentLabel: UILabel!
    var ref : DatabaseReference!
    var currentDate : String!
    var ability : String!
    var enjoyment : String!
    var selectedOption : String!
    let user = Auth.auth().currentUser
    var user_email : String!
    var encodedUserEmail : String!
    var url : String!
    var archiveFlag : Int!
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
        // Do any additional setup after loading the view.
    }
    @IBAction func selectedYes(_ sender: DLRadioButton) {
        selectedOption = "yes"
    }
    @IBAction func selectedNo(_ sender: DLRadioButton) {
        selectedOption = "no"
    }
    
    @IBAction func abilityRate(_ sender: UISlider) {
        abilityLabel.text = String(Int(sender.value))
        ability = String(sender.value)
    }
    
    @IBAction func enjoymentRate(_ sender: UISlider) {
        enjoymentLabel.text = String(Int(sender.value))
        enjoyment = String(sender.value)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        let specialTimeData = ["chosenActivity" : activity.text , "completed" : selectedOption , "enjoymentRating" : enjoyment , "abilityRating" : ability, "video" : url ]
        if archiveFlag != 1 {
        ref = Database.database().reference().child("DailyHomeWork");
        ref.child(encodedUserEmail).child("Week2").child("Special Time").child(currentDate).setValue(specialTimeData)
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
