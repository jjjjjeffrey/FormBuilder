//
//  AppDelegate.swift
//  FormBuilder
//
//  Created by zengdaqian on 2018/6/27.
//  Copyright © 2018年 zengdaqian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? {
        didSet {
            window?.backgroundColor = .white
        }
    }
    var master: UITabBarController!
    var secondary: SecondaryViewController = SecondaryViewController.instance()
    var secondaryNVCs: [String: FBNavigationController] = [:]


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let tb = window?.rootViewController as? UITabBarController {
            tb.viewControllers?.forEach({ (vc) in
                if let sp = vc as? UISplitViewController {
                    sp.delegate = self
                    sp.preferredDisplayMode = .allVisible
                }
            })
            master = tb
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


}

extension AppDelegate: UISplitViewControllerDelegate {
    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        return splitViewController.viewControllers[0]
    }
    
    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        return splitViewController.viewControllers[0]
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if secondaryViewController is SecondaryViewController {
            return true
        } else {
            let nvc = splitViewController.primaryViewController as! FBNavigationController
            if let secondaryNvc = secondaryViewController as? FBNavigationController {
                let index = master.viewControllers?.index(of: splitViewController)
                secondaryNVCs["\(index!)"] = secondaryNvc
                var vcs = nvc.viewControllers
                vcs.append(contentsOf: secondaryNvc.viewControllers)
                nvc.setViewControllers(vcs, animated: true)
            } else {
                nvc.pushViewController(secondaryViewController, animated: true)
            }
            return true
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        if let nvc = primaryViewController as? UINavigationController, nvc.viewControllers.count > 1 {
            let details: [UIViewController] = Array(nvc.viewControllers.dropFirst())
            let index = master.viewControllers?.index(of: splitViewController)
            let secondNvc = secondaryNVCs["\(index!)"]
            secondNvc?.viewControllers = details
            nvc.viewControllers = [nvc.viewControllers[0]]
            return secondNvc
        } else {
            return secondary
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        
        let detailViewController: UIViewController
        if let navigation = vc as? FBNavigationController {
            if let object = sender as? NSObject {
                navigation.sender = object
            }
            let index = master.viewControllers?.index(of: splitViewController)
            secondaryNVCs["\(index!)"] = navigation
            detailViewController = navigation.topViewController!
        } else {
            detailViewController = vc
        }
        if splitViewController.isCollapsed {
            let premaryNVC = splitViewController.primaryViewController as! UINavigationController
            
            detailViewController.hidesBottomBarWhenPushed = true
            premaryNVC.pushViewController(detailViewController, animated: true)
            return true
        } else {
            if let secondaryNVC = splitViewController.secondaryViewController as? FBNavigationController {
                if let object = sender as? NSObject, secondaryNVC.sender === object {
                    secondaryNVC.popToRootViewController(animated: true)
                } else {
                    secondaryNVC.pushViewController(detailViewController, animated: true)
                }
                return true
            } else {
                if let secondaryNVC = vc as? FBNavigationController, let object = sender as? NSObject {
                    secondaryNVC.sender = object
                }
                splitViewController.viewControllers[1] = vc
                return true
            }
        }
        
    }
}

extension UISplitViewController {
    var primaryViewController: UIViewController? {
        get {
            if viewControllers.count > 0 {
                return viewControllers[0]
            } else {
                return nil
            }
        }
    }
    
    var secondaryViewController: UIViewController? {
        get {
            if viewControllers.count > 1 {
                return viewControllers[1]
            } else {
                return nil
            }
        }
    }
}

