//
//  AppDelegate.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var currentInstallation: PFInstallation = PFInstallation.currentInstallation()
        
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackground()
        
        println("did register with remote notificaiotns")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: NSDictionary!) {
        var notification: NSDictionary = userInfo.objectForKey("walkMessage") as NSDictionary
        println(notification)

        NSNotificationCenter.defaultCenter().postNotificationName("ShowImage", object: notification)
        
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.BlackOpaque, animated: true)
        
        Parse.setApplicationId("kX8MUMIOmxBYpRgBE1hzd3joaqG0rcoupL3VcIzG", clientKey: "DODt0WE0Ug6UmKpsWIDQLZFenM30ALblWomSumtO")
        
        var notificationType: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        var settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationType, categories: nil)

        UIApplication.sharedApplication().registerUserNotificationSettings(settings)

        /*
        var object = PFObject(className: "TestClass")
        object.addObject("Banana", forKey: "favoriteFood")
        object.addObject("Chocolate", forKey: "favoriteIceCream")
        object.saveInBackground()
        */
        
        FBLoginView.self
        FBProfilePictureView.self

        //PFUser.enableAutomaticUser()
        
        //var defaultACL = PFACL()
        // If you would like all objects to be private by default, remove this line.
        //defaultACL.setPublicReadAccess(true)
        //PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
        /*
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound|UIUserNotificationType.Alert|UIUserNotificationType.Badge, categories: nil))
        
        */
        
        BITHockeyManager.sharedHockeyManager().configureWithIdentifier("d8ff03c11ca340083ce9ce7dc884d5ec")
        BITHockeyManager.sharedHockeyManager().startManager()
        BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation()

        return true
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: NSString?, annotation: AnyObject) -> Bool {
        
        var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        return wasHandled
        
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
        /*
        var app = UIApplication.sharedApplication()
        var notification: UILocalNotification = UILocalNotification()
        var alarmDate = NSDate().dateByAddingTimeInterval(5.0)
        notification.alertBody = "Jim Picked up Spike!"
        notification.fireDate = alarmDate
        app.scheduleLocalNotification(notification)
*/

    }


    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

