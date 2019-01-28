//
//  GameViewController.swift
//  SkyConquer
//
//  Created by Marko Splajt on 05/04/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
//import GoogleMobileAds
import CoreData

//var rewardBasedAd: GADRewardBasedVideoAd!

class GameViewController: UIViewController
{
    var backingAudio = AVAudioPlayer()
    @IBOutlet var exitButton: UIButton!
    
    /*@IBAction func showAd(_ sender: UIButton) {
        rewardBasedAd.present(fromRootViewController: self)
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward)
    {
        totalScore += 10
        totalScoreLbl.text = "Total Score: \(totalScore)"
        defaults.set(totalScore, forKey: "totalScoreSaved")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd)
    {
        
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd)
    {
        rewardBasedAd = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedAd.delegate = self
        rewardBasedAd.load(GADRequest(), withAdUnitID: "ca-app-pub-7711507841405386/5078896743")
        
        let title: String = "Total score +10"
        let message = "Thank you for watching!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd)
    {
        
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd)
    {
        
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd)
    {
        
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error)
    {
        
    }*/
    
    @IBAction func exitButtonPressed(_ sender: UIButton)
    {
        backingAudio.stop()
        defaults.set(totalScore, forKey: "totalScoreSaved")
        //rewardBasedAd.present(fromRootViewController: self)
    }
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        definesPresentationContext = true
        
        //timesDeadLoadOnStart()
        
        /*rewardBasedAd = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedAd.delegate = self
        rewardBasedAd.load(GADRequest(), withAdUnitID: "ca-app-pub-7711507841405386/5078896743")*/
        
        // test: ca-app-pub-3940256099942544/1712485313
        
        // real:  ca-app-pub-7711507841405386/5078896743
        
        /*let requestAd: GADRequest = GADRequest()
        requestAd.testDevices = [kGADSimulatorID]*/
        
        /*bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())*/
        
        // test:  ca-app-pub-3940256099942544/6300978111
        
        // real:  ca-app-pub-7711507841405386/4784476216
        
        //bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        //self.view.addSubview(bannerView)

        //bannerView.load(requestAd)
                
        let filePath = Bundle.main.path(forResource: "backgroundSound", ofType: "mp3")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)
        
        do
        {
            backingAudio = try AVAudioPlayer(contentsOf: audioNSURL as URL)
        }
        catch
        {
            return print("Cannot Find The Audio")
        }
        
        backingAudio.numberOfLoops = -1
        backingAudio.volume = 2
        backingAudio.play()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.ignoresSiblingOrder = false
        skView.showsNodeCount = false
        skView.presentScene(scene)
        scene.scaleMode = .aspectFill
                
        if (UserDefaults.standard.value(forKey: "name") as? String) == nil
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let next = storyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
            addChildVC(viewController: next)
        }
        
    }
    
    override var shouldAutorotate: Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        } else
        {
            return .all
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    /*func timesDeadLoadOnStart()
     {
     if(!isLoadedTimesDead)
     {
     if UserDefaults.standard.object(forKey: "timesDead") == nil
     {
     defaults.set(timesDead, forKey: "timesDead")
     }
     
     currentTimesDead = defaults.object(forKey: "timesDead") as! Int
     
     isLoadedTimesDead = true
     }
     
     
     currentTimesDead -= 1
     if(currentTimesDead <= 0)
     {
     currentTimesDead = timesDead
     
     // Show ad
     
     if rewardBasedAd.isReady
     {
     rewardBasedAd.present(fromRootViewController: self)
     }
     }
     }*/
}

extension UIViewController {
    func addChildVC(viewController: UIViewController) {
        self.addChild(viewController)
        viewController.view.frame = self.view.frame
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}




