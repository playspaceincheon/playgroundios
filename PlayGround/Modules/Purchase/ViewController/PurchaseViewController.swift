//
//  PurchaseViewController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
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
import ObjectMapper
import IGListKit

class PurchaseViewContrller: BaseViewController {
    
    var buildingData:Buildings?
    var data:BuildingItems?
    var selectedItemName:String = ""
    var price = 0
    
    var dateData:DateData!
    var priceData:Int = 0
    
    
    var optinArr :[PurchaseOptin] = []
    var listData:[Any] = []
    
    
    var collectionView = UICollectionView (frame: .zero, collectionViewLayout: UICollectionViewFlowLayout ())
    
    var confirmButton:RaisedButton!
    
    lazy var adapter: ListAdapter = {
        return ListAdapter (updater: ListAdapterUpdater (), viewController: self)
    } ()
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        self.price = (self.priceData * self.dateData.range!) - 5000
        self.prepareNavigation()
        self.prepareViews()
        self.prepareConfrimButton()
        self.preapreData()
    }
    
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear (animated)
        
    }
    
}

extension PurchaseViewContrller {
    
    func preapreData() {
        self.listData.removeAll()
        
        //Header Image
        let image = PurchaseImage()
        image.thumnail = self.data?.itemThumnail
        
        self.listData.append(image)
        
        
        //Section 1
        let title1 = PurchaseTitle()
        title1.title = "선택정보"
        
        self.listData.append(title1)
        
        let des1 = PurchaseDes()
        des1.title = "선택서비스"
        des1.des = "[예약] \(selectedItemName) * \(dateData.range!)일 : \(self.price)원"
        
        self.listData.append(des1)
        
        let startDate = self.dateData.startDate!.toFormat("yyyy.MM.dd")
        let endDate = self.dateData.endDate!.toFormat("yyyy.MM.dd")
        
        let des2 = PurchaseDes()
        des2.title = "이용기간"
        des2.des = "\(startDate) - \(endDate)"
        
        self.listData.append(des2)
        
        let des3 = PurchaseDes()
        des3.title = "건물이름"
        des3.des = "\(self.buildingData!.buildingName!)"
        
        self.listData.append(des3)
        
        let des4 = PurchaseDes()
        des4.title = "요청사항"
        des4.des = "가장 높은 위치로 부탁 드려요!"
        
        self.listData.append(des4)
        
        // Section2
        
        let title2 = PurchaseTitle()
        title2.title = "결제정보"
        
        self.listData.append(title2)
        
        let des5 = PurchaseDes()
        des5.title = "결제금액"
        des5.des = "\(self.price)원"
        
        self.listData.append(des5)
        
        let des6 = PurchaseDes()
        des6.title = "할인금액"
        des6.des = "-5000원"
        des6.isUnderLine = true
        self.listData.append(des6)
        
        let result = price - 5000
        let title3 = PurchaseTitle()
        title3.title = "총 결제금액"
        title3.des = "\(result)원"
        
        self.listData.append(title3)
        
        let title4 = PurchaseTitle()
        title4.title = "결제 수단"
        self.listData.append(title4)
        
        let card = PurchaseCard()
        card.title = "카드 결제"
        card.des = "변경"
        self.listData.append(card)
        
        
        //opt
        let optinAll = PurchaseOptin()
        optinAll.des = "전체동의"
        optinAll.isAll = true
        self.listData.append(optinAll)
        self.optinArr.append(optinAll)
        
        let opt1 = PurchaseOptin()
        opt1.des = "개인 정보 제공 동의"
        self.listData.append(opt1)
        self.optinArr.append(opt1)
        
        let opt2 = PurchaseOptin()
        opt2.des = "개인 정보 수집 동의"
        self.listData.append(opt2)
        self.optinArr.append(opt2)
        
        let opt3 = PurchaseOptin()
        opt3.des = "상기 결제 내역을 확인, 결제 진행에 동의"
        self.listData.append(opt3)
        self.optinArr.append(opt3)
        
        self.adapter.performUpdates (animated: true)
    }
    
