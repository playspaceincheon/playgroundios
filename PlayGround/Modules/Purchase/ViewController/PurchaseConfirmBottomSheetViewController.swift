//
//  PurchaseConfirmBottomSheetViewController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import SnapKit
import Material
import MaterialComponents

protocol PurchaseConfirmDelegate:class {
    func donePurchase()
}

class PurchaseConfirmBottomSheetViewController:BaseViewController {
    
    weak var delegate:PurchaseConfirmDelegate?
    
    var price:Int = 0
    var buildginName = ""
    var itemName = ""
    lazy var titleLabel = setLabel(title: "결제확인", size: 20, textColor: BBBlack2Color, textAlign: .left, isBold: true)
    
    
    lazy var title2Label = setLabel(title: "건물이름", size: 16, textColor: BBBlack2Color, textAlign: .left, isBold: true)
    
    
    lazy var title3Label = setLabel(title: "선택서비스", size: 16, textColor: BBBlack2Color, textAlign: .left, isBold: true)
    
    lazy var title4Label = setLabel(title: "총액", size: 16, textColor: BBBlack2Color, textAlign: .left, isBold: true)
    
    
    lazy var des1Label = setLabel(title: "\(buildginName)", size: 14, textColor: BBBlack2Color, textAlign: .right)
    lazy var des2Label = setLabel(title: "\(itemName)", size: 14, textColor: BBBlack2Color, textAlign: .right)
    lazy var priceLabel = setLabel(title: "\(price)원", size: 14, textColor: BBBlack2Color, textAlign: .right)
    
    lazy var divider:UIView = {
       let view = UIView()
        view.backgroundColor = BBGrey3Color
        return view
    }()
    var confirmButton : RaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BBWhiteColor
        self.roundCorners(view: self.view, corners: [.layerMinXMinYCorner], radius: 32)
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension PurchaseConfirmBottomSheetViewController {
    
    func prepareView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(des1Label)
        self.view.addSubview(des2Label)
        self.view.addSubview(priceLabel)
        self.view.addSubview(divider)
        self.view.addSubview(title2Label)
        self.view.addSubview(title3Label)
        self.view.addSubview(title4Label)
        
        self.titleLabel.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(32)
            m.left.equalToSuperview().offset(16)
        }
        
        self.des1Label.snp.makeConstraints{ m in
            m.top.equalTo(self.titleLabel.snp.bottom).offset(32)
            m.right.equalToSuperview().offset(-16)
        }
        
        self.title2Label.snp.makeConstraints{ m in
            m.top.equalTo(self.titleLabel.snp.bottom).offset(32)
            m.left.equalToSuperview().offset(16)
        }
        
        
        self.des2Label.snp.makeConstraints{ m in
            m.top.equalTo(self.des1Label.snp.bottom).offset(32)
            m.right.equalToSuperview().offset(-16)
        }
        
        
        self.title3Label.snp.makeConstraints{ m in
            m.top.equalTo(self.des1Label.snp.bottom).offset(32)
            m.left.equalToSuperview().offset(16)
        }
        
        self.title3Label.snp.makeConstraints{ m in
            m.top.equalTo(self.des1Label.snp.bottom).offset(32)
            m.left.equalToSuperview().offset(16)
        }
        
        divider.backgroundColor = BBGrey3Color
        
        self.divider.snp.makeConstraints{ m in
            m.top.equalTo(self.des2Label.snp.bottom).offset(32)
            m.width.equalTo(self.view.width - 32)
            m.centerX.equalToSuperview()
            m.height.equalTo(1)
        }
        
        self.priceLabel.snp.makeConstraints{ m in
            m.top.equalTo(self.divider.snp.bottom).offset(32)
            m.right.equalToSuperview().offset(-16)
        }
        
        
        self.title4Label.snp.makeConstraints{ m in
            m.top.equalTo(self.divider.snp.bottom).offset(32)
            m.left.equalToSuperview().offset(16)
        }
    
        self.prepareConfrimButton()
    }
    
    
    func prepareConfrimButton() {
        self.confirmButton = RaisedButton(title: "\(price)원 결제하기")
        confirmButton.titleColor = BBWhiteColor
        confirmButton.pulseColor = BBWhiteColor.withAlphaComponent(0.5)
        confirmButton.backgroundColor = .clear
        confirmButton.backgroundColor = BBYellowColor
                 if(DeviceManager.checkXDevice()) {
        confirmButton.layer.cornerRadius = 28
        }
        self.view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ m in
            m.height.equalTo(56)
            m.width.equalTo(self.view.width - (DeviceManager.checkXDevice() ? 32 : 0))
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview().offset(-xBottomOffset)
        }
        confirmButton.layer.zPosition = 99
        confirmButton.addTarget(self, action: #selector(clickedConfirmButton), for: .touchUpInside)
    }
    
    @objc func clickedConfirmButton() {
        self.showProgress()
        
        let time : DispatchTime = DispatchTime.now() + Double(1.5)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.hideProgress()
            self.dismiss(animated: true)
            self.delegate?.donePurchase()
        }
        
    }
    
}
