//
//  MainViewController.swift
//  AccordionCollectionView
//
//  Created by Ацкий Станислав on 05.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var sizingCell = ExpandCell.loadFromNib() as! ExpandCell
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearence()
    }

    // MARK: - Private methods
    
    private func setupAppearence() {
        let flowLayout = JumpAvoidingFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib = UINib(
            nibName: String(describing: ExpandCell.self),
            bundle: Bundle.main
        )
        collectionView.register(
            cellNib,
            forCellWithReuseIdentifier: String(describing: ExpandCell.self)
        )
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        let width = collectionView.bounds.width - 40
        
        sizingCell.frame = CGRect(
            origin: .zero,
            size: CGSize(width: width, height: 1000)
        )
        
        sizingCell.isSelected = isSelected
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        
        let size = sizingCell.systemLayoutSizeFitting(
            CGSize(width: width, height: .greatestFiniteMagnitude),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
        
        return size
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        24
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ExpandCell.self),
            for: indexPath
        ) as! ExpandCell
        cell.tag = indexPath.row
        cell.onCollapseButtonHandler = { tag in
            collectionView.deselectItem(at: IndexPath(item: tag, section: 0), animated: true)
        }
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        
        DispatchQueue.main.async {
            // DispatchQueue.main.async here for smooth animation
            
            // For autoscroll when cell expanded
            
            // Type 1 ( w/o insets (simple scroll to item)
            
//            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            
            // Type 2 ( with inset)
            
            guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
            
            let desiredOffset = attributes.frame.origin.y - 20
            let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
            let maxPossibleOffset = contentHeight - collectionView.bounds.height
            let finalOffset = max(min(desiredOffset, maxPossibleOffset), 0)
            collectionView.setContentOffset(
                CGPoint(x: 0, y: finalOffset),
                animated: true
            )
        }
        
        return true
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        shouldDeselectItemAt indexPath: IndexPath
    ) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
}
