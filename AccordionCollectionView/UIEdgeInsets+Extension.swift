//
//  UIEdgeInsets+Extension.swift
//  AccordionCollectionView
//
//  Created by Ацкий Станислав on 06.09.2021.
//

import UIKit

extension UIEdgeInsets {
    var horizontal: CGFloat {
        left + right
    }
    
    var vertical: CGFloat {
        top + bottom
    }
}
