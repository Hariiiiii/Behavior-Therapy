//
//  WeeklyGoal.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 3/19/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import DLRadioButton

extension Collection where Element: Numeric {
    /// Returns the sum of all elements in the collection
    func sum() -> Element { return reduce(0, +) }
}

class WeeklyGoal: UIViewController {

    //Question Label
    @IBOutlet weak var goalQuestionText: UILabel!
    
    //Seletion Buttons
    
    @IBOutlet weak var option1: DLRadioButton!
    @IBOutlet weak var option2: DLRadioButton!
    @IBOutlet weak var option3: DLRadioButton!
    @IBOutlet weak var option4: DLRadioButton!
    @IBOutlet weak var option5: DLRadioButton!
    @IBOutlet weak var option6: DLRadioButton!
    
    //Selection Labels
    
    @IBOutlet weak var selectLabel1: UILabel!
    @IBOutlet weak var selectLabel2: UILabel!
    @IBOutlet weak var selectLabel3: UILabel!
    @IBOutlet weak var selectLabel4: UILabel!
    @IBOutlet weak var selectLabel5: UILabel!
    @IBOutlet weak var selectLabel6: UILabel!
    
    @IBOutlet weak var nextButtonStyle: UIButton!
    @IBOutlet weak var backButtonStyle: UIButton!
    //Button Stack
    @IBOutlet weak var buttonStack: UIStackView!
    // Selection label stack
    @IBOutlet weak var selectLabelStack: UIStackView!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    var ref : DatabaseReference!
    var refScores : DatabaseReference!
    var noOfitems = 0
    var goalCount : Int!
    var incrementVariable : Int!
    var goalData : [String : String]!
    var goalQuestionNumber = 0
    var goalTitles : [String]!
    var goalTitleNumber  = 0
    var submit_flag = true
    var affectModulationScores =  [Int]()
    var peerRelationShipScores = [Int]()
    var satisfactionScores = [Int]()
    var managingAttentionScores = [Int]()
    var managingActivityScores = [Int]()
    var implementationStrategiesScores = [Int]()
    var parentalStressScores = [Int]()
    var parentingAllianceScores = [Int]()
    var feasibilitySmartphoneScores = [Int]()
    //User info from firebase
    let user = Auth.auth().currentUser
    var user_email : String!
    var encodedUserEmail : String!
    var currentWeek : String!
    override var   supportedInterfaceOrientations : UIInterfaceOrientationMask{
        
        return  .portrait
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "graphToView") {
            let vc = segue.destination as! GraphView
            vc.user_email = user_email
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        backButtonStyle.layer.cornerRadius = 10
        backButtonStyle.clipsToBounds = true
        nextButtonStyle.layer.cornerRadius = 10
        nextButtonStyle.clipsToBounds = true
        goalQuestionText.numberOfLines = 0
        goalQuestionText.adjustsFontSizeToFitWidth = true
        goalQuestionText.textAlignment = .left
        
        //User email
        if let user = user {
            self.user_email = user.email!
        }
        encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
        //Initializing variables
        incrementVariable = 1
        goalQuestionNumber = 1
        
        //Initializing the Goal score arrays
        affectModulationScores.reserveCapacity(10)
        affectModulationScores.append(0)
        peerRelationShipScores.reserveCapacity(10)
        peerRelationShipScores.append(0)
        satisfactionScores.reserveCapacity(10)
        satisfactionScores.append(0)
        managingAttentionScores.reserveCapacity(10)
        managingAttentionScores.append(0)
        managingActivityScores.reserveCapacity(10)
        managingActivityScores.append(0)
        implementationStrategiesScores.reserveCapacity(10)
        implementationStrategiesScores.append(0)
        parentalStressScores.reserveCapacity(10)
        parentalStressScores.append(0)
        parentingAllianceScores.reserveCapacity(10)
        parentingAllianceScores.append(0)
        feasibilitySmartphoneScores.reserveCapacity(10)
        feasibilitySmartphoneScores.append(0)
    
        
        
        //Firebase data retreival
        ref = Database.database().reference()
        ref?.child("WeeklyGoal").observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary  //entire snapshot value
            self.goalTitles = value?.allKeys as! [String]
            self.goalCount = self.goalTitles.count
            print(self.goalTitles)
            for goalTitle in self.goalTitles {
                let refToPost = Database.database().reference(withPath: "WeeklyGoal/" + goalTitle)
                refToPost.observe(.value, with: { (snapshot) in
                    if snapshot.exists() {
                        let snap = snapshot.value as? [String : String]
                        self.goalData = snap!
                        self.noOfitems = self.goalData!.count - 1
                        self.displayGoal(data: self.goalData, noOfItems: self.noOfitems)
                        self.setButtonText(text: goalTitle)
                    }
                    else{
                        print("Cant fetch data")
                    }
                })
                break
            }
        })
    }
    
    //Radio button selection actions
    @IBAction func option1Selected(_ sender: DLRadioButton) {
        updateScore(title : self.goalTitleNumber, question : self.goalQuestionNumber, score : 1)
    }
    
    @IBAction func option2Selected(_ sender: DLRadioButton) {
        updateScore(title : self.goalTitleNumber, question : self.goalQuestionNumber, score : 2)
    }
    
    @IBAction func option3Selected(_ sender: DLRadioButton) {
        updateScore(title : self.goalTitleNumber, question : self.goalQuestionNumber, score : 3)
    }
    
    @IBAction func option4Selected(_ sender: DLRadioButton) {
        updateScore(title : self.goalTitleNumber, question : self.goalQuestionNumber, score : 4)
    }
    
    @IBAction func option5Selected(_ sender: DLRadioButton) {
        updateScore(title : self.goalTitleNumber, question : self.goalQuestionNumber, score : 5)
    }
    
    @IBAction func option6Selected(_ sender: DLRadioButton) {
        updateScore(title : self.goalTitleNumber, question : self.goalQuestionNumber, score : 0)
    }
    
    //update goalscore array with user selected scores
    func updateScore(title : Int, question : Int, score : Int){
        if title == 0 {
            self.affectModulationScores.insert(score, at: question)
            print(self.affectModulationScores[question])
        }
        else if title == 1 {
            self.peerRelationShipScores.insert(score, at: question)
        }
        else if title == 2 {
            self.satisfactionScores.insert(score, at: question)
        }
        else if title == 3 {
            self.managingAttentionScores.insert(score, at: question)
        }
        else if title == 4 {
            self.managingActivityScores.insert(score, at: question)
        }
        else if title == 5 {
            self.implementationStrategiesScores.insert(score, at: question)
        }
        else if title == 6 {
            self.parentalStressScores.insert(score, at: question)
        }
        else if title == 7 {
            self.parentingAllianceScores.insert(score, at: question)
        }
        else if title == 8 {
            self.feasibilitySmartphoneScores.insert(score, at: question)
        }
        
    }
    
    func displayGoal(data : [String : String] , noOfItems : Int){
        option1.isSelected  = false
        option2.isSelected  = false
        option3.isSelected  = false
        option4.isSelected  = false
        option5.isSelected  = false
        option6.isSelected  = false
        
        if goalQuestionNumber <= noOfItems {
            buttonStack.isHidden = false
            selectLabelStack.isHidden = false
       
           if goalQuestionNumber == 1 {
            goalQuestionText.text = data["1"]
            
           }
           else if goalQuestionNumber == 2 {
            goalQuestionText.text = data["2"]
            
           }
           else if goalQuestionNumber == 3 {
            goalQuestionText.text = data["3"]
            
           }
           else if goalQuestionNumber == 4 {
            goalQuestionText.text = data["4"]
            
            }
           else if goalQuestionNumber == 5 {
            goalQuestionText.text = data["5"]
            
            }
           else if goalQuestionNumber == 6 {
            goalQuestionText.text = data["6"]
            
            }
           else if goalQuestionNumber == 7 {
            goalQuestionText.text = data["7"]
            
            }
        }
        else {
            goalQuestionText.text = "End of '\(goalTitles[goalTitleNumber])' section"
            goalQuestionText.font = UIFont.boldSystemFont(ofSize: 16.0)
            buttonStack.isHidden = true
            selectLabelStack.isHidden = true
            goalQuestionNumber = 0
            goalTitleNumber = goalTitleNumber + 1
           // print("total for", goalTitles[goalTitleNumber], affectModulationScores[1] + affectModulationScores[2])
        }
    }
    func setButtonText(text : String){
        if text == "ParentalStress" {
            selectLabel1.text = "No stress"
            selectLabel2.text = "Minimal stress"
            selectLabel3.text = "Mild Stress"
            selectLabel4.text = "Moderate Stress"
            selectLabel5.text = "Significant/severe stress "
            selectLabel6.text = "Prefer not to answer"
        }
        else if text == "ParentingAlliance" {
            selectLabel1.text = "Strongly disagree"
            selectLabel2.text = "Disagree"
            selectLabel3.text = "Neither agree nor disagree"
            selectLabel4.text = "Agree"
            selectLabel5.text = "Strongly agree"
            selectLabel6.text = "Prefer not to answer"
        }
        else if text == "Satisfaction with Treatment" {
            
        }
        else if text == "FeasibilityOfSmartphoneApp" {
            
        }
        else {
            selectLabel1.text = "Never/No instances"
            selectLabel2.text = "In a few instances"
            selectLabel3.text = "Half of the time"
            selectLabel4.text = "Most of the time"
            selectLabel5.text = "Almost always"
            selectLabel6.text = "Prefer not to answer"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            performSegue(withIdentifier: "weekGoalToMenu", sender: self)
        }
        else if sender.tag == 2 {
            performSegue(withIdentifier: "weekGoalToQuestion", sender: self)
        }
        else if sender.tag == 3 {
            incrementVariable = incrementVariable - 1
            if incrementVariable <= 35 && (goalQuestionNumber == 0 || goalQuestionNumber == 1) {
                self.goalTitleNumber = self.goalTitleNumber - 1
                if goalTitleNumber >= 0 {
                    self.ref?.child("WeeklyGoal").observe(.value, with: { (snapshot) in
                    for goalTitle in self.goalTitles {
                        let refToPost = Database.database().reference(withPath: "WeeklyGoal/" + self.goalTitles[self.goalTitleNumber])
                        refToPost.observe(.value, with: { (snapshot) in
                            if snapshot.exists() {
                                let snap = snapshot.value as? [String : String]
                                self.goalData = snap!
                                self.noOfitems = self.goalData!.count - 1
                                self.goalQuestionNumber = self.noOfitems
                                self.displayGoal(data: self.goalData, noOfItems: self.noOfitems)
                                //self.incrementVariable = self.incrementVariable + 1
                                self.setButtonText(text: goalTitle)
                            }
                            else{
                                print("Cant fetch data")
                            }
                        })
                        break
                    }
                })
                }
                else {
                    dismiss(animated: true, completion: nil)
                }
            }
            else if incrementVariable <= 35 && goalQuestionNumber > 1 {
                ref?.child("WeeklyGoal").observe(.value, with: { (snapshot) in
                    for goalTitle in self.goalTitles {
                        let refToPost = Database.database().reference(withPath: "WeeklyGoal/" + self.goalTitles[self.goalTitleNumber])
                        refToPost.observe(.value, with: { (snapshot) in
                            if snapshot.exists() {
                                let snap = snapshot.value as? [String : String]
                                self.goalData = snap!
                                self.noOfitems = self.goalData!.count - 1
                                self.goalQuestionNumber = self.goalQuestionNumber - 1
                                self.displayGoal(data: self.goalData, noOfItems: self.noOfitems)
                                //self.incrementVariable = self.incrementVariable + 1
                                self.setButtonText(text: goalTitle)
                            }
                            else{
                                print("Cant fetch data")
                            }
                        })
                        break
                    }
                })
            }
        }
        else if sender.tag == 4 {
            if option1.isSelected == false && option2.isSelected == false && option3.isSelected == false && option4.isSelected == false && option5.isSelected == false && option6.isSelected == false {
                updateScore(title : self.goalTitleNumber, question : self.goalQuestionNumber, score : 0)
            }
            if incrementVariable <= 35 {
                
                goalQuestionNumber = goalQuestionNumber + 1
                ref?.child("WeeklyGoal").observe(.value, with: { (snapshot) in
                    for goalTitle in self.goalTitles {
                        let refToPost = Database.database().reference(withPath: "WeeklyGoal/" + self.goalTitles[self.goalTitleNumber])
                        refToPost.observe(.value, with: { (snapshot) in
                            if snapshot.exists() {
                                let snap = snapshot.value as? [String : String]
                                self.goalData = snap!
                                self.noOfitems = self.goalData!.count - 1
                                self.displayGoal(data: self.goalData, noOfItems: self.noOfitems)
                                self.incrementVariable = self.incrementVariable + 1
                                self.setButtonText(text: goalTitle)
                            }
                            else{
                                print("Cant fetch data")
                            }
                        })
                        break
                    }
                })
            }
            else{
                if goalTitleNumber <= 8 {
                goalQuestionText.text = "End of '\(goalTitles[goalTitleNumber])' section"
                goalQuestionText.font = UIFont.boldSystemFont(ofSize: 16.0)
                buttonStack.isHidden = true
                selectLabelStack.isHidden = true
                }
                if submit_flag == true {
                    goalQuestionText.text = "Click on submit button to submit your weekly goals"
                    nextButton.setTitle("Submit", for: .normal)
                     print(affectModulationScores.sum())
                     print(peerRelationShipScores.sum())
                     print(satisfactionScores.sum())
                     print(managingAttentionScores.sum())
                     print(managingActivityScores.sum())
                     print(implementationStrategiesScores.sum())
                     print(parentalStressScores.sum())
                     print(parentingAllianceScores.sum())
                     print(feasibilitySmartphoneScores.sum())
                   
                    //print(self.user_email!)
                    let goalScores = ["affect_modulation" : affectModulationScores.sum() / 2, "peer_relationship" : peerRelationShipScores.sum() / 2, "satisfaction" : satisfactionScores.sum() / 3, "managing_attention" : managingAttentionScores.sum() / 3, "managing_activity" : managingActivityScores.sum() / 3, "implementation_strategy" : implementationStrategiesScores.sum(), "parental_stress" : parentalStressScores.sum() / 3, "parental_alliance" : parentingAllianceScores.sum() / 3, "feasibility_smartphone" : feasibilitySmartphoneScores.sum() / 7]
                    refScores = Database.database().reference().child("Scores");
                    
                    self.refScores.child(currentWeek).child(self.encodedUserEmail).setValue(goalScores)
                    //updateScores(goalScores : goalScores)
                    
                }
            }
        }
    }
    
    func updateScores(goalScores : [String : Any]){
        ref.child("Scores").child("Week1").child(self.user_email).setValue(goalScores);
    }
}
