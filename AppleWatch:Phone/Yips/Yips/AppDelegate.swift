//
//  AppDelegate.swift
//  Yips
//
//  Created by Adam Infiesto on 3/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//  Icon rights reservered to Kubernetes clusters minus operational burdens

import UIKit
import WatchConnectivity
import WatchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
    
     //must haves for delegates
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    var window: UIWindow?
    //first to happen in life cycle in app
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if WCSession.isSupported()
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        } 
        
        return true
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
    
     //takes data and use NSnotification center to send data through app
    @objc func session(_ session: WCSession, didReceiveMessage message: [String : Any])
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushdata"), object: self, userInfo: message)
    }

    
}

//Class method for holding data did not work
//extension AppDelegate: WCSessionDelegate
//{
//    func sessionDidDeactivate(_ session: WCSession) {
//
//    }
//
//    func sessionDidBecomeInactive(_ session: WCSession) {
//
//    }
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//    }
//
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any])
//    {
//
//    }
////    func session(_ session: WCSession, didReceiveMessage message: [String : Any],replyHandler: @escaping ([String : Any]) -> Void)
////    {
////        //app can be turned on in background so we dont wanna block the main thread
////        DispatchQueue.main.async {
//////            if let sendingData = message["getData"] as? Int
//////            {
////////                let objData = UserDataObjects().objectArray[sendingData]
////////
////////                //class name and object that should be used to encode and decode
////////                NSKeyedArchiver.setClassName("UserDataManager", for: UserDataManager.self)
////////                //obj data that will be passed
////////                let actualObjects = NSKeyedArchiver.archivedData(withRootObject: objData)
////////                replyHandler(["userData" :  actualObjects])
//////
//////
//////            }
////
////
////        }
////        //    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
////        //
////        //        //app can be turned on in background so we dont wanna block the main thread
////        //        DispatchQueue.main.async {
////        //            if (message[""] as! Bool) != nil
////        //            {
////        //
////        //            }
////        //        }
////
////    }
//
//}
//
