//
//  SongCell.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import UIKit

final class SongCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct ViewModel {
        let trackNumber: Int
        let trackName: String
        let trackTimeMillis: Int
    }
    
    func fill(with viewModel: ViewModel) {
        trackNumberLabel.text = String(viewModel.trackNumber)
        trackNameLabel.text = viewModel.trackName
        trackTimeLabel.text = viewModel.trackTimeMillis.asString(style: .positional)
    }
    
    // MARK: - Private
    
    private func configure() {
        contentView.addSubview(trackNumberLabel)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(trackTimeLabel)
        
        NSLayoutConstraint.activate([
            trackNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            trackNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            trackNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            trackNumberLabel.widthAnchor.constraint(equalToConstant: 20.0),
            
            trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            trackNameLabel.leadingAnchor.constraint(equalTo: trackNumberLabel.trailingAnchor, constant: 16.0),
            trackNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            
            trackTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            trackTimeLabel.leadingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor, constant: 16.0),
            trackTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            trackTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
        ])
    }
    
    // MARK: - UI
    
    private lazy var trackNumberLabel: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = .systemFont(ofSize: 16.0)
        result.textAlignment = .center
        
        return result
    }()
    
    private lazy var trackNameLabel: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = .systemFont(ofSize: 16.0)
        
        return result
    }()
    
    private lazy var trackTimeLabel: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = .systemFont(ofSize: 16.0)
        
        return result
    }()
}
