//
//  WeeklyArchives.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/2/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit

class WeeklyArchives: UIViewController {
    
    var requestedWeek : Int!
    var reqWeek : String!
    @IBOutlet weak var homeworkButton: UIButton!
    
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet weak var lessonsButton: UIButton!
    
    @IBOutlet weak var practiveButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeworkButton.layer.cornerRadius = 10
        homeworkButton.clipsToBounds = true
        
        tipsButton.layer.cornerRadius = 10
        tipsButton.clipsToBounds = true
        
        lessonsButton.layer.cornerRadius = 10
        lessonsButton.clipsToBounds = true
        
        practiveButton.layer.cornerRadius = 10
        practiveButton.clipsToBounds = true
        
        reqWeek = "Week\(requestedWeek!)"
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "archiveToLessons") {
            let vc = segue.destination as! WeeklyLesson
            vc.archiveFlag = 1
            vc.archiveWeek = "Week\(requestedWeek!)"
        }
        else if (segue.identifier == "archiveToTips") {
            let vc = segue.destination as! ArchiveDailyTips
            vc.reqWeek = reqWeek
            
        }
        else if (segue.identifier == "week1hw") {
            let vc = segue.destination as! TimeSampleVideo
            vc.archiveFlag = 1
            
        }
        else if (segue.identifier == "week2hw") {
            let vc = segue.destination as! SpecialTime
            vc.archiveFlag = 1
            
        }
        else if (segue.identifier == "week3hw") {
            let vc = segue.destination as! IndependentPlayVideo
            vc.archiveFlag = 1
            
        }
        else if (segue.identifier == "week4hw") {
            let vc = segue.destination as! ComplianceTraining
            vc.archiveFlag = 1
            
        }
        else if (segue.identifier == "week5hw") {
            let vc = segue.destination as! DailyGoalRecordingVideo
            vc.archiveFlag = 1
            
        }
        else if (segue.identifier == "week6hw") {
            let vc = segue.destination as! SchoolHomeGoalRecording
            vc.archiveFlag = 1
            
        }
        else if (segue.identifier == "week7hw") {
            let vc = segue.destination as! TrophyBoardData
            vc.archiveFlag = 1
            
        }
        else if (segue.identifier == "week8hw") {
            let vc = segue.destination as! LongTermGoalData
            vc.archiveFlag = 1
            
        }
        
    }
    @IBAction func dailyHomework(_ sender: UIButton) {
        if reqWeek == "Week1"{
            performSegue(withIdentifier: "week1hw", sender: self)
        }
        else if reqWeek == "Week2"{
            performSegue(withIdentifier: "week2hw", sender: self)
        }
        else if reqWeek == "Week3"{
            performSegue(withIdentifier: "week3hw", sender: self)
        }
        else if reqWeek == "Week4"{
            performSegue(withIdentifier: "week4hw", sender: self)
        }
        else if reqWeek == "Week5"{
            performSegue(withIdentifier: "week5hw", sender: self)
        }
        else if reqWeek == "Week6"{
            performSegue(withIdentifier: "week6hw", sender: self)
        }
        else if reqWeek == "Week7"{
            performSegue(withIdentifier: "week7hw", sender: self)
        }
        else if reqWeek == "Week8"{
            performSegue(withIdentifier: "week8hw", sender: self)
        }
    }
    
    @IBAction func dailyPractice(_ sender: UIButton) {
        if reqWeek == "Week1"{
            performSegue(withIdentifier: "week1Practice", sender: self)
        }
        else if reqWeek == "Week2"{
            performSegue(withIdentifier: "week2Practice", sender: self)
        }
        else if reqWeek == "Week3"{
            performSegue(withIdentifier: "week3Practice", sender: self)
        }
        else if reqWeek == "Week4"{
            performSegue(withIdentifier: "week4Practice", sender: self)
        }
        else if reqWeek == "Week5"{
            performSegue(withIdentifier: "week5Practice", sender: self)
        }
        else if reqWeek == "Week6"{
            performSegue(withIdentifier: "week6Practice", sender: self)
        }
        else if reqWeek == "Week7"{
            performSegue(withIdentifier: "week7Practice", sender: self)
        }
        else if reqWeek == "Week8"{
            performSegue(withIdentifier: "week8Practice", sender: self)
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
