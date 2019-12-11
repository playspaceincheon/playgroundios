//
//  FilterViewController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import SnapKit
import Material
import fluid_slider

class FilterViewController:BaseViewController {
    
    
    
    lazy var titleLabel = setLabel(title: "필터", size: 20, textColor: BBBlack2Color, textAlign: .left)
    
    lazy var desLabel = setLabel(title: "원하시는 조건을 검색하여 보세요", size: 14, textColor: BBGrey2Color, textAlign: .left)
    
    lazy var des1Label = setLabel(title: "거리", size: 16, textColor: BBBlack2Color, textAlign: .left)
    
    lazy var des2Label = setLabel(title: "평수", size: 16, textColor: BBBlack2Color, textAlign: .left)
    
    var divider:UIView!
    
    var confirmButton : RaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViews()
        self.view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}


extension FilterViewController {
    
    func prepareViews() {
        
        let view = UIView()
        view.backgroundColor = BBWhiteColor
        self.view.addSubview(view)
        
        view.snp.makeConstraints{ m in
            m.top.left.right.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        self.roundCorners(view: view, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 32)
        
        self.divider = UIView()
        self.view.addSubviews(titleLabel)
        self.view.addSubviews(desLabel)
        self.view.addSubviews(des1Label)
        self.view.addSubviews(des2Label)
        self.view.addSubviews(divider)
        
        divider.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(8)
            m.width.equalTo(56)
            m.height.equalTo(8)
            m.centerX.equalToSuperview()
        }
        
        divider.backgroundColor = BBYellowColor
        divider.layer.cornerRadius = 4
        
        titleLabel.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(56)
            m.left.equalToSuperview().offset(16)
        }
        
        desLabel.snp.makeConstraints{ m in
            m.top.equalTo(titleLabel.snp.bottom).offset(16)
            m.left.equalToSuperview().offset(16)
        }
        
        des1Label.snp.makeConstraints{ m in
            m.top.equalTo(desLabel.snp.bottom).offset(18)
            m.left.equalToSuperview().offset(16)
        }
        
        
        
        
        let slider = Slider()
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 20) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "1km"))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "20km"))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.contentViewColor = BBYellowColor
        slider.valueViewColor = .white
        view.addSubview(slider)
        
        slider.snp.makeConstraints{ m in
            m.top.equalTo(des1Label.snp.bottom).offset(12)
            m.width.equalTo(self.view.width - 32)
            m.centerX.equalToSuperview()
            m.height.equalTo(32)
        }
        
        des2Label.snp.makeConstraints{ m in
            m.top.equalTo(slider.snp.bottom).offset(28)
            m.left.equalToSuperview().offset(16)
        }
        
        let slider2 = Slider()
        slider2.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 10) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        slider2.setMinimumLabelAttributedText(NSAttributedString(string: "1평"))
        slider2.setMaximumLabelAttributedText(NSAttributedString(string: "10평"))
        slider2.fraction = 0.5
        slider2.shadowOffset = CGSize(width: 0, height: 10)
        slider2.shadowBlur = 5
        slider2.contentViewColor = BBYellowColor
        slider2.valueViewColor = .white
        view.addSubview(slider2)
        slider2.snp.makeConstraints{ m in
            m.top.equalTo(des2Label.snp.bottom).offset(12)
            m.width.equalTo(self.view.width - 32)
            m.centerX.equalToSuperview()
            m.height.equalTo(32)
        }
        
        self.prepareConfrimButton()
        
    }
    
    
    func prepareConfrimButton() {
        self.confirmButton = RaisedButton(title: "완료")
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
        let time : DispatchTime = DispatchTime.now() + Double(1)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.hideProgress()
            self.dismiss(animated:true)
        }
    }
}
