//
//  DetailHeaderImageCell.swift
//  PlayGround
//
//  Created by kim jason on 03/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//


import Foundation
import Material
import SnapKit
import UIKit
import Localize_Swift


final class DetailHeaderImageCell: UICollectionViewCell {
    
    static let ID = "DetailHeaderImageCell"
    
    lazy var leftCornerView:UIView = {
       let view = UIView()
        view.backgroundColor = BBYellowColor
        return view
    }()
    
    lazy var buildingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = DetailImageBackgroundColor
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 20, textColor: DetailTitleTextColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var desLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 12, textColor: DetailDesTextColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var tagLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 12, textColor: DetailDesTextColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var underLineDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = DetailHeaderUnderLineColor
        return divider
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
        
    }
}

extension DetailHeaderImageCell {
    
    func prepareViews(bounds:CGRect) {
        addSubview(self.leftCornerView)
        addSubview(self.buildingImageView)
        addSubview(self.titleLabel)
        addSubview(self.desLabel)
        addSubview(self.tagLabel)
        addSubview(self.underLineDivider)
        
        self.leftCornerView.snp.makeConstraints{ m in
            m.top.equalToSuperview()
            m.left.equalToSuperview()
            m.right.equalToSuperview()
            m.height.equalTo(173)
        }
        self.buildingImageView.snp.makeConstraints{ m in
            m.top.equalToSuperview()
            m.left.equalToSuperview().offset(42)
            m.right.equalToSuperview()
            m.height.equalTo(286)
            m.centerX.equalToSuperview()
        }
        
        buildingImageView.clipsToBounds = true
        buildingImageView.layer.cornerRadius = 32
        buildingImageView.layer.maskedCorners = .layerMinXMaxYCorner
        
        self.titleLabel.snp.makeConstraints{ m in
            m.top.equalTo(self.buildingImageView.snp.bottom).offset(20)
            m.left.equalToSuperview().offset(15)
        }
        
        self.desLabel.snp.makeConstraints{ m in
            m.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            m.left.equalToSuperview().offset(15)
        }
        
        self.tagLabel.snp.makeConstraints{ m in
            m.top.equalTo(self.desLabel.snp.bottom).offset(6)
            m.left.equalToSuperview().offset(15)
        }
        
        self.underLineDivider.snp.makeConstraints{ m in
        m.top.equalTo(self.tagLabel.snp.bottom).offset(21)
            m.height.equalTo(8)
            m.width.equalToSuperview()
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview()
        }
    }
}
