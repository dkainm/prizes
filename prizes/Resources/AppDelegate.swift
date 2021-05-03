//
//  AppDelegate.swift
//  prizes
//
//  Created by Alex Rudoi on 2/5/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if UserDefaults.standard.bool(forKey: "launchedBefore") == false {
            DatabaseManager.instance.addPrize(Prize(name: "Chocolate Cake", price: 25))
            DatabaseManager.instance.addPrize(Prize(name: "Spotify subscription", price: 12))
            DatabaseManager.instance.addPrize(Prize(name: "Concert Ticket", price: 50))
            DatabaseManager.instance.addPrize(Prize(name: "Sale of 5% in Apple Stores", price: 20))
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

