//
//  StoryboardLodable.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import Foundation
import UIKit

protocol StoryboardLodable: AnyObject {
    @nonobjc static var storyboardName: String { get }
}

protocol MovieStoryboardLodable: StoryboardLodable {}

extension MovieStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return "Movie"
    }
}
