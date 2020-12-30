//
//  StateView.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import UIKit

final class StateView: UIView {
    
    enum State {
        case loading
        case empty(String)
    }
    
    var state: State = .loading {
        didSet {
            updateState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private lazy var loadingIndicator = UIActivityIndicatorView()
    
    private lazy var textLabel: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        result.textAlignment = .center
        result.textColor = .lightGray
        
        return result
    }()
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        [loadingIndicator, textLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16.0),
            textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16.0),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        updateState()
    }
    
    private func updateState() {
        switch state {
        case .empty(let text):
            textLabel.isHidden = false
            loadingIndicator.isHidden = true
            textLabel.text = text
        case .loading:
            textLabel.isHidden = true
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        }
    }
}
