//
//  DonePurchaseViewController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import SnapKit
import Material
import fluid_slider

class DonePurchaseViewController:BaseViewController {
    
    
    var QRImage:UIImageView!
    
    lazy var titleLabel = setLabel(title: "구매 완료", size: 20, textColor: BBBlack2Color, textAlign: .center)
    
    lazy var desLabel = setLabel(title: "구매 해주셔서 감사 합니다. 해당 QR코드를 노는공간 문 앞 카메라에 보여 주세요.", size: 16, textColor: BBBlack2Color, textAlign: .center, numberOfLines: 3)
    var confirmButton : RaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}


extension DonePurchaseViewController {
    
    func prepareViews() {
        QRImage = UIImageView(image:UIImage(named:"qrImage"))
        self.view.addSubviews(titleLabel)
        self.view.addSubviews(desLabel)
        self.view.addSubviews(QRImage)
        
        QRImage.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(16)
            m.centerX.equalToSuperview()
            m.width.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints{ m in
            m.top.equalTo(QRImage.snp.bottom).offset(16)
            m.centerX.equalToSuperview()
        }
        
        desLabel.snp.makeConstraints{ m in
            m.top.equalTo(titleLabel.snp.bottom).offset(16)
            m.centerX.equalToSuperview()
            m.width.equalTo(self.view.width - 32)
        }
        
        self.prepareConfrimButton()
    }
    
    func prepareConfrimButton() {
        self.confirmButton = RaisedButton(title: "확인")
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
        self.dismiss(animated: true)
    }
}





