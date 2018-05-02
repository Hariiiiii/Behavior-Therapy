//
//  ArchiveDailyHomework.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/2/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit

class ArchiveDailyHomework: UIViewController {
    @IBOutlet weak var day1Button: UIButton!
    @IBOutlet weak var day2Button: UIButton!
    @IBOutlet weak var day3Button: UIButton!
    @IBOutlet weak var day4Button: UIButton!
    @IBOutlet weak var day5Button: UIButton!
    @IBOutlet weak var day6Button: UIButton!
    @IBOutlet weak var day7Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        day1Button.layer.cornerRadius = 10
        day1Button.clipsToBounds = true
        
        day2Button.layer.cornerRadius = 10
        day2Button.clipsToBounds = true
        
        day3Button.layer.cornerRadius = 10
        day3Button.clipsToBounds = true
        
        day4Button.layer.cornerRadius = 10
        day4Button.clipsToBounds = true
        
        day5Button.layer.cornerRadius = 10
        day5Button.clipsToBounds = true
        
        day6Button.layer.cornerRadius = 10
        day6Button.clipsToBounds = true
        
        day7Button.layer.cornerRadius = 10
        day7Button.clipsToBounds = true
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
