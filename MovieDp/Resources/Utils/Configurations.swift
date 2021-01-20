//
//  Configurations.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

enum ProjectMode: String {
    case development
    case stage
    case production
}

enum ConnectionStatus: String {
    case connected
    case disconnected
}

class Configurations: NSObject {
    // Configurations
    static var mode: ProjectMode = .development
    static var connectionStatus: ConnectionStatus = .connected
    
    static var BaseUrl: URL {
        if Configurations.mode == .development {
            return URL(string: "https://api.themoviedb.org/3/")!
        } else if Configurations.mode == .production {
            return URL(string: "https://api.themoviedb.org/3/")!
        } else {
            return URL(string: "https://api.themoviedb.org/3/")!
        }
    }
    
    static var ImagesUrl = "https://image.tmdb.org/t/p/w500"
}
