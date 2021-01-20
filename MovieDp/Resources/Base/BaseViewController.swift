//
//  BaseViewController.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import NVActivityIndicatorView
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    private var activityIndicatorView: NVActivityIndicatorView?
    private var viewLoadingContainer: UIView?
    var disposeBag = DisposeBag()

    func showDefaultLoader(backgroundColor: UIColor = UIColor.darkGray.withAlphaComponent(0.5)) {
        let barHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44
        if activityIndicatorView == nil {
            activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .circleStrokeSpin, color: .blue, padding: 0)
        }

        var center = CGPoint()
        if let frame = navigationController?.view.bounds {
            viewLoadingContainer = UIView(frame: frame)
            viewLoadingContainer?.frame.origin.y = barHeight
            center = (navigationController?.view.center)!
        } else if UIApplication.shared.windows.filter({$0.isKeyWindow}).first != nil {
            viewLoadingContainer = self.view.window
            viewLoadingContainer?.frame.origin.y = barHeight
        }
        center.y -= barHeight
        activityIndicatorView?.center = center
        viewLoadingContainer?.backgroundColor = backgroundColor
        activityIndicatorView?.startAnimating()
        viewLoadingContainer?.addSubview(activityIndicatorView!)

        view.addSubview(viewLoadingContainer!)
    }

    func hideDefaultLoader() {
        if let activity = activityIndicatorView {
            activity.removeFromSuperview()
            activity.stopAnimating()
        }

        if let loadingContainer = viewLoadingContainer {
            loadingContainer.removeFromSuperview()
        }
    }
}
