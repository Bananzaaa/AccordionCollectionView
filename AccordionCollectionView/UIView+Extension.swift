//
//  UIView+Extension.swift
//  AccordionCollectionView
//
//  Created by Ацкий Станислав on 05.09.2021.
//

import UIKit.UIView

extension UIView {
    
    class func loadNib() -> UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func loadFromNib() -> UIView? {
        Bundle.main.loadNibNamed(
            String(describing: self),
            owner: self,
            options: nil
        )?.first as? UIView
    }
}
