//
//  SearchRouter.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 26.12.2020.
//

import Foundation

protocol SearchRouterInput: AnyObject {
    func showAlbum(_ album: Album)
}

final class SearchRouter: Router, SearchRouterInput {
    
    func showAlbum(_ album: Album) {
        let factory = ModuleFactory()
        let (detailsView, _) = factory.makeDetailsModule(viewController: viewController, album: album)
        
        push(viewController: detailsView)
    }
}
