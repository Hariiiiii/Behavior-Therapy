//
//  TimeSampleVideo.swift
//  
//
//  Created by Harinarayanan Janardhanan on 4/17/18.
//

import UIKit
import AVKit
import SVProgressHUD

class TimeSampleVideo: UIViewController {


    @IBOutlet weak var videoThumbView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var playButton: UIButton!
    var url = URL(string: "https://firebasestorage.googleapis.com/v0/b/project-schlitzmaltliqour.appspot.com/o/V3_Time-Sample%20Homework.mp4?alt=media&token=a1f9fdb7-1e7c-410b-8378-f91952dead15")
    var segueFromController:String!
    var archiveFlag:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss Keyboard Tap gesture
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
     
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "time") {
            let vc = segue.destination as! TimeSampleData
            vc.archiveFlag = 1
        }
    }
    @IBAction func nextButton(_ sender: UIButton) {
        performSegue(withIdentifier: "time", sender: self)
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        let videoURL = url
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
