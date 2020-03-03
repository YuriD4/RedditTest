//
//  PostCell.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

final class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    private var onTapCallback: ((_ originalURL: URL?) -> Void)?
    var tap: UITapGestureRecognizer?
    
    private var id: String?
    private var originalURL: URL?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        guard let tap = tap else { return }
        tap.delegate = self
        thumbnailImageView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        onTapCallback?(originalURL)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.isHidden = false
        thumbnailImageView.image = nil
    }
}

// MARK: - public interface

extension PostCell {
    @discardableResult func configure(with viewModel: PostCellModel) -> PostCell {
        id = viewModel.id
        originalURL = viewModel.originalURL
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.authorName
        timeLabel.text = viewModel.createdTime
        commentsLabel.text = viewModel.numberOfComments
        
        if let url = viewModel.thumbnailURL,
           UIApplication.shared.canOpenURL(url)
        {
            thumbnailImageView.load(url: url)
        } else {
            thumbnailImageView.isHidden = true
        }
        
        return self
    }
    
    @discardableResult func onTap(callback: @escaping (_ originalURL: URL?) -> Void) -> PostCell {
        onTapCallback = callback
        return self
    }
}
