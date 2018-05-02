//
//  PracticeADHD.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/22/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import DLRadioButton

class PracticeADHD: UIViewController {

    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var trueButton: DLRadioButton!
    @IBOutlet weak var falseButton: DLRadioButton!
    var questionArray =  [String]()
    var answerArray =  [Int]()
    var answerText = [String]()
    var questionNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        questionArray = ["ADHD can be caused by poor parenting practices.", "ADHD can often be caused by sugar or food additives.","Children with ADHD are born with biological vulnerabilities toward inattention and poor self-control.","A child can be appropriately labeled as having ADHD and not necessarily present as over-active.","Children with ADHD need a quiet, sterile environment in order to concentrate on tasks.","Children with ADHD misbehave primarily because they don’t want to follow rules and complete assignments.","The inattention of children with ADHD is not primarily a consequence of defiance, oppositionality, and an unwillingness to please others.", "ADHD is a medical disorder that can only be treated with medication.","Children with ADHD could do better if they only would try harder.","Most children with ADHD outgrow their disorder and are normal as adults.","ADHD can be inherited.","ADHD occurs equally as often in girls as in boys.","ADHD occurs more in minority groups than in Caucasian groups.","If medication is prescribed, educational interventions are often unnecessary.","If a child can get excellent grades one day and awful grades the next, then they must not have ADHD.","Diets are usually not helpful in treating most children with ADHD.","If a child can play Nintendo for hours, he probably does not have ADHD.","Children with ADHD have a higher risk for becoming delinquent as teenagers, compared to their peers.","Children with ADHD typically are better behaved in 1-to-1 interactions than in a group situation.","ADHD often results from a chaotic, dysfunctional family life."]
        answerArray = [0,0,1,1,1,0,1,0,0,0,1,0,0,0,0,1,0,1,1,0]
        answerText = ["False.ADHD is a biological condition and is not caused by poor parenting. The parent is powerful in helping manage their child’s behavior.", "False.This has been disproven in scientific studies. Removing food additives or sugar has not been shown to reduce symptoms of hyperactivity or improve attention. ","True.ADHD is a neurobiological disorder. Parts of the brain may be affected, leading to problems with behavioral inhibition.","True. Older versions of our diagnostic system included ADD and ADHD. Currently, they are combined under the heading of “ADHD” as three subtypes: Inattentive 2) Overactive or 3) Combined Thus, a child may only demonstrate inattentive symptoms and still qualify for a diagnosis of ADHD.","As in the school setting, teachers try to ensure children with ADHD are seated near the teacher or have dividers to minimize distractions. This helps the child remain focused on their work.","False. ADHD is a disorder of performance, not ability. They may know how to complete a task and have high motivation to do so. Yet, children with ADHD often have difficulty consistently performing a task. Distractors and impulsivity can get in the way of doing behaviors they have been taught.","True. Children with ADHD typically want to please or follow directions. They have biological difficulties rather than motivational difficulties. reatment can help improve your child’s compliance.", "False. Behavioral parent training is a well-supported treatment that maintains gains due to the skillset obtained during treatment. When medication is used alone, symptoms often return after it is discontinued.", "False. ADHD is a disorder of performance, not ability. Behavioral parent training will show you skills to help your child build new habits and perform more consistently.", "False. As ADHD is a biological disorder, it is lifelong; however, people often learn strategies to manage their ADHD. Behavioral parent training will help teach and refine such skills.","True. Not everyone with ADHD will pass this on to their child. However, there is a greater chance of attentional deficits if an immediate family member has ADHD.","False. ADHD is diagnosed five times more often in boys than girls during childhood. However, boys tend to be referred for diagnosis due to hyperactive behaviors. ADHD is often missed in girls if they do not display hyperactive behaviors.","False. The occurrence of ADHD is about equal across all ethnic groups.","False. Medication may not be enough to promote change in an academic setting. Other options, such as behavioral classroom strategies or a 504 plan may help your child to be successful. These strategies can help both your child’s behavior in the classroom as well as their academic performance.","False. We all have our good days and bad days, and many variables can affect performance.","True. While healthy eating “sets the stage” for anyone to perform at their best, research shows that specific dietary changes or restrictions do not improve the hyperactive and inattentive symptoms of ADHD.","False. Children with ADHD tend to have higher need for excitement and novelty than their peers. This is why a child with ADHC can “hyper-focus” on exciting content like video games. Yet, may struggle to maintain focus on a more boring activity such as homework assignments.","True. Impulsivity increases the risk for adolescent delinquency. However, research has shown that those who receive treatment for their ADHD do not have higher rates of juvenile delinquency.","True. Children often enjoy the attention they get from others in group settings. They may misbehave to get more attention.","False. While a chaotic family life can exacerbate symptoms, it is not the cause. Behavioral parent training can provide strategies to make life less chaotic for the entire family."]
        questionText.text = questionArray[0]
        // Do any additional setup after loading the view.
    }
    @IBAction func trueSelected(_ sender: DLRadioButton) {
        if answerArray[questionNumber] == 0{
            let alert = UIAlertController(title: "Wrong", message: answerText[questionNumber], preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next Question", style: .default, handler: { action in
                switch action.style{
                    
                case .default:
                    if(self.questionNumber < self.questionArray.count-1){
                    self.questionNumber = self.questionNumber + 1
                    self.questionText.text = self.questionArray[self.questionNumber]
                    self.trueButton.isSelected = false
                    self.falseButton.isSelected = false
                    }
                    else{
                       self.questionText.text = "End of Practice Session."
                        self.buttonStack.isHidden = true
                    }
                case .cancel:
                    print("Do nothing")
                case .destructive:
                    print("Do nothing")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else if answerArray[questionNumber] == 1{
            let alert = UIAlertController(title: "Correct", message: answerText[questionNumber], preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next Question", style: .default, handler: { action in
                switch action.style{
                    
                case .default:
                    if(self.questionNumber < self.questionArray.count-1){
                    self.questionNumber = self.questionNumber + 1
                    self.questionText.text = self.questionArray[self.questionNumber]
                        self.trueButton.isSelected = false
                        self.falseButton.isSelected = false
                    }
                    else{
                      self.questionText.text = "End of Practice Session."
                        self.buttonStack.isHidden = true
                    }
                case .cancel:
                    print("Do nothing")
                case .destructive:
                    print("Do nothing")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func flaseSelected(_ sender: DLRadioButton) {
        if answerArray[questionNumber] == 0{
            let alert = UIAlertController(title: "Correct", message: answerText[questionNumber], preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next Question", style: .default, handler: { action in
                switch action.style{

                case .default:
                    if(self.questionNumber < self.questionArray.count-1){
                    self.questionNumber = self.questionNumber + 1
                    self.questionText.text = self.questionArray[self.questionNumber]
                        self.trueButton.isSelected = false
                        self.falseButton.isSelected = false
                    }
                    else{
                        self.questionText.text = "End of Practice Session."
                        self.buttonStack.isHidden = true
                    }
                case .cancel:
                    print("Do nothing")
                case .destructive:
                    print("Do nothing")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else if answerArray[questionNumber] == 1{
            let alert = UIAlertController(title: "Wrong", message: answerText[questionNumber], preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next Question", style: .default, handler: { action in
                switch action.style{
                    
                case .default:
                    if(self.questionNumber < self.questionArray.count-1){
                    self.questionNumber = self.questionNumber + 1
                    self.questionText.text = self.questionArray[self.questionNumber]
                        self.trueButton.isSelected = false
                        self.falseButton.isSelected = false
                    }
                    else{
                       self.questionText.text = "End of Practice Session."
                        self.buttonStack.isHidden = true
                    }
                case .cancel:
                    print("Do nothing")
                case .destructive:
                    print("Do nothing")
                }
            }))
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
