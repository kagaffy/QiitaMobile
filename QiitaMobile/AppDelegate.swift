//
//  AppDelegate.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//  Copyright © 2020 Tsukada Yoshiki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = QiitaTabBarController()
        window?.makeKeyAndVisible()

        return true
    }
}
