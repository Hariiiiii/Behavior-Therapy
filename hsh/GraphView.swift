//
//  GraphView.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/1/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import HamsterUIKit
import Firebase
import FirebaseDatabase

class GraphView: UIViewController, HamsBarChartDelegate, HamsBarChartDataSource {
    
   
    @IBOutlet weak var pageTitle: UINavigationItem!
    //Chart Functions
    func barChart(_ barChart: HamsBarChart, barForChart indexPath: HamsIndexPath) -> HamsBarChartRect {
        let rect = HamsBarChartRect()
        rect.value = .plain(dataSets[indexPath.column])
        rect.color = .plain(.darkGray)
        return rect
    }
    
    func numberOfCharts(in barChart: HamsBarChart) -> Int {
        return 1
    }
    
    func barChart(_ barChart: HamsBarChart, numberOfValuesInChart chart: Int) -> Int {
        return dataSets.count
    }
    
    
    var ref : DatabaseReference!
    var week : String!
    var user_email : String!
    var graph_data : [String : Int]!
    var graph_num : Int!
    
    //Chart Variables
    var barChart:HamsBarChart = HamsBarChart()
    var dataSets = [CGFloat]()
    let blue = UIColor(hue: 216/360, saturation: 38/100, brightness: 83/100, alpha: 1)
    
    
    
    @IBOutlet weak var graphScrollView: UIScrollView!
    
    override var   supportedInterfaceOrientations : UIInterfaceOrientationMask{
        
        return  .landscape
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("week",week,"email",user_email)
        ref = Database.database().reference()
        ref?.child("Scores").child(week).child(user_email).observe(.value, with: { (snapshot) in
            print(snapshot.value!)
            if let data = snapshot.value as?[String : Int] {
                self.graph_data = data
                print("graph number",self.graph_num)
                print("went through")
                if self.graph_num == 1 {
                    self.pageTitle.title = "Attention and Activity"
                self.dataSets.append(CGFloat(self.graph_data["managing_attention"]!))
                self.dataSets.append(CGFloat(self.graph_data["managing_activity"]!))
                }
                else if self.graph_num == 2 {
                    self.pageTitle.title = "Peer Relationship and Affect Regulation"
                    self.dataSets.append(CGFloat(self.graph_data["peer_relationship"]!))
                    self.dataSets.append(CGFloat(self.graph_data["affect_modulation"]!))
                }
                else if self.graph_num == 3 {
                    print("parental stress",self.graph_data["parental_stress"]!)
                    self.pageTitle.title = "Parental Stress"
                    self.dataSets.append(CGFloat(self.graph_data["parental_stress"]!))
                    self.dataSets.append(0.0)
                }
                else if self.graph_num == 4 {
                    self.pageTitle.title = "Parental Implementation and Alliance"
                    self.dataSets.append(CGFloat(self.graph_data["implementation_strategy"]!))
                    self.dataSets.append(CGFloat(self.graph_data["parental_alliance"]!))
                }
                else if self.graph_num == 5 { //yet to change
                    self.pageTitle.title = "Attention and Avtivity"
                    self.dataSets.append(CGFloat(self.graph_data["managing_attention"]!))
                    self.dataSets.append(CGFloat(self.graph_data["implementation_strategy"]!))
                }
                // dataSets = [CGFloat(Double(self.graph_data["managing_attention"]!)),CGFloat(Double(self.graph_data["implementation_strategy"]!))]
                self.barChart.reloadData()
            }
            else{
                print("didnt go through")
            }
            
            
        })
       
        
        //set chart view
        barChart = HamsBarChart(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        
        barChart.delegate = self
        barChart.dataSource = self
        graphScrollView.addSubview(barChart)
        //barChart.filledStyle = .plain(blue)
        
        
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func barChart(_ barChart: HamsBarChart, configureForCharts view: Int) {
        
        //barChart.title = "BarChart(plain)"
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
