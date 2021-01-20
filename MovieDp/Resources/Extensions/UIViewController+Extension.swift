//
//  UIViewController+Extension.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

extension UIViewController {
    func showErrorMessage(title: String, message: String, customAction: UIAlertAction? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let action = customAction {
            alert.addAction(action)
        } else {
            let action = UIAlertAction(title: "OK", style: .cancel, handler: handler)
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
