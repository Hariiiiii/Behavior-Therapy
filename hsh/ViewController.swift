//
//  ViewController.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 2/22/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var ref : DatabaseReference!
    var currentWeek : String!
    
    @IBOutlet weak var pageTitle: UINavigationItem!
    override var   supportedInterfaceOrientations : UIInterfaceOrientationMask{
        
        return  .portrait
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.title = "Home"
        // Do any additional setup after loading the view, typically from a nib.
        
        //Button Layout and Content positioning "need to reuse code to make it effecient"
        
       
        
        titleLabel.layer.cornerRadius = 10
        titleLabel.layer.masksToBounds = true
        
        button1.layer.cornerRadius = 10
        button1.clipsToBounds = true
        
        button1.titleLabel?.lineBreakMode = .byWordWrapping
        button1.titleLabel?.textAlignment = .center
        button1.titleLabel?.adjustsFontSizeToFitWidth = true
        button1.titleLabel?.numberOfLines = 3
        button1.setTitle("DAILY HOMEWORK ACTIVITY", for: .normal)
        
        button2.layer.cornerRadius = 10
        button2.clipsToBounds = true
        
        button2.titleLabel?.lineBreakMode = .byWordWrapping
        button2.titleLabel?.textAlignment = .center
        button2.titleLabel?.adjustsFontSizeToFitWidth = true
        button2.titleLabel?.numberOfLines = 2
        button2.setTitle("WEEKLY LESSON", for: .normal)
        
        button3.layer.cornerRadius = 10
        button3.clipsToBounds = true
        
        button3.titleLabel?.lineBreakMode = .byWordWrapping
        button3.titleLabel?.textAlignment = .center
        button3.titleLabel?.adjustsFontSizeToFitWidth = true
        button3.titleLabel?.numberOfLines = 3
        button3.setTitle("WEELY GOAL- ATTAINMENT SCALE", for: .normal)
        
        button4.layer.cornerRadius = 10
        button4.clipsToBounds = true
        
        button4.titleLabel?.lineBreakMode = .byWordWrapping
        button4.titleLabel?.textAlignment = .center
        button4.titleLabel?.adjustsFontSizeToFitWidth = true
        button4.titleLabel?.numberOfLines = 2
        button4.setTitle("GRAPHING PROGRESS", for: .normal)
    
        button5.layer.cornerRadius = 10
        button5.clipsToBounds = true
        
        
        
        ref = Database.database().reference()
        ref?.child("CurrentWeek").observe(.value, with: { (snapshot) in
            if let snap = snapshot.value as? String{
                self.currentWeek = snap
                print("current week", self.currentWeek!)
    
            }
            else{
                print("else")
                self.currentWeek = snapshot.value! as! String
                print("current week", self.currentWeek!)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func animateButton(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
    
        
        if segue.destination is WeeklyGoal
        {
            let destinationToGO = segue.destination as? WeeklyGoal
            destinationToGO?.currentWeek = currentWeek
        }
        else if segue.destination is GraphProgress
        {
            let destinationToGO = segue.destination as? GraphProgress
            destinationToGO?.currentWeek = currentWeek
        }
        else if segue.destination is Archives
        {
            let destinationToGO = segue.destination as? Archives
            destinationToGO?.currentWeek = currentWeek
        }
       
    }
    
    @IBAction func logOff(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Alert", message: "Log Off?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
            let firebaseAuth = Auth.auth()
            do {
                try
                    firebaseAuth.signOut()
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                    self.present(vc, animated: false, completion: nil)
                }
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
        }
        let action2 = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func dailyHomework(_ sender: UIButton) {
        if currentWeek == "Week2" {
            performSegue(withIdentifier: "week2", sender: self)
        }
        else if currentWeek == "Week3" {
            performSegue(withIdentifier: "week3", sender: self)
        }
        else if currentWeek == "Week4" {
            performSegue(withIdentifier: "week4", sender: self)
        }
        else if currentWeek == "Week5" {
            performSegue(withIdentifier: "week5", sender: self)
        }
        else if currentWeek == "Week6" {
            performSegue(withIdentifier: "week6", sender: self)
        }
        else if currentWeek == "Week7" {
            performSegue(withIdentifier: "week7", sender: self)
        }
        else if currentWeek == "Week8" {
            performSegue(withIdentifier: "week8", sender: self)
        }
        else if currentWeek == "p" {
            performSegue(withIdentifier: "p2", sender: self)
        }
    }
    /* @IBAction func menuPage(_ sender: UIButton) {
        performSegue(withIdentifier: "menu", sender: self)
    }
    
    @IBAction func questionPage(_ sender: UIButton) {
        performSegue(withIdentifier: "question", sender: self)
    }
    
    @IBAction func dailyActivityPage(_ sender: UIButton) {
        performSegue(withIdentifier: "daily", sender: self)
    }
    
    @IBAction func weeklyLessonPage(_ sender: UIButton) {
        performSegue(withIdentifier: "weeklyLesson", sender: self)
    }
    @IBAction func weeklyGoalPage(_ sender: UIButton) {
        performSegue(withIdentifier: "weeklyGoal", sender: self)
    }
    @IBAction func unwindToMain(segue:UIStoryboardSegue) { } */
    
}

