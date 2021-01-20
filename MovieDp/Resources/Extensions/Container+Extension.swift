//
//  Container+Extension.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import Foundation

import Swinject
import SwinjectStoryboard

extension Container {
    /**
     Retrieves UIViewController of the specified type. The UIViewController must conform to StoryboardLodable

     - Parameter serviceType: UIViewController type
     - Returns: UIViewController of specified type
     */
    func resolveViewController<ViewController: StoryboardLodable>(_ serviceType: ViewController.Type) -> ViewController {
        let sb = SwinjectStoryboard.create(name: serviceType.storyboardName, bundle: nil, container: self)
        let name = "\(serviceType)" // "\(serviceType)".replacingOccurrences(of: "ViewController", with: "")
        return sb.instantiateViewController(withIdentifier: name) as! ViewController
    }
}
