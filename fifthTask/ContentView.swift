//
//  ContentView.swift
//  fifthTask
//
//  Created by  Pavel Nepogodin on 15.10.23.
//

import SwiftUI

enum LayoutType: Int, CaseIterable {
    case vertical
    case horizontal
}

struct ContentView: View {
    @State private var layoutType = LayoutType.horizontal
    
    private var layout: any Layout {
        switch layoutType {
            case .horizontal:
                return HStackLayout()
            case .vertical:
                return DiagonalStackLayout(spacing: 0)
        }
    }
    
    private var nextLayout: LayoutType {
        LayoutType(rawValue: (layoutType.rawValue + 1) % LayoutType.allCases.count) ?? .vertical
    }
    
    var body: some View {
        AnyLayout(layout) {
            ForEach(0..<7) { _ in
                RoundedRectangle(cornerRadius: 15)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeInOut(duration: 0.5), value: layoutType)
        .onTapGesture {
            layoutType = nextLayout
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
