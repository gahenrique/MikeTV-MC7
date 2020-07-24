//
//  Scene0.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 14/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import AVFoundation
import SpriteKit

class Scene0: BaseGameScene {
    
//    private var storyLine: SKLabelNode?
//    private var timer: Timer?
    private var backgroundImg: SKSpriteNode?
    private var backgroundFrames: [SKTexture] = []
    
    private var canTap: Bool = false
    private var countLines: Int = 0
    
    private let soundNode = SKAudioNode(fileNamed: "firework.mp3")
    
//    let url = Bundle.main.url(forResource: "firework", withExtension: "mp3")
//    private var audioPlayer = AVAudioPlayer()
    
    // MARK: colocar falas no model
    let arrayLines: [String] = ["O que é isso?", "Fogos de artificio? Aqui no palácio?", "Ah! Como pude esquecer?", "O tempo passou tão rápido que nem me dei conta que hoje já é meu aniversário!", "E o reino inteiro já está comemorando!", "Será que já chegou algum presente para mim???"]
    
    override func didMove(to view: SKView) {
        //MARK: Vamos adicionar um som de fundo?
//        audioPlayer.play()

        addChild(soundNode)
        
        guard
            let backgroundImg = self.childNode(withName: "background") as? SKSpriteNode 
            else { return }

        self.backgroundImg = backgroundImg
        
        backgroundColor = .black
        buildBackground()
        animateBackground()
    }
    
    func buildBackground() {
        let backgroundAnimatedAtlas = SKTextureAtlas(named: "ZeroSceneAtlas")
        var animateFrames: [SKTexture] = []

        let numImages = backgroundAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let backgroundTextureName = "zeroScene\(i)"
            animateFrames.append(backgroundAnimatedAtlas.textureNamed(backgroundTextureName))
        }
        backgroundFrames = animateFrames
        
        let firstFrameTexture = backgroundFrames[0]
        backgroundImg = SKSpriteNode(texture: firstFrameTexture)
        backgroundImg?.zPosition = 7
        addChild(backgroundImg ?? SKSpriteNode.init(texture: SKTexture.init(imageNamed: "BackgroundImaginario1")))
    }
    
    func animateBackground() {
        backgroundImg?.run(SKAction.animate(with: backgroundFrames,
                         timePerFrame: 0.8,
                         resize: false,
                         restore: false)) {
                            self.backgroundImg?.removeFromParent()
                            self.setLines(line: self.arrayLines[0], duration: 0)
                            self.canTap = true
        }
    }
    
    override func didTap() {
        if !canTap {
            return
        } else if countLines >= arrayLines.count - 1 {
            disableLine()
            soundNode.run(SKAction.pause())
            sceneDelegate?.changeScene(to: .Scene1)
        } else {
            countLines += 1
            setLines(line: arrayLines[countLines], duration: 0)
        }
    }
}
