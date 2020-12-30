//
//  UICollectionView+ForaSoft.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 30.12.2020.
//

import UIKit

extension UICollectionView {
    
    func registerCell(for cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueCell(for cellClass: AnyClass, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath)
    }
}
