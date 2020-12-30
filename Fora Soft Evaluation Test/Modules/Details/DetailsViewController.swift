//
//  DetailsViewController.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import UIKit

protocol DetailsViewInput: AnyObject {
    func fill(with dataSource: DetailsModule.DataSource)
    func setLoading(_ loading: Bool)
}

protocol DetailsViewOutput: AnyObject {
    func viewDidLoad()
}

final class DetailsViewController: UIViewController, DetailsViewInput {    
    
    var output: DetailsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(stateView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        output.viewDidLoad()
    }
    
    // MARK: - Input
    
    func fill(with dataSource: DetailsModule.DataSource) {
        dataSource.cellDescriptorCreator = {
            item, _ in
            
            switch item {
            case .header(let viewModel):
                return CellDescriptor {
                    (cell: AlbumCell) in
                    
                    cell.fill(with: viewModel)
                }
                
            case .track(let viewModel):
                return CellDescriptor {
                    (cell: SongCell) in
                    
                    cell.fill(with: viewModel)
                }
            }
        }
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func setLoading(_ loading: Bool) {
        loading ? (tableView.separatorStyle = .none) : (tableView.separatorStyle = .singleLine)
        stateView.isHidden = !loading
        stateView.state = .loading
    }
    
    // MARK: - Private
    
    private var songs = [Song]()
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let result = UITableView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.allowsSelection = false
        
        return result
    }()
    
    private lazy var stateView = StateView()
}
