//
//  WeeklyLesson.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 3/18/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import WebKit
import AVKit
import SVProgressHUD

extension UIViewController {
    func toastMessage(_ message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            UIView.animate(withDuration: 1, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
            }
        }
    }}

class WeeklyLesson: UIViewController {

    @IBOutlet weak var scrollContent: UIScrollView!
    @IBOutlet weak var textContent: UILabel!
    @IBOutlet weak var lessonTitle: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var videoThumbView: UIImageView!
    @IBOutlet var mainView: UIView!
    var ref : DatabaseReference!
    var noOfitems : Int!
    var incrementVariable : Int!
    var contentType : String = ""
    var currentWeek : String!
    var weekData : [String : String]!
    var archiveFlag : Int!
    var archiveWeek : String!
    
    override var   supportedInterfaceOrientations : UIInterfaceOrientationMask{
        
        return  .portrait
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textContent.numberOfLines = 0
        textContent.adjustsFontSizeToFitWidth = true
        textContent.textAlignment = .center
        
        videoThumbView.layer.cornerRadius = 10
        videoThumbView.clipsToBounds = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        if archiveFlag != 1 {
        ref?.child("CurrentWeek").observe(.value, with: { (snapshot) in
            if let snap = snapshot.value as? String{
                self.currentWeek = snap
                print("current week", self.currentWeek!)
                self.initializeData(currentWeek : self.currentWeek!)
            }
            else{
                print("else")
                self.currentWeek = snapshot.value! as! String
                print("current week", self.currentWeek!)
            }
        })
        }
            
        else {
            self.initializeData(currentWeek: self.archiveWeek!)
            print("came inside",self.archiveWeek!)
        }
        //print("current week outside", self.currentWeek!)
      /*  ref?.child("Sessions").child(self.currentWeek!).observe(.value, with: { (snapshot) in
            if let data = snapshot.value as?[String : String] {
                //self.weekDataArray = Array(data)
                self.weekData = data
                self.textContent.text = self.weekData["1"]!
                self.noOfitems = self.weekData.count - 1
                self.incrementVariable = 1
            }
            else{
                print("didnt go through")
            }
            
            
        }) */
    }
    
