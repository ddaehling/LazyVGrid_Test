//
//  PoolView_delete.swift
//  Test
//
//  Created by Daniel Dähling on 31.07.20.
//

import SwiftUI
import Foundation

struct ColorManager {
    // create static variables for custom colors
    static let flipBackground = Color("flipBackground")
    static let flipDarkGreen = Color ("flipDarkGreen")
    static let flipLighterDarkBackground = Color("flipLighterDarkBackground")
    
    static var gameViewGradient : LinearGradient {
        LinearGradient(
            gradient: Gradient(
                stops: [
                    Gradient.Stop(color: self.flipBackground.opacity(1), location: 0),
                    Gradient.Stop(color: self.flipBackground.opacity(0.35), location: 0.3),
                    Gradient.Stop(color: self.flipBackground.opacity(0), location: 0.5),
                    Gradient.Stop(color: self.flipBackground.opacity(0.35), location: 0.7),
                    Gradient.Stop(color: self.flipBackground.opacity(1), location: 1)
                ]),
            startPoint: .top,
            endPoint: .bottom)
    }
}

struct PoolItemView: View {
    
    let poolName : String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .foregroundColor(ColorManager.flipLighterDarkBackground)
            
            VStack(alignment: .leading) {
                Text(poolName)
                    .padding([.top, .leading])
                    .foregroundColor(.white)
                    .font(.custom("Merriweather-Italic", size: 18))
                Spacer()
                HStack {
                    Image(systemName: "arrow.down.to.line.alt")
                        .foregroundColor(.white)
                        .font(.system(size: 23))
                    
                    Spacer()
                    
                    Image(systemName: "list.dash")
                        .foregroundColor(.white)
                        .font(.system(size: 23))
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 23))
                }
                .padding([.leading, .bottom, .trailing], 20.0)
            }
        }
    }
}

struct PoolItemView_Preview: PreviewProvider {
    static var previews: some View {
        PoolItemView(poolName: "Test")
    }
}
