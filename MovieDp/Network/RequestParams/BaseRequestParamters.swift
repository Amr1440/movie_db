//
//  BaseRequestParamters.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

class BaseRequestParamters: RequestParamters {
    let KeysFileName = "keys"

    var api_key = ""

    private enum CodingKeys: String, CodingKey {
        case api_key = "api_key"
    }

    init() {
        let filePath = Bundle.main.path(forResource: KeysFileName, ofType: "plist")

        // Put the keys in a dictionary
        let plist = NSDictionary(contentsOfFile: filePath!)

        // Pull the value for the key
        api_key = plist?.object(forKey: CodingKeys.api_key.rawValue) as! String
    }
}
