//
//  PostItemTableViewCell.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/21/23.
//

import UIKit

class PostItemTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!

    func setPost(post: Post) {
        titleLabel.text = post.title
        dateLabel.text = post.publishedAt.format(dateFormat: "MMMM dd, yyyy")
        bodyLabel.text = post.body.maxLength(length: 100)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
