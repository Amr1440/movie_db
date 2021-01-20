//
//  ReachabilityObserverDelegate.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import Foundation
import Reachability

// Reachability
// declare this property where it won't go out of scope relative to your listener
private var reachability: Reachability!

protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool)
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver()
    func removeReachabilityObserver()
}

// Declaring default implementation of adding/removing observer
extension ReachabilityObserverDelegate {
    /** Subscribe on reachability changing */
    func addReachabilityObserver() {
        reachability = try! Reachability()

        reachability.whenReachable = { [weak self] _ in
            self?.reachabilityChanged(true)
        }

        reachability.whenUnreachable = { [weak self] _ in
            self?.reachabilityChanged(false)
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    /** Unsubscribe */
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}
