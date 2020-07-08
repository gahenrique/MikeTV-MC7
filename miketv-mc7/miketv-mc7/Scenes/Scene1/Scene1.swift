//
//  Scene1.swif.swift
//  miketv-mc7
//
//  Created by gabriel on 07/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate: NSObject {
    func changeScene(sceneName: String)
}

class Scene1: SKScene {
    weak var sceneDelegate: GameSceneDelegate?
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let buttonLeft = self.childNode(withName: "LeftButton") as? SelectionableNode,
            let buttonRight = self.childNode(withName: "RightButton") as? SelectionableNode
            else { return }
        
        buttons.append(buttonLeft)
        buttons.append(buttonRight)
        
        self.currentFocused = buttonLeft
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//
//        // Test if event is a tap
//        if let currentFocused = self.currentFocused,
//            touch.previousLocation(in: self.view) == touch.location(in: self.view) {
//
//            if currentFocused == buttons[1] {
//                sceneDelegate?.changeScene(sceneName: "GameScene")
//            }
//        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension Scene1: GameSceneProtocol {
    func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == buttons[1] {
                sceneDelegate?.changeScene(sceneName: "GameScene")
            }
        }
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

