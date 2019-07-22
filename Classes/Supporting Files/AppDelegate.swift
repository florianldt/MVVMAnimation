//
//  AppDelegate.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/11/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ImplementationListViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

