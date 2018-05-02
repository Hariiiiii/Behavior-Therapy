//
//  ComplianceTraining.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit

class ComplianceTraining: UIViewController {
    @IBOutlet weak var content: UITextView!
    var archiveFlag:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        let contentText = "The goal for this week is to get in the habit of giving effective commands, and get your child in the habit of following them.Your child needs frequent, repeated opportunities to earn your praise for completing instructions.Praise makes it more likely that your child will want to do these instructions!.To give your child a chance to practice, we encourage you to engage in a “compliance trial” each day.Select a 15-20-minute interval each day, and deliver up to five clear, simple (single-step) instructions.For these practice times, select easy commands they are likely to follow, so that there is a greater likelihood you will be able to praise them.Good example commands for compliance trials might include.• Please hand me the remote.• Alex, I dropped my pen. Please hand me the pen.• Amy, I need you to flip on the fan.• Remember to praise as soon as your child starts moving to complete the task, and again when they complete the task"
        var alignedContent = contentText.replacingOccurrences(of: ".", with: "\n")
        alignedContent = alignedContent.replacingOccurrences(of: ":", with: "\n \n")
        content.text = alignedContent
        content.sizeToFit()
        content.isScrollEnabled = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "complainceData") {
            let vc = segue.destination as! ComplianceTrainingLog
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
