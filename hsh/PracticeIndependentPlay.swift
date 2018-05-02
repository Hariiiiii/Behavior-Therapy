//
//  PracticeIndependentPlay.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/22/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit

class PracticeIndependentPlay: UIViewController {
    
    
    @IBOutlet weak var answerText: UITextView!
    
    @IBOutlet weak var instructions: UITextView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    var questionArray = [String]()
    var answerArray = [String]()
    var questionIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        questionArray=["What are some activities your child enjoys that they would likely be able to do independently? List a few ideas here.", "What are some activities you might like to accomplish during this time? List a few ideas here."]
        answerArray = ["• Watching a movie \n • Drawing a picture \n • Assembling a model \n • Playing videogames \n • Playing Leggos or Kinex \n • Completing a puzzle \n • Playing with a pet \n • Playing in the backyard \n • Building an 'indoor fort'", "• Preparing a meal \n • Housecleaning • Working on the computer \n • Talking on the phone \n • Reading the newspaper \n • Paying the bills \n • Reading a book/magazine \n • Talking to another adult \n • Attending to the child’s sibling"]
        questionText.text = questionArray[0]
        instructions.isScrollEnabled = false
    }
    @IBAction func submitButton(_ sender: UIButton) {
        var message = ""
        if(questionIndex == 0){
            message = "Example Child Activities to Use for Practice"
        }
        else if(questionIndex == 1){
            message = "Example Parent Activities to Use for Practice"
        }
        let alert = UIAlertController(title: message , message: answerArray[questionIndex], preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Next Question", style: .default, handler: { action in
            switch action.style{
                
            case .default:
                if(self.questionIndex < self.questionArray.count-1){
                    self.questionIndex = self.questionIndex + 1
                    self.questionText.text = self.questionArray[self.questionIndex]
                }
                else{
                    self.questionText.text = "End of Practice Session."
                    self.answerText.isHidden = true
                }
            case .cancel:
                print("Do nothing")
            case .destructive:
                print("Do nothing")
            }
        }))
        self.present(alert, animated: true, completion: nil)
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
