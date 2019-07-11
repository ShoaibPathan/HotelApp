//
//  HomeViewController.swift
//  HotelApp
//
//  Created by Omar Thamri on 08/07/2019.
//  Copyright © 2019 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var searchTextField: UITextField = {
       let stf = UITextField()
        stf.placeholder = "Search"
        stf.borderStyle = .none
        stf.layer.cornerRadius = 30
        stf.clipsToBounds = true
        stf.setLeftPaddingPoints(20)
        stf.layer.borderWidth = 2
        stf.layer.borderColor = UIColor.orange.cgColor
        stf.translatesAutoresizingMaskIntoConstraints = false
        return stf
    }()
    
    var leftAnchor: NSLayoutConstraint?
    
    let navDrawerView : NavDrawerView = {
       let ndv = NavDrawerView()
       ndv.translatesAutoresizingMaskIntoConstraints = false
       return ndv
    }()
    
    var widthNavDrawer: CGFloat?
    
     let currentWindow: UIWindow? = UIApplication.shared.keyWindow
    
    var recommendedHotels: [Hotel]?
    
    var passedHotel: Hotel? 
    
    lazy var cityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let cvv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvv.dataSource = self
        cvv.delegate = self
        cvv.translatesAutoresizingMaskIntoConstraints = false
        return cvv
    }()
    
    lazy var recommondedHotelView : RecommandedHotelView = {
       let rhv = RecommandedHotelView(frame: .zero)
        rhv.translatesAutoresizingMaskIntoConstraints = false
        rhv.homeViewController = self
        return rhv
    }()
    
    let cityId = "cityId"
    let cityArray = [City(name: "New York",imageName: "newyork"),City(name: "Paris",imageName: "paris"),City(name: "London",imageName: "london"),City(name: "Dubai",imageName: "dubai"),City(name: "London",imageName: "london"),City(name: "New York",imageName: "newyork")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavigationBar()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        view.addSubview(searchTextField)
        view.addSubview(cityCollectionView)
        view.addSubview(recommondedHotelView)
        cityCollectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: cityId)
        cityCollectionView.backgroundColor = UIColor.white
        currentWindow?.addSubview(navDrawerView)
    }
    
    func setupConstraints() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchTextField]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-84-[v0(60)]-20-[v1(110)]-20-[v2]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchTextField,"v1":cityCollectionView,"v2":recommondedHotelView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":cityCollectionView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommondedHotelView]))
        widthNavDrawer = (currentWindow?.frame.width)! * 2 / 3
        navDrawerView.widthAnchor.constraint(equalToConstant: widthNavDrawer!).isActive = true
        navDrawerView.heightAnchor.constraint(equalTo: (currentWindow?.heightAnchor)!).isActive = true
       leftAnchor = navDrawerView.leftAnchor.constraint(equalTo: (currentWindow?.leftAnchor)!,constant: -widthNavDrawer!)
        leftAnchor?.isActive = true
        navDrawerView.topAnchor.constraint(equalTo: (currentWindow?.topAnchor)!).isActive = true
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Home"
        navigationController?.navigationBar.barTintColor = UIColor.orange
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(showNavigationDrawer))
        leftBarButtonItem.tintColor = UIColor.white
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "moree"), style: .plain, target: self, action: #selector(showNavigationDrawer))
        rightBarButtonItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func showNavigationDrawer() {
        leftAnchor?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.currentWindow?.layoutIfNeeded()
            self.currentWindow?.updateConstraints()
            self.currentWindow?.setNeedsLayout()
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        })
        
    }
    
    func displayDetailHotel() {
        let hotelDetailViewController = HotelDetailViewController()
        hotelDetailViewController.hotel = passedHotel
        navigationController?.pushViewController(hotelDetailViewController, animated: true)
    }
    
    func showMoreRecommendedHotels() {
        let moreHotelViewController = MoreHotelViewController()
        moreHotelViewController.recommendedHotels = recommendedHotels
        navigationController?.pushViewController(moreHotelViewController, animated: true)
    }
    
    

}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: cityId, for: indexPath) as! CityCollectionViewCell
        cell.city = cityArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
