//
//  BearFocus.swift
//  miketv-mc7
//
//  Created by gabriel on 13/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class BearFocus: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var backArrowNode: SelectionableNode?
    
    private var timer: Timer?
    
    private var bearNode: SelectionableNode?
        
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let bearNode = self.childNode(withName: "Bear") as? SelectionableNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.bearNode = bearNode
        
        bearNode.delegate = self
        
        buttons.append(backArrowNode)
        buttons.append(bearNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        switch model.scene1.bearState {
        case .normal:
            setLines(line: "Esse é senhor Catatau, meu melhor amigo!")
        case .destroyed:
            setLines(line: "Ah não! O que aconteceu com você senhor Catatau?!")
        default:
            setLines(line: "Esse é senhor Catatau, meu melhor amigo!")
        }
        
        guard
            let bearTexture = model.scene1.bearTextures[model.scene1.bearState]
        else { return }
        
        bearNode?.texture = SKTexture(imageNamed: bearTexture)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == backArrowNode {
                sceneDelegate?.changeScene(to: .Scene1)
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
