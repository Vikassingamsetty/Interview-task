//
//  SideMenuListTVCell.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit

class SideMenuListTVCell: UITableViewCell {

    class var identifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
