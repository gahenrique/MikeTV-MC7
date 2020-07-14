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
    
    private var storyLine: SKLabelNode?
    private var timer: Timer?
    private var backgroundImg: SKSpriteNode?
    private var backgroundFrames: [SKTexture] = []
    
    private var canTap: Bool = false
    private var countLines: Int = 0
    
    private let soundNode = SKNode()
    
//    let url = Bundle.main.url(forResource: "firework", withExtension: "mp3")
//    private var audioPlayer = AVAudioPlayer()
    
    // MARK: colocar falas no model
    let arrayLines: [String] = ["O que é isso?", "Fogos de artificio? Aqui no palácio?", "Ah! Como pude esquecer?", "O tempo passou tão rápido que nem me dei conta que hoje já é meu aniversário!", "E o reino inteiro já está comemorando!", "Será que já chegou algum presente para mim???"]

    
    override func didMove(to view: SKView) {
        //MARK: Vamos adicionar um som de fundo?
//        audioPlayer.play()
        
        addChild(soundNode)
        
        //MARK: Vai ter repeat?
        let soundAction = SKAction.playSoundFileNamed("firework.mp3", waitForCompletion: false)
        soundNode.run(soundAction)
        
        guard
            let backgroundImg = self.childNode(withName: "background") as? SKSpriteNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
            
            else { return }

        self.backgroundImg = backgroundImg
        self.storyLine = storyLine
        
        
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
//        backgroundImg.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(backgroundImg ?? SKSpriteNode.init(texture: SKTexture.init(imageNamed: "BackgroundImaginario1")))
    }
    
    func animateBackground() {
        
        backgroundImg?.run(SKAction.animate(with: backgroundFrames,
                         timePerFrame: 0.8,
                         resize: false,
                         restore: false)) {
                            self.backgroundImg?.removeFromParent()
                            self.setLines(line: self.arrayLines[0])
                            self.canTap = true
        }
    }
    
    override func didTap() {
        if !canTap {
            return
        } else if countLines >= arrayLines.count - 1 {
            disableLine()
            sceneDelegate?.changeScene(to: .Scene1)
        } else {
            countLines += 1
            setLines(line: arrayLines[countLines])
        }
    }
}


extension Scene0: SelectionableNodeDelegate {
    func getModel() -> GameModel? {
        return self.model
    }
    
    func changeState(_ node: SelectionableNode, to newState: State) {
        
//        if node == bearNode,
//            let newTexture = model.bearTextures[newState] {
//            model.bearState = newState
//            bearNode?.texture = SKTexture(imageNamed: newTexture)
//        }
    }
    
    func setLines(line: String) {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(disableLine), userInfo: nil, repeats: false)
        storyLine?.text = line
    }
    
    func changeScene(to scene: SceneName) {
        sceneDelegate?.changeScene(to: scene)
    }
    
    @objc func disableLine() {
        storyLine?.text = " "
    }
}
