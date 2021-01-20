//
//  AppDelegate+Setup.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import Foundation
import os.log
import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

extension AppDelegate {
    /**
     Set up the depedency graph in the DI container
     */
    internal func setupDependencies() {

        // viewModel
        container.autoregister(MoviesViewModel.self, initializer: MoviesViewModel.init)

        // view controllers
        container.storyboardInitCompleted(MovieListViewController.self) { r, c in
            c.viewModel = r.resolve(MoviesViewModel.self)
        }
    }
    
    internal func startEntryPoint() {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "Root") as? UINavigationController
        
        let vc = container.resolveViewController(MovieListViewController.self)
        navigationController?.viewControllers = [vc]
        window?.rootViewController = navigationController
    }
}
