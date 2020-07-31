//
//  ContentView.swift
//  Test
//
//  Created by Daniel Dähling on 07.07.20.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    
//    @State private var selectedColor : UIColor? = nil
//    let colors : [UIColor?] = [.red, .yellow, .green, .orange, .blue, .magenta, .purple, .black, .cyan]
//    private let padding : CGFloat = 10
//    private let numberOfColumns = 2
//    
//    var body: some View {
//        GeometryReader { proxy in
//            ScrollView {
//                LazyVGrid(columns: [
//                    GridItem(.fixed(proxy.size.width / 2 - padding / 2), spacing: padding, alignment: .leading),
//                    GridItem(.fixed(proxy.size.width / 2 - padding / 2), alignment: .trailing)
//                ], spacing: padding) {
//                    ForEach(0..<colors.count, id: \.self) { id in
//                        
//                        if selectedColor == colors[id] && id % 2 != 0 {
//                            Color.clear
//                        }
//                        
//                        RectangleView(proxy: proxy, colors: colors, id: id, selectedColor: selectedColor, padding: padding)
//                            .onTapGesture {
//                                withAnimation{
//                                    if selectedColor == colors[id] {
//                                        selectedColor = nil
//                                    } else {
//                                        selectedColor = colors[id]
//                                    }
//                                }
//                            }
//                        
//                        if selectedColor == colors[id] {
//                            Color.clear
//                            Color.clear
//                            Color.clear
//                        }
//                    }
//                }
//            }
//        }.padding(.all, 10)
//    }
//}
//
//struct RectangleView: View {
//    
//    var proxy: GeometryProxy
//    var colors : [UIColor?]
//    var id: Int
//    var selectedColor : UIColor?
//    var padding : CGFloat
//
//    var body: some View {
//        Color(colors[id]!)
//            .frame(width: calculateFrame(for: id), height: calculateFrame(for: id))
//            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .offset(y: resolveOffset(for: id))
//    }
//    
//    // Used to offset the boxes after the expanded one to compensate for missing padding
//    func resolveOffset(for id: Int) -> CGFloat {
//        guard let selectedColor = selectedColor, let selectedIndex = colors.firstIndex(of: selectedColor) else {
//            print("Zero padding offset for item \(id)")
//            return 0
//        }
//        if id > selectedIndex {
//            return -(padding * 2)
//        }
//        return 0
//    }
//    
//    func calculateFrame(for id: Int) -> CGFloat {
//        selectedColor == colors[id] ? proxy.size.width : proxy.size.width / 2 - 5
//    }
//}
