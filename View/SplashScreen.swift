//
//  SplashScreen.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 24/11/22.
//

import SwiftUI
import SpriteKit

struct SplashScreen: View {
    @Environment(\.colorScheme) var colorScheme
    var loading : SKScene {
        let scene = LoadingScene()
        scene.size = CGSize(width: 500, height: 700)
        scene.scaleMode = .fill
        scene.backgroundColor = (colorScheme == .light) ? SKColor.white : SKColor.black
        return scene
    }
    var body: some View {
            SpriteView(scene: loading)
            .ignoresSafeArea()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
