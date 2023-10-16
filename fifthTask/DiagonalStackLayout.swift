//
//  DiagonalStackLayout.swift
//  fifthTask
//
//  Created by  Pavel Nepogodin on 15.10.23.
//

import SwiftUI

struct DiagonalStackLayout: Layout {
    var spacing: CGFloat? = nil
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        
        return CGSize(
            width: proposal.width ?? .zero,
            height: proposal.height ?? .zero
        )
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }
        
        let spacing = spacing(subviews: subviews)
        let maxHeight = (bounds.height - spacing.reduce(.zero, +)) / CGFloat(subviews.count)
        
        let placementProposal = ProposedViewSize(width: maxHeight, height: maxHeight)
        var nextY = bounds.maxY - maxHeight
        var nextX = bounds.minX
        
        let stepX = ((proposal.width ?? .zero) - maxHeight) / CGFloat(subviews.count - 1)
        
        for index in subviews.indices {
            subviews[index].place(
                at: CGPoint(x: nextX, y: nextY),
                proposal: placementProposal
            )
            nextY -= maxHeight + spacing[index]
            nextX += stepX
        }
    }
    
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            
            if let spacing {
                return spacing
            } else {
                return subviews[index].spacing.distance(
                    to: subviews[index + 1].spacing,
                    along: .vertical
                )
            }
        }
    }
}
