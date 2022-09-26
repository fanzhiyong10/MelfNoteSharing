//
//  AppDelegate.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/25.
//

import UIKit
import GoogleSignIn

let signInConfig = GIDConfiguration(clientID: "1097635885854-cedui2lbqbkq89rjog3fssc1093js71k.apps.googleusercontent.com")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }

        // Handle other custom URL types.
        
        // If not handled by this app, return false.
        return false
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
                print("Show the app's signed-out state.")
            } else {
                // Show the app's signed-in state.
                print("Show the app's signed-in state.")
            }
        }
        
        // 串行队列：同步执行
        let queueOfInitiateDatabase = DispatchQueue(label: "www.yuejingling.queueOfInitiateDatabase")
        
        // 移动、创建数据库
        queueOfInitiateDatabase.sync {
            DatabaseSpecification.moveDatabase()
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

