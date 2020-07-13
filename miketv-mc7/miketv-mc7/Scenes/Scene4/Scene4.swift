//
//  Scene4.swift
//  miketv-mc7
//
//  Created by gabriel on 10/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class Scene4: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var leftArrowNode: SelectionableNode?
    private var rightArrowNode: SelectionableNode?
    private var storyLine: SKLabelNode?
    
    private var timer: Timer?

    
    override func didMove(to view: SKView) {
        
        guard
            let leftArrow = self.childNode(withName: "LeftArrow") as? SelectionableNode,
            let rightArrow = self.childNode(withName: "RightArrow") as? SelectionableNode,
            let dresserNode = self.childNode(withName: "Dresser") as? SelectionableNode,
            let clockNode = self.childNode(withName: "Clock") as? SelectionableNode,
            let courtainNode = self.childNode(withName: "Courtain") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
        else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        self.storyLine = storyLine
        
        buttons.append(leftArrow)
        buttons.append(dresserNode)
        buttons.append(clockNode)
        buttons.append(courtainNode)
        buttons.append(rightArrow)
        
        self.currentFocused = dresserNode
        self.currentFocused?.buttonDidGetFocus()
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == leftArrowNode {
                sceneDelegate?.changeScene(to: .Scene3)
            } else if currentFocused == rightArrowNode {
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

