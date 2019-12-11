//
//  PurchaseTitleCell.swift
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


final class PurchaseTitleCell: UICollectionViewCell {
    
    static let ID = "PurchaseTitleCell"
        
    lazy var titleLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 18, textColor: DetailTitleTextColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var desLabel: UILabel = {
         
         let uiLabel = setLabel(title: "", size: 16, textColor: DetailDesTextColor, textAlign: .right)
         return uiLabel
         
     }()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
        
    }
}

extension PurchaseTitleCell {
    
    func prepareViews(bounds:CGRect) {
        
        addSubview(self.titleLabel)
        addSubview(self.desLabel)
        
        
        self.titleLabel.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(16)
            m.left.equalToSuperview().offset(15)
        }
        
       self.desLabel.snp.makeConstraints{ m in
           m.centerX.top.equalToSuperview().offset(16)
           m.right.equalToSuperview().offset(-15)
       }
           
        desLabel.isHidden = true
    }
}
