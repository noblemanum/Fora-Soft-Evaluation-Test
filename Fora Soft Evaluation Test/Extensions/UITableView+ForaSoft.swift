//
//  UITableView+ForaSoft.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 30.12.2020.
//

import UIKit

extension UITableView {
    
    func registerCell(for cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueCell(for cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath)
    }
}

