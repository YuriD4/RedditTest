//
//  LoaderView.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

final class LoaderView: UIView, XibLoadable, StateView {

    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib(frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib(bounds)
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
    func show() {
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }
}

