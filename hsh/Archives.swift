//
//  Archives.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/2/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit

class Archives: UIViewController {
    var currentWeek : String!
    var weekRequested : String!
    var currentWeekNum : Int!
    var weekRequestedNum : Int!

    @IBOutlet weak var week1Button: UIButton!
    @IBOutlet weak var week2Button: UIButton!
    @IBOutlet weak var week3Button: UIButton!
    @IBOutlet weak var week4Button: UIButton!
    @IBOutlet weak var week5Button: UIButton!
    @IBOutlet weak var week6Button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.currentWeekNum = Int(String(currentWeek.last!))
        week1Button.layer.cornerRadius = 10
        week1Button.clipsToBounds = true
        
        week2Button.layer.cornerRadius = 10
        week2Button.clipsToBounds = true
        
        week3Button.layer.cornerRadius = 10
        week3Button.clipsToBounds = true
        
        week3Button.layer.cornerRadius = 10
        week3Button.clipsToBounds = true
        
        week4Button.layer.cornerRadius = 10
        week4Button.clipsToBounds = true
        
        week5Button.layer.cornerRadius = 10
        week5Button.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func week1ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week1"
        toWeeklyArchive(week: weekRequested)
    }
    
    @IBAction func week2ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week2"
        toWeeklyArchive(week: weekRequested)
    }
    @IBAction func week3ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week3"
        toWeeklyArchive(week: weekRequested)
    }
    @IBAction func week4ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week4"
        toWeeklyArchive(week: weekRequested)
    }
    @IBAction func week5ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week5"
        toWeeklyArchive(week: weekRequested)
    }
    @IBAction func week6ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week6"
        toWeeklyArchive(week: weekRequested)
    }
    @IBAction func week7ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week7"
        toWeeklyArchive(week: weekRequested)
    }
    @IBAction func week8ArchiveButton(_ sender: UIButton) {
        weekRequested = "Week8"
        toWeeklyArchive(week: weekRequested)
    }
    
    func toWeeklyArchive(week : String){
        weekRequestedNum = Int(String(weekRequested.last!))
        if currentWeekNum >= weekRequestedNum {
            performSegue(withIdentifier: "archiveToWeeklyArchive", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Message", message: "Requested Week Content is not available yet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "archiveToWeeklyArchive") {
            let vc = segue.destination as! WeeklyArchives
            vc.requestedWeek = weekRequestedNum
        }
    }
}
