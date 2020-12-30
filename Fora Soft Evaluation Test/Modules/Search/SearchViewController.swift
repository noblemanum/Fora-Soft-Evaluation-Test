//
//  SearchViewController.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 25.12.2020.
//

import UIKit

protocol SearchViewInput: AnyObject {
    func setTitle(_ title: String)
    func showSearchBar(_ value: Bool)
    func fill(with data: [Album])
    func setLoading(_ loading: Bool)
}

protocol SearchViewOutput: AnyObject {
    func viewDidLoad()
    func didTriggerSearchEvent(with query: String)
    func didTriggerShowAlbumEvent(_ item: Album)
}

final class SearchViewController: UIViewController, SearchViewInput {
    
    var output: SearchViewOutput!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(stateView)
        
        stateView.state = .empty(Strings.Search.startSearch.rawValue)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            stateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemWidth = (view.bounds.width - 3 * Constants.itemSpacing) / 2
        collectionLayout.estimatedItemSize = CGSize(width: itemWidth, height: 300)
    }
    
    // MARK: - Input
    
    func showSearchBar(_ value: Bool) {
        navigationItem.searchController = value ? searchController : nil
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func fill(with data: [Album]) {
        collection = data
        collectionView.reloadData()
        
        stateView.state = .empty(Strings.Search.noResults.rawValue)
        stateView.isHidden = !data.isEmpty
    }
    
    func setLoading(_ loading: Bool) {
        stateView.isHidden = !loading
        stateView.state = .loading
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let itemSpacing: CGFloat = 16.0
    }
    
    private var collection = [Album]()
    
    private func clearData() {
        collection.removeAll()
        collectionView.reloadData()
    }
    
    // MARK: - UI
    
    private lazy var searchController: UISearchController = {
        let result = UISearchController(searchResultsController: nil)
        result.obscuresBackgroundDuringPresentation = false
        result.searchBar.placeholder = Strings.Search.placeholder.rawValue
        result.searchBar.delegate = self
        
        return result
    }()
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(value: Constants.itemSpacing)
        layout.minimumInteritemSpacing = Constants.itemSpacing
        layout.minimumLineSpacing = Constants.itemSpacing
        layout.scrollDirection = .vertical
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {        
        let result = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        result.registerCell(for: SearchResultCell.self)
        result.registerCell(for: UICollectionViewCell.self)
        result.backgroundColor = .white
        result.translatesAutoresizingMaskIntoConstraints = false
        result.keyboardDismissMode = .onDrag
        result.delegate = self
        result.dataSource = self
        
        return result
    }()
    
    private lazy var stateView = StateView()
}

// MARK: - Extensions

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didTriggerShowAlbumEvent(collection[indexPath.item])
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count == 1 ? 2 : collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < collection.endIndex else {
            return collectionView.dequeueCell(for: UICollectionViewCell.self, for: indexPath)
        }
        
        let cell = collectionView.dequeueCell(for: SearchResultCell.self, for: indexPath) as! SearchResultCell
        
        let item = collection[indexPath.item]
        
        cell.fill(with: SearchResultCell.ViewModel(
            url: item.artworkUrl,
            albumName: item.collectionName,
            artistName: item.artistName
        ))
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            clearData()
            output.didTriggerSearchEvent(with: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearData()
        stateView.isHidden = false
        stateView.state = .empty(Strings.Search.startSearch.rawValue)
    }
}
