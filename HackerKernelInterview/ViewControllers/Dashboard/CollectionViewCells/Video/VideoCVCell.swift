//
//  VideoCVCell.swift
//  HackerKernelInterview
//
//  Created by apple on 17/03/21.
//

import UIKit

class VideoCVCell: UICollectionViewCell {

    // MARK: Variables
    static let id = "VideoCVCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    @IBOutlet weak var mainView: CardViewss!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var timeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.cornerRadius = 12
        mainImage.layer.cornerRadius = 12
        timeView.roundCorners(corners: [.topLeft,.bottomRight], radius: 12)
        // Initialization code
        
    }

}
