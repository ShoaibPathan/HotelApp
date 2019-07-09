//
//  PaymentViewController.swift
//  HotelApp
//
//  Created by Omar Thamri on 09/07/2019.
//  Copyright © 2019 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class PaymentViewController:UIViewController {
    
    let cardView: CardView = {
       let cv = CardView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.cornerRadius = 10
        cv.layer.masksToBounds = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraints()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Make Payment"
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        view.addSubview(cardView)
    }
    
    func setupConstraints() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":cardView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-74-[v0(\(view.frame.height / 3.5))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":cardView]))
    }
    
    
}
