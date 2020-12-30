//
//  TableViewDataSource.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import UIKit

final class TableViewDataSource<T>: NSObject, UITableViewDataSource {
    
    var cellDescriptorCreator: ((_ item: T, _ index: Int) -> CellDescriptor)?
    
    private(set) var rows = [T]()
    
    func reload(with rows: [T]) {
        self.rows = rows
    }
    
    func clear() {
        reload(with: [])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        guard let descriptor = cellDescriptorCreator?(rows[index], index) else {
            return UITableViewCell()
        }
        
        tableView.registerCell(with: descriptor)
        let cell = tableView.dequeueCell(with: descriptor, for: indexPath)
        descriptor.configure(cell)
        
        return cell
    }
}
