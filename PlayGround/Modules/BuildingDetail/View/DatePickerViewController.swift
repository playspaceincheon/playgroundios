//
//  DatePickerViewController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import SwiftHEXColors
import Foundation
import Material
import SnapKit
import UIKit
import SwiftyJSON
import MaterialComponents
import PINCache
import SwiftDate
import Localize_Swift
import Koyomi

protocol DataChangeDatePickerDelegate: class {
    func getInputDate(startDate:Date, length:Int)
    func dismissDatePicker()
}

final class DatePickerViewController:UIViewController {
    
    
    // height size is 272
    weak  var dataChangeDelegate :DataChangeDatePickerDelegate?
    
    var koyomi : Koyomi!
    var confirmButton : RaisedButton!
    var divider : UIView!
    var date:Date?
    var startedAt:Date?
    var endAt:Date?
    var isEndAt:Bool = false
    var nextButton = RaisedButton(title: "다음달")
    var beforeButton = RaisedButton(title: "이전달")
    var presentButton = RaisedButton(title: "오늘")
    var currentMonth = setLabel(title: "", size: 16, textColor: BBBlack2Color, textAlign: .center, isBold: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.makeCorner(withRadius: 4.0)
        self.view.backgroundColor = BBWhiteColor
        self.prepareViews()
        self.initViews()
    }
}

extension DatePickerViewController {
    
    fileprivate func prepareViews() {
        confirmButton = setUnSelectedRaisedButton(title: "확인")
        confirmButton.addTarget(self, action: #selector(clickedConfirmButton), for: .touchUpInside)
        
        divider = UIView()
        divider.backgroundColor = BBIvory2Color
        
        koyomi = Koyomi(frame: .zero, sectionSpace: 1.5, cellSpace: 0.5, inset: .zero, weekCellHeight: 25)
        koyomi.isHiddenOtherMonth = false
        koyomi.selectionMode = .sequence(style: .semicircleEdge)
        koyomi.selectedStyleColor = BBYellowColor
        koyomi.calendarDelegate = self
        koyomi.weeks = ("일", "월", "화", "수", "목", "금", "토")
        koyomi.style = .yellow
        koyomi.setDayColor(.yellow, of: Date(), to: .none)
        koyomi.select(date: Date())
        
        self.view.addSubview(koyomi)
        koyomi.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(72)
            m.left.right.equalToSuperview()
            m.bottom.equalToSuperview().offset(xBottomOffset)
        }
        self.view.addSubview(confirmButton)
        self.view.addSubview(beforeButton)
        self.view.addSubview(nextButton)
        self.view.addSubview(presentButton)
        self.view.addSubview(currentMonth)
        self.view.layout(divider).width(self.view.bounds.width - 32).height(1).centerX()
        currentMonth.text = "\(koyomi.currentDateString(withFormat: "yyyy"))년  \(koyomi.currentDateString(withFormat: "MN"))월"
    }
    
    
    fileprivate func initViews() {
        confirmButton.snp.makeConstraints { m in
            m.top.equalToSuperview().offset(8)
            m.right.equalToSuperview().offset(-8)
        }
        
        divider.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(55)
        }
     
        changeRaisedButton(button: beforeButton)
        changeRaisedButton(button: presentButton)
        changeRaisedButton(button: nextButton)
        
        presentButton.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(8)
            m.height.equalTo(24)
            m.width.equalTo(80)
            m.centerX.equalToSuperview()
        }
        presentButton.addTarget(self, action: #selector(self.clickedPresent), for: .touchUpInside)
        
        beforeButton.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(8)
            m.height.equalTo(24)
            m.width.equalTo(80)
            m.right.equalTo(presentButton.snp.left)
        }
                beforeButton.addTarget(self, action: #selector(self.clickedBefore), for: .touchUpInside)
        
        nextButton.snp.makeConstraints{ m in
             m.top.equalToSuperview().offset(8)
             m.height.equalTo(24)
             m.width.equalTo(80)
             m.left.equalTo(presentButton.snp.right)
        }
          nextButton.addTarget(self, action: #selector(self.clickedNext), for: .touchUpInside)
        currentMonth.snp.makeConstraints{ m in
            m.top.equalTo(presentButton.snp.bottom).offset(6)
            m.centerX.equalToSuperview()
        }
    }
    
    
    @objc func datePickerValueChanged(startDate:Date, length:Int){
        log?.debug("wowowowowow111")
        // Create date formatter
        
        // Apply date format
        //        CacheManager.shared.pickerDate = sender.date
        dataChangeDelegate?.getInputDate(startDate:startDate, length:length)
        
    }
    @objc func clickedPresent() {
        koyomi.display(in: .current)
       currentMonth.text = "\(koyomi.currentDateString(withFormat: "yyyy"))년  \(koyomi.currentDateString(withFormat: "MN"))월"
    }

    @objc func clickedNext() {
        koyomi.display(in: .next)
       currentMonth.text = "\(koyomi.currentDateString(withFormat: "yyyy"))년  \(koyomi.currentDateString(withFormat: "MN"))월"
    }
    
    @objc func clickedBefore() {
        koyomi.display(in: .previous)
    currentMonth.text = "\(koyomi.currentDateString(withFormat: "yyyy"))년  \(koyomi.currentDateString(withFormat: "MN"))월"
        
    }
    
    @objc fileprivate func clickedConfirmButton() {
        self.dismiss(animated: true)
        self.dataChangeDelegate?.dismissDatePicker()
    }
    
    fileprivate func setUnSelectedRaisedButton(title: String) -> RaisedButton {
        let raisedButton = RaisedButton(title: title, titleColor: BBBlackColor)
        raisedButton.pulseColor = BBGreyColor
        raisedButton.backgroundColor = .none
        raisedButton.isUserInteractionEnabled = true
        raisedButton.layer.zPosition = 1
        raisedButton.layer.shadowColor = .none
        return raisedButton
    }
    
    fileprivate func changeRaisedButton(button: RaisedButton) {
        button.backgroundColor = BBWhiteColor
        button.pulseColor = BBYellowColor
        button.titleColor = BBBlack2Color
        button.borderColor = .clear
    }
}

extension DatePickerViewController : KoyomiDelegate {
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        log?.debug("length \(length)")
        
        if(date != nil && length != 0) {
            self.datePickerValueChanged(startDate:date!, length:length)
        }
        return true
    }
}
