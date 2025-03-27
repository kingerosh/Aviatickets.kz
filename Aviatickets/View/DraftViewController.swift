//
//  DraftViewController.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 08.03.2025.
//

import UIKit
import SnapKit

class DraftViewController: UIViewController {
    
    private var rect: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var circle = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(rect)
        
        rect.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        view.addSubview(circle)
        circle.backgroundColor = .blue
        circle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rect.snp.bottom).offset(10)
            make.width.height.equalTo(100)
        }
        circle.layer.cornerRadius = 100 / 2
        
    }
}
