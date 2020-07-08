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
            let button1 = self.childNode(withName: "RightButton") as? SelectionableNode,
            let button2 = self.childNode(withName: "LeftButton") as? SelectionableNode
            else { return }
        
        buttons.append(button1)
        buttons.append(button2)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
                
        // Test if event is a tap
        if let currentFocused = self.currentFocused,
            touch.previousLocation(in: self.view) == touch.location(in: self.view) {
            
            if currentFocused == buttons[0] {
                sceneDelegate?.changeScene(sceneName: "GameScene")
            }
        }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        print("Pressed Ended: ", presses.first?.type.rawValue)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        let prevItem = context.previouslyFocusedItem
        let nextItem = context.nextFocusedItem
        
        if let prevButton = prevItem as? SelectionableNode {
            prevButton.buttonDidLoseFocus()
        }
        if let nextButton = nextItem as? SelectionableNode {
            nextButton.buttonDidGetFocus()
            currentFocused = nextButton
        }
    }
}

