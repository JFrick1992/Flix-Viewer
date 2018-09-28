//
//  MovieCell.swift
//  Flix-Viewer
//
//  Created by Jacob Frick on 9/14/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        overviewLabel.preferredMaxLayoutWidth = overviewLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        overviewLabel.preferredMaxLayoutWidth = overviewLabel.frame.size.width


    }

}
