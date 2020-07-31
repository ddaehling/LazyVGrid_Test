//
//  TestApp.swift
//  Test
//
//  Created by Daniel Dähling on 07.07.20.
//

import SwiftUI

@main
struct TestApp: App {
    let pool = ["Grundlagen 1", "Grundlagen 2", "Grundlagen 3", "Ovid", "Tacitus", "Martial", "Horaz", "Vergil"]
//    let colors : [UIColor] = [.red, .yellow, .green, .orange, .blue, .magenta, .purple, .black, .cyan, .cyan, .black, .purple, .magenta, .blue, .orange, .green, .yellow, .red]

    var body: some Scene {
        WindowGroup {
            GenericParallelStackView(padding: 10, elements: pool) { item in
                PoolItemView(poolName: item)
            }
        }
    }
}
