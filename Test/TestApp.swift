//
//  TestApp.swift
//  Test
//
//  Created by Daniel Dähling on 07.07.20.
//

import SwiftUI

@main
struct TestApp: App {
    
    let colors : [UIColor] = [.red, .yellow, .green, .orange, .blue, .magenta, .purple, .black, .cyan, .cyan, .black, .purple, .magenta, .blue, .orange, .green, .yellow, .red]

    var body: some Scene {
        WindowGroup {
            GenericParallelStackView(padding: 10, elements: colors) { color in
                Color(color)
            }
        }
    }
}
