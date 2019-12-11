//
//  BuildingDetailViewController.swift
//  PlayGround
//
//  Created by kim jason on 03/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SnapKit
import IGListKit
import Motion
import Kingfisher
import Alamofire
import Material
import SwiftyJSON
import SwiftEventBus
import MaterialComponents
import Localize_Swift
import RealmSwift
import SwiftEventBus
import SwiftDate


class BuildingDetailViewController: BaseViewController {
    
    var data:Buildings?
    var listData:[Any] = []
    var dateData:DateData!
    var selectedItem = 999
    var collectionView = UICollectionView (frame: .zero, collectionViewLayout: UICollectionViewFlowLayout ())
    
    var confirmButton:RaisedButton!
    
    lazy var adapter: ListAdapter = {
        return ListAdapter (updater: ListAdapterUpdater (), viewController: self)
    } ()
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        self.prepareNavigation()
        self.prepareViews()
        self.prepareConfrimButton()
        self.preapreData()
    }
    
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear (animated)
        
    }
    
}

extension BuildingDetailViewController {
    
    func preapreData() {
        self.listData.removeAll()
        
        let headerImage = self.data!
        self.listData.append(headerImage)
        
        let date = DateData()
        date.startDate = Date()
        date.endDate = Date() + 1.months
        date.range = 30
        self.dateData = date
        
        self.listData.append(date)
        
        let items = self.data?.items!
        for(index,value) in (items?.enumerated())! {
            self.listData.append(value)
        }
        
        let des = self.data?.descriptions!
        for(index,value) in (des?.enumerated())! {
            self.listData.append(value)
        }
        
        
        self.adapter.performUpdates (animated: true)
    }
    
    func reLoadData() {
        self.listData.removeAll()
        
        let headerImage = self.data!
        self.listData.append(headerImage)
        
        self.listData.append(self.dateData)
        
        let items = self.data?.items!
        for(index,value) in (items?.enumerated())! {
            if(index == self.selectedItem) {
                value.isSelected = true
            } else {
                value.isSelected = false
            }
            self.listData.append(value)
        }
        
        let des = self.data?.descriptions!
        for(index,value) in (des?.enumerated())! {
            self.listData.append(value)
        }
        
        
        adapter.performUpdates(animated: true, completion: { m in
            self.collectionView.reloadData()
        })
    }
    
    func prepareViews() {
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.dividerColor = .clear
        self.collectionView.dividerThickness = 0
        self.collectionView.layer.zPosition = 5
        
        collectionView.backgroundColor = BBWhiteColor
        
        collectionView.register (DetailHeaderImageCell.self, forCellWithReuseIdentifier: DetailHeaderImageCell.ID)
        collectionView.register (DeatilDateCell.self, forCellWithReuseIdentifier: DeatilDateCell.ID)
        collectionView.register (DetailItemCell.self, forCellWithReuseIdentifier: DetailItemCell.ID)
        collectionView.register (DetailDesCell.self, forCellWithReuseIdentifier: DetailDesCell.ID)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        //        adapter.scrollViewDelegate = self
        
        view.layout(collectionView).width(self.view.width).centerX()
        collectionView.snp.makeConstraints { m in
            m.bottom.top.equalToSuperview()
        }
        
        self.collectionView.contentInset = UIEdgeInsets (top: 0, left: 0, bottom: 56 + xBottomOffset + 12, right: 0)
    }
    
    func prepareConfrimButton() {
        self.confirmButton = RaisedButton(title: "창고 예약하기")
        confirmButton.titleColor = BBWhiteColor
        confirmButton.pulseColor = BBWhiteColor.withAlphaComponent(0.5)
        confirmButton.backgroundColor = .clear
        //        confirmButton.setGradientBackground(colorLeft: GradientLeftColor, colorRight: GradientRightColor)
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
    
    func prepareNavigation() {
        self.setNaviTitle(title: "예약하기")
        let closeIcon = IconButton(image:UIImage(named:"close24"))
        closeIcon.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        self.navigationItem.leftViews = [closeIcon]
    }
    
    @objc
    func dismissViews() {
        self.dismiss(animated: true)
    }
}

extension BuildingDetailViewController: ListAdapterDataSource {
    func objects (for listAdapter: ListAdapter) -> [ListDiffable] {
        let objects = self.listData as! [ListDiffable]
        return objects
    }
    
    func listAdapter (_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if(object is Buildings) {
            let sec = DetailHeaderImageSectionController()
            return sec
        } else if (object is DateData) {
            let sec = DetailDateSectionController()
            sec.delegate = self
            return sec
        } else if (object is BuildingItems) {
            let sec = DetailItemSectionController()
            sec.delegate = self
            return sec
        } else {
            let sec = DetailDesSectionController()
            return sec
        }
    }
    
    func emptyView (for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

extension BuildingDetailViewController: ItemClickedDelegate,ChangeDetailDateValueDelegate,
DataChangeDatePickerDelegate{
    
    
    
    func ItemClicked(data:BuildingItems) {
        log?.debug("clicked item")
        
        for(index,value) in (self.data?.items?.enumerated())! {
            if(value.itemName == data.itemName) {
                self.selectedItem = index
            }
        }
        self.reLoadData()
    }
    
    func changeDateValue(data:DateData){
        log?.debug("clicked date")
        let pickerVC = DatePickerViewController()
        pickerVC.dataChangeDelegate = self
        let bottomsheetVC = MDCBottomSheetController(contentViewController: pickerVC)
        bottomsheetVC.preferredContentSize.height = 310
        present(bottomsheetVC, animated: true)
    }
    
    func getInputDate(startDate:Date, length:Int) {
        let data = self.listData[1] as! DateData
        data.startDate = startDate
        data.endDate = startDate + length.days
        data.range = length
        self.listData.remove(at: 1)
        self.listData.insert(data, at: 1)
        adapter.performUpdates(animated: true, completion: { m in
            self.collectionView.reloadData()
        })
    }
    
    func dismissDatePicker() {
        //nothings..
    }
    
    @objc func clickedConfirmButton() {
        if(selectedItem == 999) {
            log?.debug("먼저 고르시고 눌러")
        } else {
            let vc = PurchaseViewContrller()
            vc.buildingData = self.data!
            vc.selectedItemName = (self.data?.items![selectedItem].itemName)!
            vc.data = self.data?.items![selectedItem]
            vc.priceData = (self.data?.items![selectedItem].itemValue!)!
            vc.dateData = self.dateData
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
