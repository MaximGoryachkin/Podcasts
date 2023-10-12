//
//  CaruselLayout.swift
//  Podcasts
//
//  Created by Максим Горячкин on 10.10.2023.
//

import Foundation
import UIKit

final class CarouselLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()

        scrollDirection = .horizontal
        minimumLineSpacing = 30
        itemSize = CGSize(width: 300, height: 300)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard let collectionView = collectionView else { return nil }
        return attributes.map({ transform(collectionView: collectionView, attribute: $0) })
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    private func transform(collectionView: UICollectionView, attribute: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let a = attribute
        let width = collectionView.frame.size.width
        let itemOffset = a.center.x - collectionView.contentOffset.x
        let middleOffset = (itemOffset / width) - 0.5

        change(
            width: collectionView.frame.size.width,
            attribute: attribute,
            middleOffset: middleOffset
        )

        return attribute
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

    private func change(width: CGFloat, attribute: UICollectionViewLayoutAttributes, middleOffset: CGFloat) {
        let alpha: CGFloat = 0.8
        let itemSpacing: CGFloat = 0.21
        let scale: CGFloat = 1.0

        let scaleFactor = scale - 0.3 * abs(middleOffset)
        let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

        let translationX = -(width * itemSpacing * middleOffset)
        let translationTransform = CGAffineTransform(translationX: translationX, y: 0)

        attribute.alpha = 1.0 - abs(middleOffset) + alpha
        attribute.transform = translationTransform.concatenating(scaleTransform)
    }
}
