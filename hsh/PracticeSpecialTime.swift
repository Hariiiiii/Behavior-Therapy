//
//  PracticeSpecialTime.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/22/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import SVProgressHUD
import AVKit

class PracticeSpecialTime: UIViewController {
    var url = URL(string: "")
    @IBOutlet weak var videoThumbView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        playButton.isHidden = true
        videoThumbView.layer.cornerRadius = 10
        videoThumbView.clipsToBounds = true
        DispatchQueue.global(qos: .background).async {
            SVProgressHUD.show(withStatus: "Loading Please wait")
            let videoThumb = self.getThumbnailImage(forUrl: self.url!)
            
            DispatchQueue.main.async {
                self.videoThumbView.image = videoThumb
                self.playButton.isHidden = false
                SVProgressHUD.dismiss()
            }
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
    @IBAction func submitButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Answers", message: "First Mistake"+"\n"+"First, our parent asked the child a question by saying, “What are you building there?” Instead, the parent could narrate what the child is doing with their hands, “I see you putting the blue block on the very top!” Another option is for the parent to make a “guess” that doesn’t take the lead away from the child. For example, the parent might say, “it looks like you are building a tower!” The child may correct the parent saying, “no, I’m building a castle.” In either instance, by the parent refraining from questions, the child remains in the lead of creating the play."+"\n \n"+"Second Mistake"+"\n"+"In the next mistake, the parent praised their child through the use of non-specific praise by saying, “you’re doing great!” While this statement is encouraging, praising specific behaviors you like (e.g., planning, working hard, sticking with it) during play will make it more likely that your child engages in those behaviors outside of play."+"\n \n"+"Third Mistake"+"\n"+"The last pitfall involves criticism. The parent criticized the child’s play by saying, “that doesn’t really look like a crown,” and “I wish you played like this all of the time.” For Special Time to be effective, your child should feel like they have a positive spotlight of attention on their good behaviors. The more you shine this spotlight during play, the more you will observe good behaviors outside of play", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
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
