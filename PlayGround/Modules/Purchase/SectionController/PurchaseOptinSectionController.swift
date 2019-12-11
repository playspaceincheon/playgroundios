//
//  PurchaseOptinSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit

protocol PurchaseOptinDelegate:class {
    func clickedOptin(isChecked:Bool, isDes:String)
}

final class PurchaseOptinSectionController: ListSectionController{
    
    var delegate:PurchaseOptinDelegate?
    
    var data:PurchaseOptin?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: PurchaseOpinCell.self, for: self, at: index) as? PurchaseOpinCell else {
                         fatalError()
                     }

        if(data?.des?.count ?? 0 > 0) {
            cell.desLabel.text = data?.des!
            cell.desLabel.isHidden = false
        } else {
            cell.desLabel.isHidden = true
        }
        
//        if(data!.isChecked) {
//            cell.checkBoxImageView.isHidden = false
//        } else {
//            cell.checkBoxImageView.isHidden = true
//        }
//
        
        cell.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickedOptin))
        cell.addGestureRecognizer(gesture)
        cell.layoutIfNeeded()
        return cell
    }
    
    @objc func clickedOptin() {
        self.delegate?.clickedOptin(isChecked: data!.isChecked, isDes: (data?.des!)!)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 32)
    }
    
    override func didUpdate(to object: Any) {
       data = object as? PurchaseOptin
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {

    }
}
