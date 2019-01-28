//
//  PolicyViewController.swift
//  SewerConquer
//
//  Created by Marko Splajt on 15/10/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import UIKit

class PolicyViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func privacyPolicy(_ sender: UIButton)
    {
        UIApplication.shared.open(URL(string: "https://sewerconquer.wixsite.com/privacypolicy")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func cookiePolicy(_ sender: UIButton)
    {
        UIApplication.shared.open(URL(string: "https://sewerconquer.wixsite.com/privacypolicy/cookie-policy")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func termsAndConditions(_ sender: UIButton)
     {
     UIApplication.shared.open(URL(string: "https://sewerconquer.wixsite.com/privacypolicy/terms-and-conditions")! as URL, options: [:], completionHandler: nil)
     }
     
     @IBAction func credits(_ sender: UIButton)
     {
     UIApplication.shared.open(URL(string: "https://sewerconquer.wixsite.com/privacypolicy/credits")! as URL, options: [:], completionHandler: nil)
     }
    
     @IBAction func closePopUp(_ sender: UIButton)
     {
     dismiss(animated: true, completion: nil)
     }
}
