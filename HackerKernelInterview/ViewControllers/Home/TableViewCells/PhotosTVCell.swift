//
//  PhotosTVCell.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit
import SDWebImage

class PhotosTVCell: UITableViewCell {

    class var identifier: String {
        return "\(self)"
    }
    
    class var nib: UINib {
        return UINib(nibName: PhotosTVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var mainView: CardViewss!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        userImage.layer.cornerRadius = 20
        userImage.contentMode = .scaleAspectFit
        userImage.layer.masksToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig(_ model: PhotosModel) {
        
        let url = URLComponents(string: model.url)
        userImage.sd_setImage(with: url?.url, placeholderImage: UIImage(systemName: ""))
        userTitle.text = model.title
    }
    
}
