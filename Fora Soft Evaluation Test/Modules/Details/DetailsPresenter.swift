//
//  DetailsPresenter.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import Foundation

protocol DetailsModuleInput: AnyObject {
}

protocol DetailsModuleOutput: AnyObject {
}

final class DetailsPresenter: DetailsModuleInput, DetailsViewOutput {
    
    weak var view: DetailsViewInput!
    var router: DetailsRouter!
    weak var output: DetailsModuleOutput?
    
    init(album: Album) {
        self.album = album
    }
    
    // MARK: - DetailsModuleInput
    
    func viewDidLoad() {
        loadSongs(with: album)
    }
    
    // MARK: - Private
    
    private let album: Album
    private let dataSource = DetailsModule.DataSource()
    private let songsProvider = SongsProvider.shared
    
    private func loadSongs(with album: Album) {
        view.setLoading(true)
        songsProvider.getSongs(forAlbum: album.collectionId) {
            result in
            
            self.view.setLoading(false)
            
            switch result {
            case .success(var songs):
                let header: DetailsModule.DetailsItem = .header(AlbumCell.ViewModel(artworkURL: album.artworkUrl,
                                                                                    albumName: album.collectionName,
                                                                                    artistName: album.artistName))
                
                var items: [DetailsModule.DetailsItem] = [header]
                
                songs.sort { $0.discNumber < $1.discNumber && $0.trackNumber < $1.trackNumber}
                let tracks: [DetailsModule.DetailsItem] = songs.map { song in
                    return .track(SongCell.ViewModel(trackNumber: song.trackNumber,
                                                     trackName: song.trackName,
                                                     trackTimeMillis: song.trackTimeMillis))
                }
                
                items.append(contentsOf: tracks)
                self.dataSource.reload(with: items)
                self.view.fill(with: self.dataSource)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
