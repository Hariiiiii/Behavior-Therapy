//
//  PracticeTrophyBoard.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/22/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import DLRadioButton

class PracticeTrophyBoard: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        performSegue(withIdentifier: "practice2Trophy", sender: self)
    }
    @IBAction func selectedButton(_ sender: DLRadioButton) {
        let alert = UIAlertController(title: "Answer" ,message: "The best answer is A. This do-over offers a way to make up for the mistake by helping the person he harmed. Answer B does not offer a chance to make up for the mistake. Answer C provides a do-over that is too severe.  Do-overs should be able to be completed immediately after Quiet Time so that your child can get back to earning your positive attention.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Next Question", style: .default, handler: nil))
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
