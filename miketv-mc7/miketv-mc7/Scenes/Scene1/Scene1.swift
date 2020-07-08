//
//  Scene1.swif.swift
//  miketv-mc7
//
//  Created by gabriel on 07/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene1: BaseGameScene {
    
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == buttons[1] {
                sceneDelegate?.changeScene(sceneName: "Scene2")
            }
        }
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
