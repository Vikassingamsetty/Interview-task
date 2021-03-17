//
//  DashboardVC.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Dashboard"
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        
        topCollectionView.register(ArticleCVCell.nib, forCellWithReuseIdentifier: ArticleCVCell.id)
        bottomCollectionView.register(VideoCVCell.nib, forCellWithReuseIdentifier: VideoCVCell.id)
    }
    
}

//MARK:-  Collection view
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            
            if collectionView == topCollectionView {
                let headerView = topCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.id, for: indexPath) as! SectionHeader
                headerView.titleTxt.text = "Featured Articles"
                return headerView
            }else{
                let headerView = bottomCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.id, for: indexPath) as! SectionHeader
                headerView.titleTxt.text = "Featured Videos"
                return headerView
            }
            
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCVCell.id, for: indexPath) as! ArticleCVCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCVCell.id, for: indexPath) as! VideoCVCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == topCollectionView {
            let width = (collectionView.frame.width - (2 - 1) * 1) / 2  //220
            return CGSize(width: width, height: 310)
        }else{
            let width = (collectionView.frame.width - (1.5 - 1) * 10) / 1.5
            return CGSize(width: width, height: 172)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == topCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }else{
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
}

