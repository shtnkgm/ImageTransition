//
//  ItemListViewController.swift
//  Sample
//
//  Created by Shota Nakagami on 2019/03/24.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import ImageTransition

class ItemListViewController: UIViewController {
    
    private let margin: CGFloat = 20
    private let column: CGFloat = 2
    
    private let items: [Item] = ["kiwi", "strawberry", "apple", "orange", "tomato", "lemon"].map { Item(title: $0) }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: ItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    private func selectedCell() -> ItemCell? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? ItemCell else {
                assertionFailure()
                return nil
        }
        return selectedCell
    }
}

extension ItemListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = selectedCell(),
        let item = selectedCell.item else { return }
        
        let index = indexPath.row
        selectedCell.animationId = "\(index)_shadow"
        selectedCell.contentView.animationId = "\(index)_base"
        selectedCell.imageView.animationId = "\(index)_image"
        selectedCell.titleLabel.animationId = "\(index)_title"
        selectedCell.priceLabel.animationId = "\(index)_subtitle"

        let itemDetailViewController = ItemDetailViewController(item: item, index: indexPath.row)
        ImageTransitionDelegate.shared.pushDuration = 1//0.5
        ImageTransitionDelegate.shared.popDuration = 1//0.5
        navigationController?.delegate = ImageTransitionDelegate.shared
        navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}

extension ItemListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath)
        guard let itemCell = cell as? ItemCell else { fatalError() }
        guard let item = items.randomElement() else { fatalError() }
        itemCell.set(item: item)
        return cell
    }
}

extension ItemListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - margin * (column + 1)) / column
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}
