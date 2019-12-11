//
//  DetailDateSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import IGListKit
protocol ChangeDetailDateValueDelegate: class {
    func changeDateValue(data:DateData)
}

final class DetailDateSectionController: ListSectionController{
    
    weak var delegate:ChangeDetailDateValueDelegate?
    
    var data:DateData?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: DeatilDateCell.self, for: self, at: index) as? DeatilDateCell else {
                 fatalError()
             }
        
        cell.dateRangeStr = "\(data!.range!)일"
        let startDate = data?.startDate?.toFormat("yyyy.MM.dd")
        let endDate = data?.endDate?.toFormat("yyyy.MM.dd")
        cell.dateLabel.text = "\(startDate!) ~ \(endDate!)"
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapChange))
//        cell.changeLabel.addGestureRecognizer(gesture)
        cell.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelectDAte))
        cell.addGestureRecognizer(gesture)
        return cell
    }
    

    @objc func didSelectDAte() {
          self.delegate?.changeDateValue(data: self.data!)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 54)
    }
    
    override func didUpdate(to object: Any) {
        data = object as? DateData
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        log?.debug("wow, selected!!")
        self.delegate?.changeDateValue(data: self.data!)
        
    }
}
