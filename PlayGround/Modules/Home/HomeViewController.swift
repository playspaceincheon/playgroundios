//
//  ViewController.swift
//  PlayGround
//
//  Created by kim jason on 22/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import UIKit
import GoogleMaps
import MaterialComponents
import Material
import FontAwesome_swift
import Kingfisher

class HomeViewController: BaseViewController{
    
    let datas = DataManager.getDummyData()
    var listBGView:UIView!
    var tableView:UITableView!
    var mapView:GMSMapView!
    var mapBGView:UIView!
    var showFlag = false
    var mapClickedPostion = 99
    var markers:[GMSMarker] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.preapreViews()
        self.prepareNavi()
        self.prepareListView()
        
        mapBGView.snp.makeConstraints{ m in
            m.top.left.right.equalToSuperview()
            m.bottom.equalToSuperview().offset(-50-xBottomOffset)
        }
    }
}


extension HomeViewController {
    func preapreViews() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.497013, longitude: 126.677837, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapBGView = UIView()
        mapBGView.addSubview(mapView)
        mapView.snp.makeConstraints{ m in
            m.top.equalToSuperview()
            m.left.right.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        mapView.delegate = self
        
        for(_,value) in datas.enumerated() {
            let marker = GMSMarker()
            //        marker.icon = UIImage.fontAwesomeIcon(name: .mapPin, style: .solid, textColor: BBBlueColor, size: CGSize(width: 50, height: 50))
            let pinImg =  UIImage(named:"pin")!
            //        pinImg.tint(with: BBPinColor)
            
            marker.icon = imageWithImage(image: pinImg, scaledToSize: CGSize(width: 50, height: 50)).tint(tintColor: BBPinColor)
            marker.position = CLLocationCoordinate2D(latitude: Double(value.buildingLat!)!, longitude: Double(value.buildingLng!)!)
            self.markers.append(marker)
            
            
            marker.title = value.buildingName
            marker.snippet = value.buildingAddress
            marker.map = mapView
            marker.appearAnimation = .pop
        }
        
        view.addSubview(mapBGView)
    }
    
    func prepareNavi() {
        self.setNaviTitle(title: "노는공간")
        let image: UIImage = UIImage(named: "logo1")!
               let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
               imageView.contentMode = .scaleAspectFit
               imageView.image = image
               self.navigationItem.titleView = imageView
           
    }
    
    func prepareListView() {
        listBGView = UIView()
        listBGView.backgroundColor = BBWhiteColor
        self.roundCorners(view: listBGView, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 32)
        listBGView.layer.borderColor = BBGrey3Color.cgColor
        listBGView.layer.borderWidth = 0
        
        let closeTableView = IconButton(image: UIImage(named:"close")?.withRenderingMode(.alwaysTemplate).tint(tintColor: BBYellowColor))
        closeTableView.addTarget(self, action: #selector(self.hideListView), for: .touchUpInside)
        
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.tableView.backgroundColor = BBWhiteColor
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        self.tableView.register(BuildingListCell.self, forCellReuseIdentifier: BuildingListCell.ID)
        self.tableView.backgroundColor = BBWhiteColor
        
        listBGView.addSubview(tableView)
        listBGView.addSubview(closeTableView)
        closeTableView.snp.makeConstraints{ m in
            m.top.equalTo(8)
            m.centerX.equalToSuperview()
            m.width.height.equalTo(32)
        }
        tableView.snp.makeConstraints{ m in
            m.top.equalToSuperview().offset(48)
            m.left.right.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        self.view.addSubview(listBGView)
        listBGView.snp.makeConstraints{ m in
            m.height.equalTo(300)
            m.width.equalToSuperview()
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview().offset(300)
        }
        
        tableView.reloadData()
    }
    
    func showListView() {
        DispatchQueue.main.async {
            log?.debug("wow, show List!")
            
            self.listBGView.snp.updateConstraints{ m in
                m.bottom.equalTo(-58-xBottomOffset)
            }
            self.mapBGView.snp.removeConstraints()
            self.mapBGView.snp.makeConstraints{ m in
                m.top.left.right.equalToSuperview()
                m.bottom.equalTo(self.listBGView.snp.top).offset(48)
            }
            UIView.animate(withDuration: 0.33, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                self.tableView.reloadData()
            })
        }
    }
    
    @objc
    func hideListView() {
        self.mapClickedPostion = 99
        DispatchQueue.main.async {
            log?.debug("wow, hide List!")
            self.listBGView.snp.updateConstraints{ m in
                m.bottom.equalToSuperview().offset(300)
            }
            self.mapBGView.snp.removeConstraints()
            self.mapBGView.snp.makeConstraints{ m  in
                m.top.left.right.equalToSuperview()
                m.bottom.equalToSuperview().offset(-50-xBottomOffset)
            }
            UIView.animate(withDuration: 0.33, animations: {
                self.view.layoutIfNeeded()
                //            self.listBGView.center = CGPoint(x: self.view.center.x, y: self.view.frame.height + self.listBGView.frame.height / 2)
                
            }, completion: { (completed) in
                self.tableView.reloadData()
            })
        }
    }
}

extension HomeViewController:GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        log?.debug("wowwowwow tap maker!!")
        let position = marker.position
        let lat = "\(position.latitude)"
        let lng = "\(position.longitude)"
        mapView.selectedMarker = marker
        