    func reLoadData() {
        self.listData.removeAll()
        
        //Header Image
        let image = PurchaseImage()
        image.thumnail = self.data?.itemThumnail
        
        self.listData.append(image)
        
        
        //Section 1
        let title1 = PurchaseTitle()
        title1.title = "선택정보"
        
        self.listData.append(title1)
        
        let des1 = PurchaseDes()
        des1.title = "선택서비스"
        des1.des = "[예약] \(selectedItemName) * \(dateData.range)일\n\(self.price)원"
        
        self.listData.append(des1)
        
        
        let startDate = self.dateData.startDate!.toFormat("yyyy.MM.dd")
        let endDate = self.dateData.endDate!.toFormat("yyyy.MM.dd")
        
        let des2 = PurchaseDes()
        des2.title = "이용기간"
        des2.des = "\(startDate) - \(endDate)"
        
        self.listData.append(des2)
        
        let des3 = PurchaseDes()
        des3.title = "건물이름"
        des3.des = "\(self.buildingData?.buildingName!)"
        
        self.listData.append(des3)
        
        let des4 = PurchaseDes()
        des4.title = "요청사항"
        des4.des = "가장 높은 위치로 부탁 드려요!"
        
        self.listData.append(des4)
        
        // Section2
        
        let title2 = PurchaseTitle()
        title2.title = "결제정보"
        
        self.listData.append(title2)
        
        let des5 = PurchaseDes()
        des5.title = "결제금액"
        des5.des = "\(self.price)원"
        
        self.listData.append(des5)
        
        let des6 = PurchaseDes()
        des6.title = "할인금액"
        des6.des = "-5000원"
        des6.isUnderLine = true
        self.listData.append(des6)
        
        let result = price - 5000
        let title3 = PurchaseTitle()
        title3.title = "총 결제금액"
        title3.des = "\(result)"
        
        self.listData.append(title3)
        
        let title4 = PurchaseTitle()
        title4.title = "결제 수단"
        self.listData.append(title4)
        
        let card = PurchaseCard()
        card.title = "카드 결제"
        card.des = "변경"
        self.listData.append(card)
        
        let optArrData = self.optinArr
        for(index,value) in optArrData.enumerated() {
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
        
        self.confirmButton = RaisedButton(title: "\(self.price)원 결제하기")
        confirmButton.titleColor = BBWhiteColor
        confirmButton.pulseColor = BBWhiteColor.withAlphaComponent(0.3)
        
        confirmButton.backgroundColor = BBYellowColor
        
        self.view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ m in
            m.height.equalTo(56 + xBottomOffset)
            m.width.equalTo(self.view.width)
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        if(DeviceManager.checkXDevice()) {
            confirmButton.titleLabel?.snp.removeConstraints()
            confirmButton.titleLabel?.snp.makeConstraints{ m in
                m.centerY.equalToSuperview().offset(-8)
            }
        }
        confirmButton.layer.zPosition = 99
        confirmButton.addTarget(self, action: #selector(clickedConfirmButton), for: .touchUpInside)
        
    }
    
    
    @objc func clickedConfirmButton() {
        let vc = PurchaseConfirmBottomSheetViewController()
        vc.price = self.price
        vc.buildginName = self.buildingData!.buildingName!
        vc.itemName = "\(selectedItemName) * \(dateData.range!)일"
        vc.delegate = self
        let bottomSheet: MDCBottomSheetController =
            MDCBottomSheetController(contentViewController: vc)
        bottomSheet.preferredContentSize.height = CGFloat(330)
        
        self.present(bottomSheet, animated: true)
    }
    
    func prepareNavigation() {
        self.setNaviTitle(title: "결제하기")
        //        let closeIcon = IconButton(image:UIImage(named:"back24"))
        //        closeIcon.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        //        self.navigationItem.leftViews = [closeIcon]
        self.navigationItem.backButton.tintColor = BBYellowColor
    }
    
    @objc
    func dismissViews() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PurchaseViewContrller:PurchaseConfirmDelegate {
    func donePurchase() {
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                let vc = DonePurchaseViewController()
                let bottomSheet: MDCBottomSheetController =
                    MDCBottomSheetController(contentViewController: vc)
                let height = DeviceManager.checkXDevice() ? 220 : 320
                bottomSheet.preferredContentSize.height = CGFloat(height)
                pvc!.present(bottomSheet, animated: true)
            }
        })
        
    }
}

extension PurchaseViewContrller: ListAdapterDataSource {
    func objects (for listAdapter: ListAdapter) -> [ListDiffable] {
        let objects = self.listData as! [ListDiffable]
        return objects
    }
    
    
    
    func listAdapter (_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if(object is PurchaseImage) {
            let sec = PurchaseImageSectionController()
            return sec
        } else if (object is  PurchaseTitle) {
            let sec = PurchaseTitleSectionController()
            return sec
        } else if (object is PurchaseDes) {
            let sec = PurchaseDesSectionController()
            return sec
        } else if (object is PurchaseCard) {
            let sec = PurchaseCardSectionController()
            return sec
        } else {
            let sec = PurchaseOptinSectionController()
            sec.delegate = self
            return sec
        }
    }
    
    func emptyView (for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

extension PurchaseViewContrller:PurchaseOptinDelegate {
    func clickedOptin(isChecked:Bool, isDes:String) {
        
    }
    
}

class PurchaseTitle:NSObject,ListDiffable {
    var title:String?
    var des:String?
    
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? BuildingItems else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
    
}

class PurchaseDes:NSObject,ListDiffable {
    var title:String?
    var des:String?
    var isUnderLine:Bool = false
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? BuildingItems else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
    
}

class PurchaseImage:NSObject,ListDiffable {
    
    var thumnail:String?
    
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? BuildingItems else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
    
}

class PurchaseCard: NSObject, ListDiffable {
    var title:String?
    var des:String?
    
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? BuildingItems else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
}

class PurchaseOptin: NSObject, ListDiffable {
    var isChecked = false
    var des:String?
    var isAll = false
    
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? BuildingItems else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
}
