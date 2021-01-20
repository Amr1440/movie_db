//
//  ReachabilityHandler.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

class ReachabilityHandler: ReachabilityObserverDelegate {
    var isFirstNotifiactionFired = false

    required init() {
        addReachabilityObserver()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    // MARK: Reachability
    
    func reachabilityChanged(_ isReachable: Bool) {
        // Skip first notifaction as we don't need it
        if !isFirstNotifiactionFired {
            isFirstNotifiactionFired = true
            return
        }
        
        if !isReachable {
            if Configurations.connectionStatus != .disconnected {
                Configurations.connectionStatus = .disconnected
            }
        } else {
            if Configurations.connectionStatus != .connected {
                Configurations.connectionStatus = .connected
            }
        }
    }
}
