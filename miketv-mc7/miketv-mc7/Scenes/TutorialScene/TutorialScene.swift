//
//  TutorialScene.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 20/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class TutorialScene: BaseGameScene {
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var backArrowLeft: SelectionableNode?
    private var backArrowRight: SelectionableNode?
    private var lblTutorial: SKLabelNode?
    private var imgRemote: SKSpriteNode?
    
    private var controlScene: String = "Tutorial1"
    
    override func didMove(to view: SKView) {
        
        guard
            let backArrowLeft = self.childNode(withName: "BackArrowLeft") as? SelectionableNode,
            let backArrowRight = self.childNode(withName: "BackArrowRight") as? SelectionableNode,
            let lblTutorial = self.childNode(withName: "lblTutorial") as? SKLabelNode,
            let imgRemote = self.childNode(withName: "imgRemote") as? SKSpriteNode
            else { return }
        
        self.backArrowLeft = backArrowLeft
        self.backArrowRight = backArrowRight
        self.lblTutorial = lblTutorial
        self.imgRemote = imgRemote
        
        buttons.append(backArrowLeft)
        buttons.append(backArrowRight)
        
        self.currentFocused = backArrowLeft
        self.currentFocused?.buttonDidGetFocus()
    }
    
    func setUpSceneOne() {
        controlScene = "Tutorial1"
        backArrowRight?.isHidden = false
        buttons.remove(at: 1)
        imgRemote?.texture = SKTexture(imageNamed: "SiriRemoteSwipe")
        lblTutorial?.text = "Arraste para a esquerda ou para a direita para mudar o foco dos objetos"
    }
    
    func setUpSceneTwo() {
        controlScene = "Tutorial2"
        backArrowRight?.isHidden = true
        imgRemote?.texture = SKTexture(imageNamed: "SiriRemoteTap")
        lblTutorial?.text = "Clique para interagir com os objetos"
        guard let backArrowRight = backArrowRight else { return }
        buttons.append(backArrowRight)
        
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if controlScene == "Tutorial1" {
                if currentFocused == backArrowLeft {
                    sceneDelegate?.changeScene(to: .Menu)
                } else if currentFocused == backArrowRight {
                    setUpSceneTwo()
                }
            } else {
                if currentFocused == backArrowLeft {
                    setUpSceneOne()
                }
            }
        }
        currentFocused?.didTap()
    }
    
    override func didSwipe(direction: UISwipeGestureRecognizer.Direction) {
        guard
            let currentFocused = self.currentFocused,
            let currentFocusedIndex = buttons.firstIndex(of: currentFocused)
            else { return }
        
        currentFocused.buttonDidLoseFocus()
        
        var nextFocusIndex: Int = currentFocusedIndex
        
        switch direction {
        case .left:
            nextFocusIndex = currentFocusedIndex > 0 ? currentFocusedIndex - 1 : 0
        case .right:
            let lastIndex = buttons.count - 1
            nextFocusIndex = currentFocusedIndex < lastIndex ? currentFocusedIndex + 1 : lastIndex
            break
        default:
            break
        }
        
        self.currentFocused = buttons[nextFocusIndex]
        self.currentFocused?.buttonDidGetFocus()
    }
}
