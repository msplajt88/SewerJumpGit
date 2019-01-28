//
//  TermsViewController.swift
//  SewerConquer
//
//  Created by Marko Splajt on 16/10/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UITextFieldDelegate
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        continueButtonOutlet.isEnabled = false
        nameText.delegate = self
    }
    
    @IBOutlet var continueButtonOutlet: UIButton!
    @IBOutlet var nameText: UITextField!
    
    @IBAction func continueTouched(_ sender: UIButton)
    {
        UserDefaults.standard.set(nameText.text, forKey: "name")
        performSegue(withIdentifier: "toMainSegue", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        continueButtonOutlet.isEnabled = true
        return true
    }
    
    @IBAction func nameChar(_ sender: UITextField)
    {
        maxLength(textFieldName: nameText, max: 15)
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
    
    @IBAction func termsAndConditions(_ sender: UIButton)
    {
        UIApplication.shared.open(URL(string: "https://sewerconquer.wixsite.com/privacypolicy/terms-and-conditions")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func privacyPolicy(_ sender: UIButton)
    {
        UIApplication.shared.open(URL(string: "https://sewerconquer.wixsite.com/privacypolicy")! as URL, options: [:], completionHandler: nil)
    }
}
