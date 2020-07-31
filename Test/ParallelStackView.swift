//
//  ParallelStackView.swift
//  Test
//
//  Created by Daniel Dähling on 31.07.20.
//
//
//import SwiftUI
//
//struct ParallelStackView: View {
//    
//    let padding : CGFloat
//    let firstElementArray : [UIColor]
//    let secondElementArray : [UIColor]
//    
//    @State private var selectedColor : UIColor? = nil
//    @State private var selectedColorReversed : UIColor? = nil
//    
//    
//    var body: some View {
//        
//        var transformedFirstArray : [UIColor?] {
//            transformArray(array: firstElementArray)
//        }
//        
//        var transformedSecondArray : [UIColor?] {
//            transformArray(array: secondElementArray)
//        }
//        
//        func resolveClearViewHeightForFirstArray(id: Int, for proxy: GeometryProxy) -> CGFloat {
//            transformedSecondArray[id+1] == selectedColorReversed || (transformedSecondArray[1] == selectedColorReversed && id == 0) ? proxy.size.width + padding : 0
//        }
//        
//        func resolveClearViewHeightForSecondArray(id: Int, for proxy: GeometryProxy) -> CGFloat {
//            transformedFirstArray[id+1] == selectedColor || (transformedFirstArray[1] == selectedColor && id == 0) ? proxy.size.width + padding : 0
//        }
//        
//        return GeometryReader { proxy in
//            ScrollView {
//                ZStack(alignment: .topLeading) {
//                    VStack(alignment: .leading, spacing: padding / 2) {
//                        ForEach(0..<transformedFirstArray.count, id: \.self) { id in
//                            if transformedFirstArray[id] == nil {
//                                Color.clear.frame(
//                                    width: proxy.size.width / 2 - padding / 2,
//                                    height: resolveClearViewHeightForFirstArray(id: id, for: proxy))
//                            } else {
//                                RectangleView(proxy: proxy, colors: transformedFirstArray, id: id, selectedColor: selectedColor, padding: padding)
//                                    .onTapGesture {
//                                        withAnimation(.spring()){
//                                            if selectedColor == transformedFirstArray[id] {
//                                                selectedColor = nil
//                                            } else {
//                                                selectedColorReversed = nil
//                                                selectedColor = transformedFirstArray[id]
//                                                
//                                            }
//                                        }
//                                    }
//                            }
//                        }
//                    }
//                    VStack(alignment: .leading, spacing: padding / 2) {
//                        ForEach(0..<transformedSecondArray.count, id: \.self) { id in
//                            if transformedSecondArray[id] == nil {
//                                Color.clear.frame(
//                                    width: proxy.size.width / 2 - padding / 2,
//                                    height: resolveClearViewHeightForSecondArray(id: id, for: proxy))
//                            } else {
//                                RectangleView(proxy: proxy, colors: transformedSecondArray, id: id, selectedColor: selectedColorReversed, padding: padding)
//                                    
//                                    .onTapGesture {
//                                        withAnimation(.spring()){
//                                            if selectedColorReversed == transformedSecondArray[id] {
//                                                selectedColorReversed = nil
//                                            } else {
//                                                selectedColor = nil
//                                                selectedColorReversed = transformedSecondArray[id]
//                                            }
//                                        }
//                                    }
//                            }
//                        }
//                    }
//                    .rotate3D()
//                    .offset(x: resolveOffset(for: proxy))
//                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .topTrailing)
//                }.frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//        }.padding(10)
//    }
//    
//    
//    
//    func resolveOffset(for proxy: GeometryProxy) -> CGFloat {
//        selectedColorReversed == nil ? proxy.size.width / 2 - padding / 2 : proxy.size.width
//    }
//    
//    func transformArray(array: [UIColor]) -> [UIColor?] {
//        var arrayTransformed = array.map { Optional($0) }
//        for element in arrayTransformed {
//            guard let firstIndex = arrayTransformed.firstIndex(of: element) else { break }
//            arrayTransformed.insert(nil, at: firstIndex)
//        }
//        return arrayTransformed
//    }
//}
//
//extension View {
//    func rotate3D() -> some View {
//        modifier(StackRotation())
//    }
//}
//
//struct StackRotation: GeometryEffect {
//    func effectValue(size: CGSize) -> ProjectionTransform {
//        let c = CATransform3DIdentity
//        return ProjectionTransform(CATransform3DRotate(c, .pi, 0, 1, 0))
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
//    }
//    
//    func calculateFrame(for id: Int) -> CGFloat {
//        selectedColor == colors[id] ? proxy.size.width : proxy.size.width / 2 - 5
//    }
//}
