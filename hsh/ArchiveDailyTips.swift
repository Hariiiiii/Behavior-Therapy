//
//  ArchiveDailyTips.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/2/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import Firebase

class ArchiveDailyTips: UIViewController {

    var ref : DatabaseReference!
    var reqWeek : String!
    @IBOutlet weak var tip1: UILabel!
    @IBOutlet weak var tip2: UILabel!
    @IBOutlet weak var tip3: UILabel!
    @IBOutlet weak var tip4: UILabel!
    @IBOutlet weak var tip5: UILabel!
    @IBOutlet weak var tip6: UILabel!
    @IBOutlet weak var tip7: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tip1.numberOfLines = 0
        //tip1.adjustsFontSizeToFitWidth = true
        tip1.textAlignment = .center
        
        tip2.numberOfLines = 0
        //tip2.adjustsFontSizeToFitWidth = true
        tip2.textAlignment = .center
    
        tip3.numberOfLines = 0
        //tip3.adjustsFontSizeToFitWidth = true
        tip3.textAlignment = .center
        
        tip4.numberOfLines = 0
        //tip4.adjustsFontSizeToFitWidth = true
        tip4.textAlignment = .center
        
        tip5.numberOfLines = 0
        //tip5.adjustsFontSizeToFitWidth = true
        tip5.textAlignment = .center
        
        tip6.numberOfLines = 0
        //tip6.adjustsFontSizeToFitWidth = true
        tip6.textAlignment = .center
        
        tip7.numberOfLines = 0
       // tip7.adjustsFontSizeToFitWidth = true
        tip7.textAlignment = .center

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        ref?.child("DailyTip").child(reqWeek).observe(.value, with: { (snapshot) in
            if let data = snapshot.value as?[String : String] {
                
                self.tip1.attributedText = self.getAttributedString(tipnum: "Tip 1:", data: data["Tip1"]!)
                self.tip2.attributedText = self.getAttributedString(tipnum: "Tip 2:", data: data["Tip2"]!)
                self.tip3.attributedText = self.getAttributedString(tipnum: "Tip 3:", data: data["Tip3"]!)
                self.tip4.attributedText = self.getAttributedString(tipnum: "Tip 4:", data: data["Tip4"]!)
                self.tip5.attributedText = self.getAttributedString(tipnum: "Tip 5:", data: data["Tip5"]!)
                self.tip6.attributedText = self.getAttributedString(tipnum: "Tip 6:", data: data["Tip6"]!)
                self.tip7.attributedText = self.getAttributedString(tipnum: "Tip 7:", data: data["Tip7"]!)
            }
            else{
                print("didnt go through")
            }
            
            
        })
    }
    
    func getAttributedString(tipnum : String, data : String) -> NSMutableAttributedString{
        let boldText  = tipnum
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = data
        let normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        return attributedString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
