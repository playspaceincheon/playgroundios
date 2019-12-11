//
//  DetailItemCell.swift
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


final class DetailItemCell: UICollectionViewCell {
    
        static let ID = "DetailItemCell"
    
    lazy var itemImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = DetailImageBackgroundColor
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let uiLabel = setLabel(title: "", size: 16, textColor: BBBlackColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var desLabel: UILabel = {
        let uiLabel = setLabel(title: "", size: 16, textColor: DetailDesTextColor, textAlign: .left)
        return uiLabel
    }()
    
//    lazy var dateLabel: UILabel = {
//        let uiLabel = setLabel(title: "", size: 12, textColor: DetailDesTextColor, textAlign: .left)
//        return uiLabel
//    }()
    
    
    lazy var priceLabel: UILabel = {
        let uiLabel = setLabel(title: "", size: 16, textColor: DetailDesTextColor, textAlign: .left)
        return uiLabel
    }()
    
    
    lazy var bottomDivider:UIView = {
        let divider = UIView()
        divider.backgroundColor = BBTableHeaderDividerColor
        return divider
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
    }
    
    
}

extension DetailItemCell {
    
    func prepareViews(bounds:CGRect) {
        self.addSubview(itemImageView)
        self.addSubview(titleLabel)
        self.addSubview(desLabel)
//        self.addSubview(dateLabel)
        self.addSubview(priceLabel)
        self.addSubview(bottomDivider)
        
        itemImageView.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(16)
            m.bottom.equalToSuperview().offset(-16)
            m.left.equalToSuperview().offset(16)
            m.centerY.equalToSuperview()
            m.width.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints{ m in
            m.left.equalTo(itemImageView.snp.right).offset(16)
            m.top.equalTo(itemImageView.snp.top).offset(28)
        }
        
        desLabel.snp.makeConstraints{ m in
            m.left.equalTo(itemImageView.snp.right).offset(16)
            m.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        priceLabel.snp.makeConstraints{ m in
            m.bottom.equalToSuperview().offset(-16)
            m.right.equalToSuperview().offset(-16)
        }
        
//        dateLabel.snp.makeConstraints{ m in
//            m.right.equalTo(priceLabel.snp.left).offset(-2)
//            m.bottom.equalToSuperview().offset(-16)
//        }
        
        bottomDivider.snp.makeConstraints{ m in
            m.height.equalTo(1)
            m.centerX.equalToSuperview()
            m.width.equalToSuperview()
            m.bottom.equalToSuperview()
        }
    }
}
