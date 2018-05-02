//
//  Questions.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 3/2/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit

class Questions: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var segueFromController : String!
    
    override var   supportedInterfaceOrientations : UIInterfaceOrientationMask{
        
        return  .portrait
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        yesButton.isHidden = true
        noButton.isHidden = true
        
        let textBorderColor = UIColor.black
        questionText.layer.borderColor = textBorderColor.cgColor
        questionText.layer.borderWidth = 1.0
        
        questionText.layer.cornerRadius = 10
        questionText.clipsToBounds = true
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.clipsToBounds = true
        
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
        
        noButton.layer.cornerRadius = 10
        noButton.clipsToBounds = true
        
        yesButton.layer.cornerRadius = 10
        yesButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            let textBackgroundColor = UIColor.red
            questionText.layer.backgroundColor = textBackgroundColor.cgColor
            questionText.text = "ARE YOU SURE YOU WOULD LIKE TO CANCEL QUESTION SUBMISSION. ALL DATA WILL BE LOST IF YOU PROCEED"
            yesButton.isHidden = false
            noButton.isHidden = false
            cancelButton.isHidden = true
            submitButton.isHidden = true
        }
        else if sender.tag == 4 {
           /* if (segueFromController == "ViewController") {
                performSegue(withIdentifier: "unwindSegueToMain", sender: self)
            }
            else if (segueFromController == "DailyHomework") {
                performSegue(withIdentifier: "unwindSegueToDaily", sender: self)
            } */
        
            questionText.text = ""
            cancelButton.isHidden = false
            submitButton.isHidden = false
        }
        else if sender.tag == 3 {

            let textBackgroundColor = UIColor.white
            questionText.layer.backgroundColor = textBackgroundColor.cgColor
            yesButton.isHidden = true
            noButton.isHidden = true
            cancelButton.isHidden = false
            submitButton.isHidden = false
        }
        else if sender.tag == 2 {
            //yet to check where info goes
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
