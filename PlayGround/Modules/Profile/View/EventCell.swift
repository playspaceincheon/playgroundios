//
//  EventCell.swift
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
import FontAwesome_swift


final class EventCell: UICollectionViewCell {
    
    static let ID = "EventCell"
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        return image
    }()
    
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

extension EventCell {
    
    func prepareViews(bounds:CGRect) {
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(desLabel)
        
        imageView.snp.makeConstraints{ m in
            m.top.equalToSuperview()
            m.left.right.equalToSuperview()
            m.height.equalTo(357)
        }
        
        titleLabel.snp.makeConstraints{ m in
            m.top.equalTo(imageView.snp.bottom).offset(32)
            m.centerX.equalToSuperview()
        }
        
        desLabel.snp.makeConstraints{ m in
            m.top.equalTo(titleLabel.snp.bottom).offset(8)
            m.left.equalToSuperview().offset(16)
            m.right.equalToSuperview().offset(-16)
            m.centerX.equalToSuperview()
        }
    }
}
