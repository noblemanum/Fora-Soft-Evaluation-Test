//
//  SearchPresenter.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 26.12.2020.
//

import Foundation

enum SearchModuleType {
    case `default`
    case query(String)
}

protocol SearchModuleInput: AnyObject {
}

protocol SearchModuleOutput: AnyObject {
}

final class SearchPresenter: SearchModuleInput, SearchViewOutput {
    
    weak var view: SearchViewInput!
    var router: SearchRouter!
    weak var output: SearchModuleOutput?
    
    init(type: SearchModuleType = .default) {
        self.type = type
    }
    
    // MARK: - SearchViewOutput
    
    func viewDidLoad() {
        switch type {
        case .query(let query):
            view.showSearchBar(false)
            view.setTitle(query)
            loadAlbums(with: query)
            
        case .default:
            view.showSearchBar(true)
        }
    }
    
    func didTriggerSearchEvent(with query: String) {
        loadAlbums(with: query)
        historyService.addQuery(query)
    }
    
    func didTriggerShowAlbumEvent(_ item: Album) {
        router.showAlbum(item)
    }
    
    // MARK: - SearchModuleInput
    
    // MARK: - Private
    
    private let type: SearchModuleType
    private let albumsProvider = AlbumsProvider.shared
    private let historyService = SearchHistoryService.shared
    
    private func loadAlbums(with term: String) {
        view.setLoading(true)
        albumsProvider.getAlbums(ofTerm: term) {
            result in
            
            self.view.setLoading(false)
            
            switch result {
            case .success(let albums):
                self.view.fill(with: albums)
            case .failure(let error):
                print(error)
            }
        }
    }
}
