//
//  ExpandCell.swift
//  AccordionCollectionView
//
//  Created by Ацкий Станислав on 05.09.2021.
//

import UIKit

final class ExpandCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var mainContainer: UIView!
    @IBOutlet private var topContainer: UIView!
    @IBOutlet private var bottomContainer: UIView!
    @IBOutlet private var collapsedConstraint: NSLayoutConstraint!
    @IBOutlet private var expandedConstraint: NSLayoutConstraint!
    @IBOutlet private var arrowImageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    
    // MARK: - Public vars
    
    var onCollapseButtonHandler: ((Int) -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupAppearence()
    }
    
    override var isSelected: Bool {
        didSet { updateAppearence() }
    }
    
    // If interaction with bottom container not needed
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        topContainer.point(inside: point, with: event)
    }
    
    // MARK: - Private methods
    
    private func updateAppearence() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected
        
        let angle = CGAffineTransform(rotationAngle: .pi * -0.999)
        
        UIView.animate(withDuration: 0.3) {
            self.arrowImageView.transform = self.isSelected ? angle : .identity
        }
    }
    
    private func setupAppearence() {
        
        // Add gesture recognizer w/o target to interception all interaction
        // All buttons would working perfectly
        
//        let gestureRecognizer = UIGestureRecognizer()
//        addGestureRecognizer(gestureRecognizer)
        
        let text = "jdsabvuag vuygasduvygadsuiygvi aydgviuysdgvuysadgvuy"
        let mText = text + text + text
        textLabel.text = mText
        
        contentView.layer.cornerRadius = 10
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
    }
}
