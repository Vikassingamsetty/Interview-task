//
//  ArticleCVCell.swift
//  HackerKernelInterview
//
//  Created by apple on 17/03/21.
//

import UIKit

class ArticleCVCell: UICollectionViewCell {

    // MARK: Variables
    static let id = "ArticleCVCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    @IBOutlet weak var mainView: CardViewss!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 12
        mainView.cornerRadius = 12
        mainImage.layer.cornerRadius = 12
        
        // Initialization code
    }

}
