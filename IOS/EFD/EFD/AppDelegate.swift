//
//  AppDelegate.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: ConnexionViewController())
        window.makeKeyAndVisible()
        self.window = window
        
        
        return true
    }


}

