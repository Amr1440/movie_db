//
//  AppDelegate.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit
import Swinject
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    internal let container = Container()
    var reachabilityHandler: ReachabilityHandler?

    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        reachabilityHandler = ReachabilityHandler()
        setupDependencies()
        startEntryPoint()
        return true
    }
}

