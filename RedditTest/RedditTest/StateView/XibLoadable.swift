//
//  XibLoadable.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit
 
protocol XibLoadable: class {
    var contentView: UIView? { get set }
    func setupXib(_ frame: CGRect)
}

extension XibLoadable where Self: UIView {
    func setupXib(_ frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = (nib.instantiate(withOwner: self, options: nil)[0] as? UIView) else { return }
        addSubview(nibView)
        
        nibView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nibView.leftAnchor.constraint(equalTo: self.leftAnchor),
            nibView.rightAnchor.constraint(equalTo: self.rightAnchor),
            nibView.topAnchor.constraint(equalTo: self.topAnchor),
            nibView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        addSubview(nibView)
        contentView = nibView
    }
}
