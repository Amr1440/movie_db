//
//  CustomError.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import Foundation
import UIKit

class CustomError: Error {
    var code: String?
    var message: String?
    var title: String?

    init(code: String?, message: String?, title: String?) {
        self.code = code
        self.message = message
        self.title = title
    }

    init(code: String?, message: String?) {
        self.code = code
        self.message = message
        title = "Something went wrong"
    }

    static func getError(error: Error) -> CustomError {
        let weatherError = CustomError(code: error.code, message: error.message)
        if let newError = error as? CustomError {
            weatherError.message = newError.message
        }
        return weatherError
    }
}

extension Error {
    /**
     Error code
     */
    var code: String {
        return (self as? CustomError)?.code ?? ""
    }

    /**
     Error message
     */
    var message: String {
        return (self as? CustomError)?.message ?? localizedDescription
    }
}
