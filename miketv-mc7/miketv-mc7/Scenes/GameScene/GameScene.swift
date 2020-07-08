//
//  GameScene.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var buttons: [SelectionableNode] = []
    
    private var currentFocused: SelectionableNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let button1 = self.childNode(withName: "Button1") as? SelectionableNode,
            let button2 = self.childNode(withName: "Button2") as? SelectionableNode,
            let button3 = self.childNode(withName: "Button3") as? SelectionableNode,
            let button4 = self.childNode(withName: "Button4") as? SelectionableNode
        else { return }
        
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
        
        self.currentFocused = button1
        self.currentFocused?.buttonDidGetFocus()
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: GameSceneProtocol {
    func didTap() {
        
    }
    
    func didSwipe(direction: UISwipeGestureRecognizer.Direction) {
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
