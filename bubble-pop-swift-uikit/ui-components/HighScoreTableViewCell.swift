//
//  HighScoreTableViewCell.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 24/4/21.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
