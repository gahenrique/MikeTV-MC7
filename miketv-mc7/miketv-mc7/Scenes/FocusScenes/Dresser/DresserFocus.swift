//
//  DresserFocus.swift
//  miketv-mc7
//
//  Created by gabriel on 14/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class DresserFocus: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var backArrowNode: SelectionableNode?
    private var storyLine: SKLabelNode?
    
    private var dresserNode: SelectionableNode?
    private var timer: Timer?
        
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let dresserNode = self.childNode(withName: "Dresser") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.dresserNode = dresserNode
        self.storyLine = storyLine
        
        dresserNode.delegate = self
        
        buttons.append(backArrowNode)
        buttons.append(dresserNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setup(model: GameModel, commingFrom scene: SceneName) {
        super.setup(model: model, commingFrom: scene)

        guard
            let dresserTexture = model.scene4.dresserTextures[model.scene4.dresserState]
        else { return }

        dresserNode?.texture = SKTexture(imageNamed: dresserTexture)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == backArrowNode {
                sceneDelegate?.changeScene(to: .Scene4, fromScene: .DresserFocus)
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
