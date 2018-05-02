//
//  SchoolHomeGoalRecording.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit

class SchoolHomeGoalRecording: UIViewController {

    @IBOutlet weak var instructions: UITextView!
    var archiveFlag:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        let contentText = " For this week’s assignment, we’d like you to consider setting a meeting with your child’s teacher to select a school behavior goal. It may be useful to choose the same goal behavior as you are using at home for this first week. Thus, ‘showing you are paying attention’ may be a good school goal for this week. If you are ready to begin monitoring a school goal, remember to:o    •Define the goal for the teacher and ask them to only rate this behavior.• Ask them to provide lots of praise for this goal throughout the day.• Discuss a plan for getting the teacher’s ratings. You may use the School Goals Recording Form print-out (placed in your child’s backpack) or another method that works for you and the teacher (e.g., email rating for each day)."
        var alignedContent = contentText.replacingOccurrences(of: ".", with: "\n")
        alignedContent = alignedContent.replacingOccurrences(of: ":", with: "\n \n")
        instructions.text = alignedContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "schoolHomeData") {
            let vc = segue.destination as! SchoolHomeGoalRecordingData
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
