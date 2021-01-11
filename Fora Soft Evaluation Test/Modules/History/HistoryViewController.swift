//
//  HistoryViewController.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 25.12.2020.
//

import UIKit

protocol HistoryViewInput: AnyObject {
    func reload(with history: [String])
}

protocol HistoryViewOutput: AnyObject {
    func viewDidLoad()
    func didTriggerShowSearchResultEvent(_ query: String, in view: HistoryViewController)
    func didTriggerDeleteHistory()
}

class HistoryViewController: UIViewController, HistoryViewInput {

    var output: HistoryViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = clearHistoryButton
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        output.viewDidLoad()
    }
    
    // MARK: - Input
    
    func reload(with history: [String]) {
        self.history = history
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    private var history = [String]()
    
    @objc private func clearHistory() {
        output.didTriggerDeleteHistory()
    }
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let result = UITableView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.registerCell(for: HistoryCell.self)
        result.delegate = self
        result.dataSource = self
        
        return result
    }()
    
    private lazy var clearHistoryButton: UIBarButtonItem = {
        let result = UIBarButtonItem(barButtonSystemItem: .trash,
                                     target: self,
                                     action: #selector(clearHistory))
        
        return result
    }()
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.didTriggerShowSearchResultEvent(history[indexPath.row], in: self)
    }
}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(for: HistoryCell.self, for: indexPath)
        
        cell.textLabel?.text = history[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
