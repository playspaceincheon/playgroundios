//
//  PurchaseImageCell.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import Material
import SnapKit
import UIKit
import Localize_Swift


final class PurchaseImageCell: UICollectionViewCell {
    
    static let ID = "PurchaseImageCell"
    
    lazy var buildingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = DetailImageBackgroundColor
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
     
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
        
    }
}

extension PurchaseImageCell {
    
    func prepareViews(bounds:CGRect) {
        addSubview(self.buildingImageView)

        self.buildingImageView.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(8)
            m.left.equalToSuperview().offset(16)
            m.right.equalToSuperview().offset(-16)
            m.height.equalTo(188)
            m.centerX.equalToSuperview()
        }
        
        buildingImageView.clipsToBounds = true
        buildingImageView.layer.cornerRadius = 3
        
    }
}
