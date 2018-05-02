//
//  PracticeTrophyBoardVideo.swift
//  hsh
//
//  Created by Harinarayanan Janardhanan on 4/22/18.
//  Copyright © 2018 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import AVKit
import SVProgressHUD

class PracticeTrophyBoardVideo: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var videoThumbView: UIImageView!
    var url = URL(string: "")
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
