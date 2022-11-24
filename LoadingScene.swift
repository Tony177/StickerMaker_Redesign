//
//  loadingScene.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 24/11/22.
//

import Foundation
import SpriteKit
import CoreGraphics

class LoadingScene: SKScene {
    let radius : CGFloat = CGFloat(100)
    var loading: SKSpriteNode!
    var loadingArray : [SKSpriteNode] = []
    
    private var loadingAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Loading")
    }
    
    private var loadingTexture: SKTexture {
        return loadingAtlas.textureNamed("1")
    }
    
    private var loadingIdleTextures: [SKTexture] {
        return [
            loadingAtlas.textureNamed("1"),
            loadingAtlas.textureNamed("2"),
            loadingAtlas.textureNamed("3"),
            loadingAtlas.textureNamed("4"),
            loadingAtlas.textureNamed("5"),
            loadingAtlas.textureNamed("6")
        ]
    }
    
    private func setupLoading() {
        var i = CGFloat(0)
        
        for e in loadingIdleTextures{
            loading = SKSpriteNode(texture: e, size: CGSize(width: 100, height: 100))
            loading.position = CGPoint(x: i, y: frame.height/2)
            i = i - CGFloat(100)
            addChild(loading)
            loadingArray.append(loading)
        }
        
    }
    
    override func didMove(to view: SKView) {
        self.setupLoading()
        self.startIdleAnimation()
    }
    
    func calcolateP (alpha:CGFloat) -> CGPoint {
        return CGPoint(x: radius * cos(alpha) + frame.width/2, y: radius * sin(alpha)+frame.height/2)
    }
    func startIdleAnimation() {
        var t : TimeInterval = 1.0
        for e in loadingArray{
            let movex = SKAction.moveTo(x: frame.width/2, duration: t)
            let movey = SKAction.moveTo(y:frame.height+50,duration: t)
            var moveR : [SKAction] = [movex]
            for i in stride(from: 0, to: CGFloat(4*CGFloat.pi), by: +0.1 as CGFloat){
                moveR.append(SKAction.move(to: calcolateP(alpha:i), duration: 0.01))
            }
            moveR.append(movey)
            let sequence = SKAction.sequence(moveR)
            e.run(sequence)
            t = t + 0.2
        }
    }
        
}
