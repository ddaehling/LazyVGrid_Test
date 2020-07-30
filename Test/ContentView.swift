//
//  ContentView.swift
//  Test
//
//  Created by Daniel Dähling on 07.07.20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedColor : UIColor? = nil
    @State private var colors : [UIColor] = [.red, .yellow, .green, .orange, .blue, .magenta, .purple, .black]
    @Namespace private var lists

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 10) {
                    LazyVGrid(columns: [
                        GridItem(.fixed(proxy.size.width / 2 - 5), spacing: 10, alignment: .leading),
                        GridItem(.fixed(proxy.size.width / 2 - 5))
                    ]) {
                        ForEach(0..<colors.count, id: \.self) { id in
                            
                            if selectedColor == colors[id] && id % 2 != 0 {
                                Color.clear
                            }

                            RectangleView(proxy: proxy, colors: colors, id: id, selectedColor: selectedColor)
                                .onTapGesture {
                                    withAnimation{
                                        if selectedColor == colors[id] {
                                            selectedColor = nil
                                        } else {
                                            selectedColor = colors[id]
                                        }
                                    }
                                }
                            
                            if selectedColor == colors[id] {
                                if id <= colors.count - 3 {
                                    if id % 2 != 0 {
                                        Color.clear
                                        Color.clear
                                    } else {
                                        Color.clear
                                        Color.clear
                                        Color.clear
                                    }
                                } else if id == colors.count - 2 {
                                    Color.clear
                                    Color.clear
                                }
                            }
                        }
                    }
                }
            }
        }.padding(.all, 10)
        
    }
    
    
}

struct RectangleView: View {
    
    var proxy: GeometryProxy
    var colors : [UIColor]
    var id: Int
    var selectedColor : UIColor?

    var body: some View {
        Color(colors[id])
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: selectedColor == colors[id] ? proxy.size.width : proxy.size.width / 2 - 5, height: selectedColor == colors[id] ? proxy.size.width : proxy.size.width / 2 - 5)
            .layoutPriority(selectedColor == colors[id] ? 1 : 0)
            .offset(y: resolveOffset(for: id))
            
    }
    
    
    // Used to offset the boxes after the expanded one to compensate for the missing padding
    func resolveOffset(for id: Int) -> CGFloat {
        guard let selectedColor = selectedColor, let selectedIndex = colors.firstIndex(of: selectedColor) else { return 0 }
        if id > selectedIndex {
            return -18
        }
        return 0
    }
    
    
}
