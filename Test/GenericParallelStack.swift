//
//  GenericParallelStack.swift
//  Test
//
//  Created by Daniel Dähling on 31.07.20.
//

import SwiftUI

import SwiftUI

struct GenericParallelStackView<T: Equatable, Content: View>: View {
    
    let padding : CGFloat
    let elements : [T]
    let content : (T) -> Content
    
    @State private var selectedElement : T? = nil
    @State private var selectedSecondElement : T? = nil
    
    
    var body: some View {
        
        let (transformedFirstArray, transformedSecondArray) = transformArray(array: elements)
        
        func resolveClearViewHeightForFirstArray(id: Int, for proxy: GeometryProxy) -> CGFloat {
            transformedSecondArray[id+1] == selectedSecondElement || (transformedSecondArray[1] == selectedSecondElement && id == 0) ? proxy.size.width + padding : 0
        }
        
        func resolveClearViewHeightForSecondArray(id: Int, for proxy: GeometryProxy) -> CGFloat {
            transformedFirstArray[id+1] == selectedElement || (transformedFirstArray[1] == selectedElement && id == 0) ? proxy.size.width + padding : 0
        }
        
        return GeometryReader { proxy in
            ScrollView {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: padding / 2) {
                        ForEach(0..<transformedFirstArray.count, id: \.self) { id in
                            if transformedFirstArray[id] == nil {
                                Color.clear.frame(
                                    width: proxy.size.width / 2 - padding / 2,
                                    height: resolveClearViewHeightForFirstArray(id: id, for: proxy))
                            } else {
                                RectangleView(proxy: proxy, elements: transformedFirstArray, id: id, selectedElement: selectedElement, padding: padding, content: content)
                                    .onTapGesture {
                                        withAnimation(.spring()){
                                            if selectedElement == transformedFirstArray[id] {
                                                selectedElement = nil
                                            } else {
                                                selectedSecondElement = nil
                                                selectedElement = transformedFirstArray[id]
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: padding / 2) {
                        ForEach(0..<transformedSecondArray.count, id: \.self) { id in
                            if transformedSecondArray[id] == nil {
                                Color.clear.frame(
                                    width: proxy.size.width / 2 - padding / 2,
                                    height: resolveClearViewHeightForSecondArray(id: id, for: proxy))
                            } else {
                                RectangleView(proxy: proxy, elements: transformedSecondArray, id: id, selectedElement: selectedSecondElement, padding: padding, content: content)
                                    
                                    .onTapGesture {
                                        withAnimation(.spring()){
                                            if selectedSecondElement == transformedSecondArray[id] {
                                                selectedSecondElement = nil
                                            } else {
                                                selectedElement = nil
                                                selectedSecondElement = transformedSecondArray[id]
                                            }
                                        }
                                    }.rotation3DEffect(.init(degrees: 180), axis: (x: 0, y: 1, z: 0))
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
        selectedSecondElement == nil ? proxy.size.width / 2 - padding / 2 : proxy.size.width
    }
    
    func transformArray<T: Equatable>(array: [T]) -> ([T?], [T?]) {
        var arrayTransformed : [T?] = []
        array.map { element -> (T?, T?) in
            return (nil, element)
        }.forEach {
            arrayTransformed.append($0.0)
            arrayTransformed.append($0.1)
        }
        arrayTransformed = arrayTransformed.reversed()
        
        var firstTransformedArray : [T?] = []
        var secondTransformedArray : [T?] = []
        
        for i in 0...arrayTransformed.count / 2 {
            guard let nilValue = arrayTransformed.popLast(), let element = arrayTransformed.popLast() else { break }
            if i % 2 == 0 {
                firstTransformedArray += [nilValue, element]
            } else {
                secondTransformedArray += [nilValue, element]
            }
        }
        return (firstTransformedArray, secondTransformedArray)
    }
    
    struct RectangleView: View {
        
        let proxy: GeometryProxy
        let elements : [T?]
        let id: Int
        let selectedElement : T?
        let padding : CGFloat
        let content : (T) -> Content

        var body: some View {
            content(elements[id]!)
                .frame(width: calculateFrame(for: id), height: calculateFrame(for: id))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        
        func calculateFrame(for id: Int) -> CGFloat {
            selectedElement == elements[id] ? proxy.size.width : proxy.size.width / 2 - 5
        }
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