    func initializeData(currentWeek : String){
        if currentWeek == "Week1"{
            self.title = "ADHD Education"
        }
        else if currentWeek == "Week2"{
            self.title = "Special Time"
        }
        else if currentWeek == "Week3"{
            self.title = "Differential Attention and Independent Play"
        }
        else if currentWeek == "Week4"{
            self.title = "Effective Commands"
        }
        else if currentWeek == "Week5"{
            self.title = "Goal Setting"
        }
        else if currentWeek == "Week6"{
            self.title = "School Collaboration"
        }
        else if currentWeek == "Week7"{
            self.title = "Trophy Board and Time Out"
        }
        else if currentWeek == "Week8"{
            self.title = "Problem Prevention and Ending Therapy"
        }
        ref?.child("Sessions").child(currentWeek).observe(.value, with: { (snapshot) in
            if let data = snapshot.value as?[String : String] {
                //self.weekDataArray = Array(data)
                self.weekData = data
                //self.textContent.text = self.weekData["1"]!
                self.contentCheck(incrementVariable: 1)
                self.noOfitems = self.weekData.count - 1
                self.incrementVariable = 1
            }
            else{
                print("didnt go through")
            }
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 3 {
            incrementVariable = incrementVariable - 1
            if incrementVariable == 0 {
            //dismiss(animated: true, completion: nil)
                toastMessage("Reached Lesson Beginning")
            }
            else{
                if incrementVariable > 0 {
                contentCheck(incrementVariable: incrementVariable)
                }
            }
        }
        else if sender.tag == 4 {
            if incrementVariable < noOfitems {
            incrementVariable = incrementVariable + 1
            contentCheck(incrementVariable: incrementVariable)
            }
        }
        
            //Play Video
        else if sender.tag == 5 {
            if incrementVariable == 1 && contentType == "video" {
                 let videoURL = NSURL(string: weekData["1"]!)
                 let player = AVPlayer(url: videoURL! as URL)
                let playerViewController = AVPlayerViewController()
                 playerViewController.player = player
                 self.present(playerViewController, animated: true) {
                 playerViewController.player!.play()
                 }
            }
            
            else if incrementVariable == 2 && contentType == "video" {
                let videoURL = NSURL(string: weekData["2"]!)
                let player = AVPlayer(url: videoURL! as URL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
            
            else if incrementVariable == 3 && contentType == "video" {
                let videoURL = NSURL(string: weekData["3"]!)
                let player = AVPlayer(url: videoURL! as URL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
            
            else if incrementVariable == 4 && contentType == "video" {
                let videoURL = NSURL(string: weekData["4"]!)
                let player = AVPlayer(url: videoURL! as URL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
            
            else if incrementVariable == 5 && contentType == "video" {
                let videoURL = NSURL(string: weekData["5"]!)
                let player = AVPlayer(url: videoURL! as URL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
            
            else if incrementVariable == 6 && contentType == "video" {
                let videoURL = NSURL(string: weekData["6"]!)
                let player = AVPlayer(url: videoURL! as URL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
            else if incrementVariable == 7 && contentType == "video" {
                let videoURL = NSURL(string: weekData["7"]!)
                let player = AVPlayer(url: videoURL! as URL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
            }
        }
    }
    func contentVisibility(contentType : String){
        if contentType == "text" {
            videoThumbView.isHidden = true
            playButton.isHidden = true
            textContent.isHidden = false
        }
        
        else if contentType == "video" {
            videoThumbView.isHidden = false
            playButton.isHidden = false
            textContent.isHidden = true
        }
    }
    
    func callAsyncTask(url : URL){
        videoThumbView.isHidden = true
        DispatchQueue.global(qos: .background).async {
            SVProgressHUD.show(withStatus: "Loading Please wait")
            let videoThumb = self.getThumbnailImage(forUrl: url)
            
            DispatchQueue.main.async {
                self.videoThumbView.image = videoThumb
                self.videoThumbView.isHidden = false
                SVProgressHUD.dismiss()
            }
        }
    }
    func contentCheck(incrementVariable : Int){
        if incrementVariable == 1 {
            if (weekData["1"]?.hasPrefix("http"))!{
                print(weekData["1"]!)
                contentType = "video"
                contentVisibility(contentType: contentType)
                print("Its a video")
                
                //Get thumbnail for video
                let url = URL(string: weekData["1"]!)
                
                callAsyncTask(url: url!)
                
            }
            else{
                print(weekData["1"]!)
                contentType = "text"
                contentVisibility(contentType: contentType)
                var linebreakString = weekData["1"]!.replacingOccurrences(of: ".", with: ".\n")
                linebreakString = linebreakString.replacingOccurrences(of: ":", with: "\n")
                textContent.text = linebreakString
                textContent.textAlignment = .left
                print("just text")
                
            }
        }
        if incrementVariable == 2 {
            if (weekData["2"]?.hasPrefix("http"))!{
                print(weekData["2"]!)
                contentType = "video"
                contentVisibility(contentType: contentType)
                print("Its a video")

                //Get thumbnail for video
                let url = URL(string: weekData["2"]!)
                
                callAsyncTask(url: url!)
            }
            else{
                print(self.weekData["2"]!)
                contentType = "text"
                contentVisibility(contentType: contentType)
                var linebreakString = weekData["2"]!.replacingOccurrences(of: ".", with: ".\n")
                linebreakString = linebreakString.replacingOccurrences(of: ":", with: "\n")
                textContent.text = linebreakString
                textContent.textAlignment = .left
                print("just text")
            }
        }
        if incrementVariable == 3 {
            if (weekData["3"]?.hasPrefix("http"))!{
                print(weekData["3"]!)
                contentType = "video"
                contentVisibility(contentType: contentType)
                print("Its a video")
                
                 //Get thumbnail for video
                let url = URL(string: weekData["3"]!)
                
                callAsyncTask(url: url!)
            }
            else{
                print(weekData["3"]!)
                contentType = "text"
                contentVisibility(contentType: contentType)
                var linebreakString = weekData["3"]!.replacingOccurrences(of: ".", with: ".\n")
                linebreakString = linebreakString.replacingOccurrences(of: ":", with: "\n")
                textContent.text = linebreakString
                textContent.textAlignment = .left
                print("just text")
            }
        }
        if incrementVariable == 4 {
            if (weekData["4"]?.hasPrefix("http"))!{
                print(weekData["4"]!)
                contentType = "video"
                contentVisibility(contentType: contentType)
                print("Its a video")
                
                //Get thumbnail for video
                let url = URL(string: weekData["4"]!)
                
                callAsyncTask(url: url!)
            }
            else{
                print(weekData["4"]!)
                contentType = "text"
                contentVisibility(contentType: contentType)
                var linebreakString = weekData["4"]!.replacingOccurrences(of: ".", with: ".\n")
                linebreakString = linebreakString.replacingOccurrences(of: ":", with: "\n")
                textContent.text = linebreakString
                textContent.textAlignment = .left
                print("just text")
            }
        }
        if incrementVariable == 5 {
            if (weekData["5"]?.hasPrefix("http"))!{
                print(weekData["5"]!)
                contentType = "video"
                contentVisibility(contentType: contentType)
                print("Its a video")
                
                //Get thumbnail for video
                let url = URL(string: weekData["5"]!)
                
                callAsyncTask(url: url!)
            }
            else{
                print(weekData["5"]!)
                contentType = "text"
                contentVisibility(contentType: contentType)
                var linebreakString = weekData["5"]!.replacingOccurrences(of: ".", with: ".\n")
                linebreakString = linebreakString.replacingOccurrences(of: ":", with: "\n")
                textContent.text = linebreakString
                textContent.textAlignment = .left
                print("just text")
            }
        }
        if incrementVariable == 6 {
            if (weekData["6"]?.hasPrefix("http"))!{
                print(weekData["6"]!)
                contentType = "video"
                contentVisibility(contentType: contentType)
                print("Its a video")
                
                //Get thumbnail for video
                let url = URL(string: weekData["6"]!)
                
                callAsyncTask(url: url!)
            }
            else{
                print(weekData["6"]!)
                contentType = "text"
                contentVisibility(contentType: contentType)
                var linebreakString = weekData["6"]!.replacingOccurrences(of: ".", with: ".\n")
                linebreakString = linebreakString.replacingOccurrences(of: ":", with: "\n")
                textContent.text = linebreakString
                textContent.textAlignment = .left
                print("just text")
            }
        }
        if incrementVariable == 7 {
            if (weekData["7"]?.hasPrefix("http"))!{
                print(weekData["7"]!)
                contentType = "video"
                contentVisibility(contentType: contentType)
                print("Its a video")
                
                //Get thumbnail for video
                let url = URL(string: weekData["7"]!)
                
                callAsyncTask(url: url!)
            }
            else{
                print(weekData["7"]!)
                contentType = "text"
                contentVisibility(contentType: contentType)
                var linebreakString = weekData["7"]!.replacingOccurrences(of: ".", with: ".\n")
                linebreakString = linebreakString.replacingOccurrences(of: ":", with: "\n")
                textContent.text = linebreakString
                textContent.textAlignment = .left
                print("just text")
            }
        }
    }
    
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                
                incrementVariable = incrementVariable - 1
                if incrementVariable == 0 {
                    toastMessage("Reached Lesson Beginnning")
                }
                else{
                    if incrementVariable > 0 {
                        contentCheck(incrementVariable: incrementVariable)
                    }
                }
                
                
                
            case UISwipeGestureRecognizerDirection.left:
                
                if incrementVariable < noOfitems {
                    incrementVariable = incrementVariable + 1
                    contentCheck(incrementVariable: incrementVariable)
                }
                else if incrementVariable == noOfitems {
                    if currentWeek == "Week1"{
                    performSegue(withIdentifier: "practice1", sender: self)
                    }
                    else if currentWeek == "Week2"{
                        performSegue(withIdentifier: "practice2", sender: self)
                    }
                    else if currentWeek == "Week3"{
                        performSegue(withIdentifier: "practice3", sender: self)
                    }
                    else if currentWeek == "Week4"{
                        performSegue(withIdentifier: "practice4", sender: self)
                    }
                    else if currentWeek == "Week5"{
                        performSegue(withIdentifier: "practice5", sender: self)
                    }
                    else if currentWeek == "Week6"{
                        performSegue(withIdentifier: "practice6", sender: self)
                    }
                    else if currentWeek == "Week7"{
                        performSegue(withIdentifier: "practice7", sender: self)
                    }
                    else if currentWeek == "Week7"{
                        performSegue(withIdentifier: "practice8", sender: self)
                    }
                }
                
                
            default:
                break
            }
        }
    }

}
