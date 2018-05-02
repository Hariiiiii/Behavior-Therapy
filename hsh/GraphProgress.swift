//
//  GraphProgress.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/1/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import FirebaseAuth

class GraphProgress: UIViewController {
    
    //User info from firebase
    let user = Auth.auth().currentUser
    var user_email : String!
    var encodedUserEmail : String!
    var currentWeek : String!
    
    @IBOutlet weak var graph1Button: UIButton!
    @IBOutlet weak var graph2Button: UIButton!
    @IBOutlet weak var graph3Button: UIButton!
    
    @IBOutlet weak var graph4Button: UIButton!
    
    @IBOutlet weak var graph5Button: UIButton!
    override var   supportedInterfaceOrientations : UIInterfaceOrientationMask{
        
        return  .portrait
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "graph1ToView") {
            let vc = segue.destination as! GraphView
            vc.user_email = self.encodedUserEmail
            vc.week = currentWeek
            vc.graph_num = 1
        }
        else if (segue.identifier == "graph2ToView") {
            let vc = segue.destination as! GraphView
            vc.user_email = self.encodedUserEmail
            vc.week = currentWeek
            vc.graph_num = 2
        }
        else if (segue.identifier == "graph3ToView") {
            let vc = segue.destination as! GraphView
            vc.user_email = self.encodedUserEmail
            vc.week = currentWeek
            vc.graph_num = 3
        }
        else if (segue.identifier == "graph4ToView") {
            let vc = segue.destination as! GraphView
            vc.user_email = self.encodedUserEmail
            vc.week = currentWeek
            vc.graph_num = 4
        }
        else if (segue.identifier == "graph5ToView") {
            let vc = segue.destination as! GraphView
            vc.user_email = self.encodedUserEmail
            vc.week = currentWeek
            vc.graph_num = 5
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        graph1Button.layer.cornerRadius = 10
        graph1Button.clipsToBounds = true
        
        graph2Button.layer.cornerRadius = 10
        graph2Button.clipsToBounds = true
        
        graph3Button.layer.cornerRadius = 10
        graph3Button.clipsToBounds = true
        
        graph4Button.layer.cornerRadius = 10
        graph4Button.clipsToBounds = true
        
        graph5Button.layer.cornerRadius = 10
        graph5Button.clipsToBounds = true
        
        if let user = user {
            self.user_email = user.email!
        }
        self.encodedUserEmail = self.user_email.replacingOccurrences(of: ".", with: ",")
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