        clickedPosition(lat: lat, lng: lng)
        if(showFlag) {
            self.hideListView()
            showFlag = false
            
        } else {
            self.showListView()
            showFlag = true
        }
        return true
    }
    
    
}


extension HomeViewController {
    
    func clickedPosition(lat:String, lng:String) {
        
        for(index, value) in datas.enumerated() {
            if(lat == value.buildingLat) {
                //찍은점과 위도가 같다면.
                let updateCamera = GMSCameraPosition(latitude: Double(value.buildingLat!)!, longitude: Double(value.buildingLng!)!, zoom: 18)
                mapView.animate(to: updateCamera)
                
                mapClickedPostion = index
                mapView.selectedMarker = self.markers[index]
            }
        }
    }
    
    func changeListPositon() {
        
    }
}


extension HomeViewController {
    func presentBuildingDetailView() {
        self.showProgress()
        ///Todo - 여기 고칠것
        let time : DispatchTime = DispatchTime.now() + Double(0.5)
        DispatchQueue.main.asyncAfter(deadline: time) {
            let data = self.datas[self.mapClickedPostion]
            let vc = BuildingDetailViewController()
            vc.data = data
            let bvc = BaseNavigationController(rootViewController: vc)
              if #available(iOS 13.0, *) {
            bvc.modalPresentationStyle = .overFullScreen
            }
            self.hideProgress()
            self.present(bvc, animated: true)
            
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        if(position == self.mapClickedPostion) {
            self.presentBuildingDetailView()
        } else {
            let data = self.datas[position]
            self.clickedPosition(lat: data.buildingLat!, lng: data.buildingLng!)
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BuildingListCell.ID) as! BuildingListCell
        let row = indexPath.row
        let data = self.datas[row]
        if(mapClickedPostion == 99) {
            cell.backgroundColor =
            BBWhiteColor
        } else {
            if(mapClickedPostion == row) {
                // 클릭한 곳과 똑같은 곳이라면
                cell.backgroundColor = BBYellowColor.withAlphaComponent(0.4)
                //살짝 알파값을 줍니다.
            } else {
                cell.backgroundColor =
                BBWhiteColor
            }
        }
        cell.addressLabel.text = data.buildingAddress
        cell.titleLabel.text = data.buildingName
        let imageUrl = URL(string: data.buildingThumnail!)
        cell.buildingThumnail.kf.setImage(with: imageUrl)
        cell.buildingThumnail.clipsToBounds = true
        cell.buildingThumnail.contentMode = .scaleToFill
        var tagStr = ""
        for(index,value) in (data.tagNames?.enumerated())! {
            tagStr += "#\(value) "
        }
        cell.tagLabel.text = tagStr
        cell.clipsToBounds = true
        
        return cell
    }
}
