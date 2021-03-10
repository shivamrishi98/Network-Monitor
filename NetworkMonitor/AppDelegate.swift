//
//  AppDelegate.swift
//  NetworkMonitor
//
//  Created by Shivam Rishi on 10/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
    }
}

