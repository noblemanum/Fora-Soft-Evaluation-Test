//
//  SearchResultCell.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import UIKit
import Kingfisher

class SearchResultCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct ViewModel {
        let url: URL
        let albumName: String
        let artistName: String
    }
    
    func fill(with viewModel: ViewModel) {
        albumImageView.kf.setImage(with: viewModel.url)
        albumLabel.text = viewModel.albumName
        artistNameLabel.text = viewModel.artistName
    }
    
    // MARK: - Overrides
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.size = systemLayoutSizeFitting(layoutAttributes.size,
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
        return attributes
    }
    
    // MARK: - Private
    
    private func configure() {
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumLabel)
        contentView.addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            albumLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 4.0),
            albumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 4.0),
            artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - UI
    
    private lazy var albumImageView: UIImageView = {
        let result = UIImageView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.contentMode = .scaleAspectFill
        result.layer.cornerRadius = 10.0
        result.layer.masksToBounds = true
        result.backgroundColor = .lightGray
        
        return result
    }()
    
    private lazy var albumLabel: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = .systemFont(ofSize: 16.0)
        result.textColor = .black
        
        return result
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = .systemFont(ofSize: 16.0)
        result.textColor = .lightGray
        
        return result
    }()
}
