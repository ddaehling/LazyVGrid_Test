//
//  ParallelStackView.swift
//  Test
//
//  Created by Daniel Dähling on 31.07.20.
//
//
import SwiftUI

struct ParallelStackView: View {
    
    @State private var selectedColor : UIColor? = nil
    @State private var selectedColorReversed : UIColor? = nil
    @State var colors : [UIColor?] = [nil, .red, nil, .yellow, nil, .green, nil, .orange, nil, .blue, nil, .magenta, nil, .purple, nil, .black, nil, .cyan]
    @State var colorsReversed : [UIColor?] = [nil, .cyan, nil, .black, nil, .purple, nil, .magenta, nil, .blue, nil, .orange, nil, .green, nil, .yellow, nil, .red]
    private let padding : CGFloat = 10
    private let numberOfColumns = 2
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: padding / 2) {
                        ForEach(0..<colors.count, id: \.self) { id in
                            if colors[id] == nil {
                                Color.clear.frame(
                                    width: proxy.size.width / 2 - padding / 2,
                                    height: colorsReversed[id+1] == selectedColorReversed || (colorsReversed[1] == selectedColorReversed && id == 0) ? proxy.size.width + padding : 0)
                            } else {
                                RectangleView(proxy: proxy, colors: colors, id: id, selectedColor: selectedColor, padding: padding)
                                    .onTapGesture {
                                        withAnimation{
                                            if selectedColor == colors[id] {
                                                selectedColor = nil
                                            } else {
                                                selectedColorReversed = nil
                                                selectedColor = colors[id]
                                                
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: padding / 2) {
                        ForEach(0..<colorsReversed.count, id: \.self) { id in
                            if colorsReversed[id] == nil {
                                Color.clear.frame(
                                    width: proxy.size.width / 2 - padding / 2,
                                    height: colors[id+1] == selectedColor || (colors[1] == selectedColor && id == 0) ? proxy.size.width + padding : 0)
                            } else {
                                RectangleView(proxy: proxy, colors: colorsReversed, id: id, selectedColor: selectedColorReversed, padding: padding)
                                    
                                    .onTapGesture {
                                        withAnimation{
                                            if selectedColorReversed == colorsReversed[id] {
                                                selectedColorReversed = nil
                                            } else {
                                                selectedColor = nil
                                                selectedColorReversed = colorsReversed[id]
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    .rotate3D()
                    .offset(x: resolveOffset(for: proxy))
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .topTrailing)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.padding(10)
    }
    
    func resolveOffset(for proxy: GeometryProxy) -> CGFloat {
        selectedColorReversed == nil ? proxy.size.width / 2 - padding / 2 : proxy.size.width
    }
}

extension View {
    func rotate3D() -> some View {
        modifier(StackRotation())
    }
}

struct StackRotation: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        let c = CATransform3DIdentity
        return ProjectionTransform(CATransform3DRotate(c, .pi, 0, 1, 0))
    }
}

struct RectangleView: View {
    
    var proxy: GeometryProxy
    var colors : [UIColor?]
    var id: Int
    var selectedColor : UIColor?
    var padding : CGFloat

    var body: some View {
        Color(colors[id]!)
            .frame(width: calculateFrame(for: id), height: calculateFrame(for: id))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func calculateFrame(for id: Int) -> CGFloat {
        selectedColor == colors[id] ? proxy.size.width : proxy.size.width / 2 - 5
    }
}



struct ParallelStackView_Previews: PreviewProvider {
    static var previews: some View {
        ParallelStackView()
    }
}
