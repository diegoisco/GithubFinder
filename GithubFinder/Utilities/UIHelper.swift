//
//  UIHelper.swift
//  GithubFinder
//
//  Created by Diego Oruna on 6/08/20.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(in view:UIView) -> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = .init(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
        
    }
    
}
