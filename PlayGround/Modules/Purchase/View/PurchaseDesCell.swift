//
//  PurchaseDesCell.swift
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


final class PurchaseDesCell: UICollectionViewCell {
    
    static let ID = "PurchaseDesCell"
    
    
    
    lazy var titleLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 12, textColor: DetailTitleTextColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var desLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 12, textColor: DetailDesTextColor, textAlign: .right)
        return uiLabel
        
    }()
    
    
    
    lazy var underLineDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = BBGrey3Color
        return divider
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
        
    }
}

extension PurchaseDesCell {
    
    func prepareViews(bounds:CGRect) {
        
        addSubview(self.titleLabel)
        addSubview(self.desLabel)
        addSubview(self.underLineDivider)
        
        
        self.titleLabel.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(16)
            m.left.equalToSuperview().offset(24)
        }
        
        self.desLabel.snp.makeConstraints{ m in
            m.centerX.top.equalToSuperview().offset(16)
            m.right.equalToSuperview().offset(-15)
        }
        
        self.underLineDivider.snp.makeConstraints{ m in
            m.height.equalTo(1)
            m.width.equalTo(self.width - 32)
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        underLineDivider.isHidden = true
    }
}
