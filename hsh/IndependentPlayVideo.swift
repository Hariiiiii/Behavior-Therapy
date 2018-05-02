//
//  IndependentPlayVideo.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/20/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import AVKit
import SVProgressHUD

class IndependentPlayVideo: UIViewController {

    @IBOutlet weak var videoThumbView: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var content: UITextView!
    var url = URL(string: "https://firebasestorage.googleapis.com/v0/b/project-schlitzmaltliqour.appspot.com/o/Differential%20Attention%20and%20Independent%20Play%2FV10_Intro-Role%20Play%20(Edited-zoom).mp4?alt=media&token=2f7d0e6e-fa4c-4b03-86b0-1b541c7fd0bd")
    var archiveFlag : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        playButton.isHidden = true
        videoThumbView.layer.cornerRadius = 10
        videoThumbView.clipsToBounds = true
        let contentText = "This week, we’d like your child to practice engaging in independent play activities.Select a 15- to 30-minute time of the day when you would like for your child to play on their own.Follow the steps outlined in the video and summarized here:• Start your child on a play activity.• Give an instruction and let your child know you will check on him/her.• Check in early (1-2 minutes from start) and praise your child.• Gradually increase the amount of time between check-ins.• Praise your child at each check in, specifically commenting on their ability to play on their own.• The next day (and subsequent days), increase the time for your first check-in by 2 minutes.• Gradually, over the week, you will want to achieve 30 minutes of uninterrupted play time for your child."
        var alignedContent = contentText.replacingOccurrences(of: ".", with: "\n")
        alignedContent = alignedContent.replacingOccurrences(of: ":", with: "\n \n")
        content.text = alignedContent
        //content.translatesAutoresizingMaskIntoConstraints = true
        
            content.sizeToFit()
        content.isScrollEnabled = false
        DispatchQueue.global(qos: .background).async {
            SVProgressHUD.show(withStatus: "Loading Please wait")
            let videoThumb = self.getThumbnailImage(forUrl: self.url!)
            
            DispatchQueue.main.async {
                self.videoThumbView.image = videoThumb
                self.playButton.isHidden = false
                SVProgressHUD.dismiss()
            }
        }
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "independentData") {
            let vc = segue.destination as! IndependentPlayData
            vc.archiveFlag = 1
        }
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        let videoURL = url
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
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
