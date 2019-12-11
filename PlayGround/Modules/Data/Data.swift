//
//  Data.swift
//  PlayGround
//
//  Created by kim jason on 04/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit


class DummyData:NSObject, Mappable, ListDiffable {
    
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    var datas:[Buildings]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    //Mappable
    func mapping(map: Map) {
        datas <- map["buildings"]
    }
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? DummyData else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
    
}

class Buildings:NSObject, Mappable, ListDiffable{
    
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    var buildingName:String?
    var buildingThumnail:String?
    var buildingAddress:String?
    var buildingLat:String?
    var buildingLng:String?
    var tagNames:[String]?
    var items:[BuildingItems]?
    var descriptions:[Descriptions]?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    //Mappable
    func mapping(map: Map) {
        buildingName <- map["building_name"]
        buildingThumnail <- map["building_thumbnail"]
        buildingAddress <- map["building_address"]
        buildingLat <- map["building_lat"]
        buildingLng <- map["building_lng"]
        tagNames <- map["tag_names"]
        items <- map["items"]
        descriptions <- map["descriptions"]
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Buildings else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
    
}

class BuildingItems:NSObject, Mappable, ListDiffable {
    
    lazy var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    var itemName:String?
    var itemThumnail:String?
    var itemDes:String?
    var itemPrice:String?
    var isSelected:Bool = false
    var itemValue:Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    //Mappable
    func mapping(map: Map) {
        itemName <- map["item_name"]
        itemThumnail <- map["item_thumnail"]
        itemDes <- map["item_des"]
        itemPrice <- map["item_price"]
        itemValue <- map["item_value"]
    }
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? BuildingItems else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
}


class Descriptions:Mappable, ListDiffable {
    
    var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    var desTitle:String?
    var des:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    //Mappable
    func mapping(map: Map) {
        desTitle <- map["des_title"]
        des <- map["des"]
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Descriptions else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
}

class DateData:ListDiffable {
    
    var diffable:String = "\(Int(arc4random_uniform(999999)))"
    
    var startDate:Date?
    var endDate:Date?
    var range:Int?
    
    func diffIdentifier() -> NSObjectProtocol {
        return diffable as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? DateData else { return false }
        return diffable.isEqual(toDiffableObject: object.diffable as ListDiffable) && diffable == object.diffable
    }
    
}
