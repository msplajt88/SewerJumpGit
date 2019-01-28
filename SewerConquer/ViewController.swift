//
//  ViewController.swift
//  SewerConquer
//
//  Created by Marko Splajt on 30/09/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate, UITextFieldDelegate
{
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var nameOutlet: UILabel!
    @IBOutlet var gcButton: UIButton!
    @IBAction func gcAction(_ sender: UIButton)
    {
        saveTotalScore(number: totalScore)
        showLeaderboard()
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(reverse(text: "stressed"))
        
        authPlayer()
        definesPresentationContext = true
        nameTextField.delegate = self
        
        if let name = UserDefaults.standard.value(forKey: "name")
        {
        nameTextField.text = "\(name)"
        }
    }
    
    func reverse(text: String) -> String {
        return String(text.reversed())
    }
    
    @IBAction func nameTextChar(_ sender: UITextField)
    {
        maxLength(textFieldName: nameTextField, max: 15)
    }
    
    func maxLength(textFieldName: UITextField, max: Int)
    {
        let length = textFieldName.text?.count
        let char = textFieldName.text
        
        if (length! > max)
        {
            let index = char?.index((char?.startIndex)!, offsetBy: max)
            textFieldName.text = String((textFieldName.text?[..<index!])!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        nameTextField.resignFirstResponder()
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        
        return true
    }
    
    func authPlayer()
    {
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler =
            {
                (view, error) in
                
                if view != nil
                {
                    self.present(view!, animated: true, completion: nil)
                }
                else
                {
                    print(GKLocalPlayer.local.isAuthenticated)
                }
        }
    }
    
    func saveTotalScore( number : Int)
    {
        if GKLocalPlayer.local.isAuthenticated
        {
            let scoreReporter = GKScore(leaderboardIdentifier: "Sewer")
            
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
    
    func showLeaderboard()
    {
        let viewController = self
        let gcvc = GKGameCenterViewController()
        
        gcvc.gameCenterDelegate = self
        
        viewController.present(gcvc, animated: true, completion: nil)
    }
}
