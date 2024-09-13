//
//  FeedTableViewCell.swift
//  InstagramCloneFirebase
//
//  Created by Eren Küpeli on 13.09.2024.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButton(_ sender: Any) {
        
    }
    
}
