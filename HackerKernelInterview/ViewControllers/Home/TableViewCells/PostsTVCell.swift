//
//  PostsTVCell.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit

class PostsTVCell: UITableViewCell {

    class var identifier: String {
        return "\(self)"
    }
    
    class var nib: UINib {
        return UINib(nibName: PostsTVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellPostsConfig(_ model: PostsModel) {
        
        titleLbl.text = model.title
        descriptionLbl.text = model.body
    }
    
}
