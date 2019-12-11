//
//  PurchaseCardCell.swift
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


final class PurchaseCardCell: UICollectionViewCell {
    
    static let ID = "PurchaseCardCell"
    
    
    lazy var titleLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 16, textColor: DetailTitleTextColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var desLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 12, textColor: DetailTitleTextColor, textAlign: .right)
        return uiLabel
        
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)

    }
}

extension PurchaseCardCell {
    
    func prepareViews(bounds:CGRect) {
    
        let uiView = UIView()
        uiView.backgroundColor = UIColor(hexString:"#F0F0F0")?.withAlphaComponent(0.6)
        uiView.layer.cornerRadius = 12
        
        addSubview(uiView)
        uiView.addSubview(self.titleLabel)
        uiView.addSubview(self.desLabel)
        
        
        self.titleLabel.snp.makeConstraints{ m in
            m.centerY.equalToSuperview()
            m.left.equalToSuperview().offset(16)
        }
        
        self.desLabel.snp.makeConstraints{ m in
            m.centerY.equalToSuperview()
            m.right.equalToSuperview().offset(-16)
        }
        
        uiView.snp.makeConstraints{ m in
            m.centerX.centerY.equalToSuperview()
            m.width.equalTo(self.width - 32)
            m.top.bottom.equalToSuperview()
        }
    
    }
}
