//
//  MovieCell.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var MovieDescLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    static let identifier = "MovieCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
