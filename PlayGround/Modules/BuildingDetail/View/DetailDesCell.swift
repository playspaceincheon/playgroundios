//
//  DetailDesCell.swift
//  PlayGround
//
//  Created by kim jason on 04/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import Material
import SnapKit
import UIKit
import Localize_Swift
import FontAwesome_swift


final class DetailDesCell: UICollectionViewCell {
    
    static let ID = "DetailDesCell"

    lazy var titleLabel: UILabel = {
        let uiLabel = setLabel(title: "", size: 16, textColor: BBBlackColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var desLabel: UILabel = {
        let uiLabel = setLabel(title: "", size: 12, textColor: DetailDesTextColor, textAlign: .left, numberOfLines: 10)
        return uiLabel
    }()
    

    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
    }
    
}

extension DetailDesCell {
    
    func prepareViews(bounds:CGRect) {
        self.addSubview(titleLabel)
        self.addSubview(desLabel)
        
        titleLabel.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(12)
            m.left.equalToSuperview().offset(32)
        }
        
        desLabel.snp.makeConstraints{ m in
            m.left.equalToSuperview().offset(32)
            m.top.equalTo(titleLabel.snp.bottom).offset(8)
            m.bottom.equalToSuperview().offset(-16)
            m.right.equalToSuperview().offset(-32)
        }
    }
}
