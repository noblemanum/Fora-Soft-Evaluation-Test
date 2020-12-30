//
//  CellDescriptor.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import UIKit

final class CellDescriptor {
    
    let reuseIdentifier: String
    let cellClass: AnyClass
    let configure: (UITableViewCell) -> Void
    
    init<CellType: UITableViewCell>(reuseIdentifier: String = String(describing: CellType.self),
                                    configuration: @escaping (CellType) -> Void) {
        self.reuseIdentifier = reuseIdentifier
        self.cellClass = CellType.self
        self.configure = { ($0 as? CellType).map(configuration) }
    }
}

extension UITableView {
    
    func registerCell(with descriptor: CellDescriptor) {
        register(descriptor.cellClass, forCellReuseIdentifier: descriptor.reuseIdentifier)
    }
    
    func dequeueCell(with descriptor: CellDescriptor, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
    }
}
