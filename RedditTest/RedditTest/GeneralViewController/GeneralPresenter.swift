//
//  GeneralPresenter.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import Foundation

typealias GeneralLoadCompletion = ((ListState<PostCellModel>) -> Void)

protocol GeneralPresenter {
    func setupOutput(_ output: GeneralViewControllerInput)
    func getPosts()
    func getNewItems()
    func didSelect(_ originalURL: URL?)
}

final class GeneralPresenterImpl: GeneralPresenter {
    
    private let apiManager: APIManager
    private let navigator: Navigator

    private weak var output: GeneralViewControllerInput?
    
    private var listState: ListState<PostCellModel> = .loading {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.output?.handleStateChange(self.listState)
            }
        }
    }
    
    private var lastPageID: String?
    private var cellModels: [PostCellModel] = []
    private var isLoadingNewItems = false
    
    init(apiManager: APIManager, navigator: Navigator) {
        self.apiManager = apiManager
        self.navigator = navigator
    }
    
    func setupOutput(_ output: GeneralViewControllerInput) {
        self.output = output
    }

    func getPosts() {
        if isLoadingNewItems { return }
        isLoadingNewItems = true
        listState = .loading
        guard let url = URL.topPosts() else { return listState = .error(nil) }
        
        apiManager.fetch(with: url) { [weak self] (result: Result<TopPostsResult, Error>) -> Void in
            guard let self = self else { return }
            
            switch result {
            case .success(let postsEntity):
                guard !postsEntity.posts.isEmpty else { return self.listState = .empty }
                self.cellModels.removeAll()
                self.cellModels = postsEntity.posts.map{ PostCellModel(post: $0) }
                self.listState = .initial(items: self.cellModels)
                self.lastPageID = postsEntity.posts.last?.id
            case .failure(let error):
                self.listState = .error(error)
            }
            
            self.isLoadingNewItems = false
        }
    }
    
    func getNewItems() {
        guard let url = URL.topPosts(lastId: lastPageID), isLoadingNewItems == false else { return }
        isLoadingNewItems = true
        
        apiManager.fetch(with: url) { [weak self] (result: Result<TopPostsResult, Error>) -> Void in
            guard let self = self else { return }
            
            switch result {
            case .success(let postsEntity):
                guard !postsEntity.posts.isEmpty else { return self.listState = .empty }
                self.cellModels.append(contentsOf: postsEntity.posts.map{ PostCellModel(post: $0) })
                self.listState = .loadedMore(items: self.cellModels)
                self.lastPageID = postsEntity.posts.last?.id
            case .failure(let error):
                self.listState = .error(error)
            }
            
            self.isLoadingNewItems = false
        }
    }
    
    func didSelect(_ originalURL: URL?) {
        navigator.navigateToExternalLink(url: originalURL)
    }
}

private extension GeneralPresenterImpl {
    
}
