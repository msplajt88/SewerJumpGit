//
//  AppDelegate.swift
//  SkyConquer
//
//  Created by Marko Splajt on 05/04/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import UIKit
import CoreData
//import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        //self.splashScreen()
        
        //GADMobileAds.configure(withApplicationID: "ca-app-pub-7711507841405386/5078896743")
        
        // test: ca-app-pub-3940256099942544/1712485313
        
        // real:  ca-app-pub-7711507841405386/5078896743
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        //vc = storyboard.instantiateInitialViewController()!
        
        if (UserDefaults.standard.value(forKey: "name") as? String) == nil
        {
            vc = storyboard.instantiateViewController(withIdentifier: "TermsViewController")
        }
        else
        {
            vc = storyboard.instantiateInitialViewController()!
        }
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()

        return true
    }
    
    /*private func splashScreen()
    {
        let launchScreenVC = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        let rootVC = launchScreenVC.instantiateViewController(withIdentifier: "splashController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(dismissSplashController), userInfo: nil, repeats: false)
    }
    
    @objc func dismissSplashController()
    {
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
        let rootVC = mainVC.instantiateViewController(withIdentifier: "ViewController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }*/
    
    lazy var persistentContainer: NSPersistentContainer =
        {
        let container = NSPersistentContainer(name: "TotalScore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError?
            {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do
            {
                try context.save()
            }
            catch
            {
                let err = error as NSError
                fatalError("Unresolved error \(err), \(err.userInfo)")
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

