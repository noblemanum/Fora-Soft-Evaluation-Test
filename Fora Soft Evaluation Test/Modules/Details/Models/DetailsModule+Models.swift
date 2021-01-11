//
//  DetailsModule+Models.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

enum DetailsModule {
    
    typealias DataSource = TableViewDataSource<DetailsItem>
    
    enum DetailsItem {
        case header(AlbumCell.ViewModel)
        case track(SongCell.ViewModel)
    }
}
