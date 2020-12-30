//
//  AlbumCell.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import UIKit
import Kingfisher

final class AlbumCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct ViewModel {
        let artworkURL: URL
        let albumName: String
        let artistName: String
    }
    
    func fill(with viewModel: ViewModel) {
        artworkImageView.kf.setImage(with: viewModel.artworkURL)
        albumNameLabel.text = viewModel.albumName
        artistNameLabel.text = viewModel.artistName
    }
    
    // MARK: - Private
    
    private func configure() {
        contentView.addSubview(artworkImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            artworkImageView.widthAnchor.constraint(equalToConstant: 100.0),
            artworkImageView.heightAnchor.constraint(equalTo: artworkImageView.widthAnchor),
            artworkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            artworkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            artworkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0).withPriority(.defaultHigh),
            
            albumNameLabel.topAnchor.constraint(equalTo: artworkImageView.topAnchor),
            albumNameLabel.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 16.0),
            albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4.0),
            artistNameLabel.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 16.0),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
        ])
    }
    
    // MARK: - UI
    
    private lazy var artworkImageView: UIImageView = {
        let result = UIImageView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.contentMode = .scaleAspectFill
        result.layer.cornerRadius = 10.0
        result.layer.masksToBounds = true
        result.backgroundColor = .lightGray
        
        return result
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = .systemFont(ofSize: 16.0)
        
        return result
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = .systemFont(ofSize: 15.0)
        result.textColor = .lightGray
        
        return result
    }()
}

extension NSLayoutConstraint {
    
    func withPriority(_ value: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(rawValue: value)
        return self
    }
    
    func withPriority(_ value: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = value
        return self
    }
}
