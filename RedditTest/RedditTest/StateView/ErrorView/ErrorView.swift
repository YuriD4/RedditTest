//
//  ErrorView.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

final class ErrorView: UIView, XibLoadable, StateView {

    @IBOutlet private weak var messageLabel: UILabel!
    
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
        messageLabel.textColor = UIColor.black
    }
    
    func show() {
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }
}

// MARK: Public interface

extension ErrorView {
    
    func configure(with error: Error) {
        messageLabel.text = error.localizedDescription
    }
    
    func configure(with message: String) {
        messageLabel.text = message
    }
}

