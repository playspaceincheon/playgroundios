//
//  EventViewController.swift
//  PlayGround
//
//  Created by kim jason on 26/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

class EventViewController: BaseViewController{
    
    var listData:[Any] = []
    var collectionView = UICollectionView (frame: .zero, collectionViewLayout: UICollectionViewFlowLayout ())
    lazy var adapter: ListAdapter = {
        return ListAdapter (updater: ListAdapterUpdater (), viewController: self)
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.preapreViews()
        self.prepareData()
    }
    
}


extension EventViewController {
    
    func preapreViews() {
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.dividerColor = .clear
        self.collectionView.dividerThickness = 0
        self.collectionView.layer.zPosition = 5
        
        collectionView.backgroundColor = BBWhiteColor
        
        collectionView.register (EventCell.self, forCellWithReuseIdentifier: EventCell.ID)
   
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        view.layout(collectionView).width(self.view.width).centerX()
        
        collectionView.snp.makeConstraints { m in
            m.bottom.top.equalToSuperview()
        }
        
        self.collectionView.contentInset = UIEdgeInsets (top: 0, left: 0, bottom: 56 + xBottomOffset + 12, right: 0)
    }
    
    func prepareData() {
        
        self.listData.removeAll()
        
        let data = Events()
        data.thumnailImage = UIImage(named:"image1")
        data.title = "보관하기 어려운 레저 용품은 어떻하지?"
        data.des = "스포츠와 캠핑을 즐기신다면?” 장비가 필요한 스포츠를 취미로 하시는 분들이나 부피가 큰 캠핑용품을 가지고 계신 분들은 보관 장소에 대한 어려움이 있습니다.즐거워야 하는 취미 용품에 스트레스 받지 마시고 퀘적한 환경에보관하세요. 필요할 때 언제든 꺼내 쓸 수 있습니다."
        
        self.listData.append(data)
        
        let data2 = Events()
        data2.thumnailImage = UIImage(named:"image2")
        data2.title = "가족을 위한 공간"
        data2.des = "가족을 위한 공간 가족 수가 늘어나고 아이가 커갈수록 집은 물건으로 가득차게 됩니다. 아이들 장난감이나 책과 같은 잘 안쓰는 추억의 물건들은 “노는공간”에 보관하시고 가정 내 여유 공간을 확보하세요."
       self.listData.append(data2)
        
         
         let data3 = Events()
         data3.thumnailImage = UIImage(named:"image3")
         data3.title = "나만을 위한 옷장"
         data3.des = "나만의 옷장  계절이 바뀔 때마다 가득 차는 옷장, 비울 수 없다면? 나만의 옷방을 “노는공간”에서 만들어보세요."
        self.listData.append(data3)
        
        adapter.performUpdates(animated: true, completion: { m in
             self.collectionView.reloadData()
         })
    }
    
}


extension EventViewController: ListAdapterDataSource {
    
    func objects (for listAdapter: ListAdapter) -> [ListDiffable] {
        let objects = self.listData as! [ListDiffable]
        return objects
    }
    
    func listAdapter (_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if(object is Events) {
            let sec = EventSectionConttroller()
            return sec
        } else {
            let sec = EventSectionConttroller()
           return sec
        }
        
    }
    
    func emptyView (for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

class Events:NSObject, ListDiffable {
    
    var thumnailImage:UIImage?
    var title:String?
    var des:String?
    
    var diffable:String = "\(Int(arc4random_uniform(999999)))"
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? DateData else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
    
}
