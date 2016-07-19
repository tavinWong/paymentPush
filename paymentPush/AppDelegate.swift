//
//  AppDelegate.swift
//  paymentPush
//
//  Created by tianyuwang on 6/28/16.
//  Copyright © 2016 tianyu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        registerForPushNotifications(application)
        /**
        // Actions
        let firstAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "FIRST_ACTION"
        firstAction.title = "Commit"
        firstAction.activationMode = .Foreground
        
        let secondAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SECOND_ACTION"
        secondAction.title = "Reject"
        secondAction.activationMode = .Foreground
        // category
        
        let firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "PAYMENT_CATEGORY"
        firstCategory.setActions([firstAction, secondAction], forContext: .Default)

        
        // NSSet of all our categories
        
        
        let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: [firstCategory])
        
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
 
        **/
        // Check if launched from notification
        // 1

        if let notification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [String: AnyObject] {
            // 2
            
            let aps = notification["aps"] as! [String: AnyObject]
            createNewPaymentItem(aps)
            // 3
            (window?.rootViewController as? UITabBarController)?.selectedIndex = 1
        }else{
            print("nothing in the launchoption")
        }

        
        return true
    }
    
    
    func application(application: UIApplication,
         handleActionWithIdentifier identifier:String?,
         forRemoteNotification userInfo: [NSObject : AnyObject],
         completionHandler: (() -> Void))
    {
        
        if (identifier == "FIRST_ACTION")
        {
            NSNotificationCenter.defaultCenter().postNotificationName("actionOnePressed", object: nil)
        }
        else if (identifier == "SECOND_ACTION")
        {
            NSNotificationCenter.defaultCenter().postNotificationName("actionTwoPressed", object: nil)
        }
        
        completionHandler()
    }
    
    //add new payment helper
    
    func createNewPaymentItem(notificationDictionary:[String: AnyObject]) -> PaymentItem? {
        let singlePayment = notificationDictionary["alert"] as! String
        print(singlePayment)
        let amount = Int(notificationDictionary["amount"] as! String)!
        print(amount)
        print(NSDate())
        let date = NSDate()
                let paymentItem = PaymentItem(title: singlePayment, date: date, amount: amount)
                let paymentStore = PaymentStore.sharedStore
                print("------before------")
                print(paymentStore)
                paymentStore.addItem(paymentItem)
                print("------after------")
                print(paymentStore)
                NSNotificationCenter.defaultCenter().postNotificationName(ViewController.RefreshPaymentFeedNotification, object: self)
                return paymentItem
    }
    
        
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        print("didRegisterUserNotificationSettingsokay")
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("didRegisterForRemoteNotificationsWithDeviceToken")
        print(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error.localizedDescription)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("received")
        let aps = userInfo["aps"] as! [String: AnyObject]
        print(aps)
        createNewPaymentItem(aps)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        print("didenterbackground")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        print("didbecomeactive")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func registerForPushNotifications(application: UIApplication) {
        
        let viewAction = UIMutableUserNotificationAction()
        viewAction.identifier = "VIEW_IDENTIFIER"
        viewAction.title = "View"
        viewAction.activationMode = .Foreground
        
        let paymentCategory = UIMutableUserNotificationCategory()
        paymentCategory.identifier = "PAYMENT_CATEGORY"
        paymentCategory.setActions([viewAction], forContext: .Default)
        
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Badge, .Sound, .Alert], categories: [paymentCategory])
        application.registerUserNotificationSettings(notificationSettings)
    }

}

