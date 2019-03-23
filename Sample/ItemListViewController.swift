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
    
    private let margin: CGFloat = 1
    private let column: CGFloat = 3
    
    private let items: [String] = ["kiwi", "strawberry", "apple", "orange", "tomato", "lemon"]
    
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

extension ItemListViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        guard let selectedCell = selectedCell() else { return nil }
        return selectedCell.imageView
    }
}

extension ItemListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = selectedCell(),
        let image = selectedCell.imageView.image,
        let title = selectedCell.titleLabel.text else { return }
        
        let destinationViewController = ItemDetailViewController(dependency: .init(image: image, title: title))
        navigationController?.delegate = ImageTransitionDelegate.shared
        ImageTransitionDelegate.shared.dismissDuration = 1
        ImageTransitionDelegate.shared.presentDuration = 1
        navigationController?.pushViewController(destinationViewController, animated: true)
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
        itemCell.set(image: UIImage(named: item), title: item)
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
