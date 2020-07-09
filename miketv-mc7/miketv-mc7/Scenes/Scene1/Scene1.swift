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
    
    private var leftArrowNode: SelectionableNode?
    private var rightArrowNode: SelectionableNode?
    
    private var bedNode: SelectionableNode?
    private var bearNode: SelectionableNode?
    private var booksNode: SelectionableNode?
    private var boxNode: SelectionableNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let leftArrow = self.childNode(withName: "LeftArrow") as? SelectionableNode,
            let rightArrow = self.childNode(withName: "RightArrow") as? SelectionableNode,
            let bedNode = self.childNode(withName: "Bed") as? SelectionableNode,
            let bearNode = self.childNode(withName: "Bear") as? SelectionableNode,
            let booksNode = self.childNode(withName: "Books") as? SelectionableNode,
            let boxNode = self.childNode(withName: "Box") as? SelectionableNode
            else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        
        self.bedNode = bedNode
        self.bearNode = bearNode
        self.booksNode = booksNode
        self.boxNode = boxNode
        
        buttons.append(leftArrow)
        buttons.append(bedNode)
        buttons.append(boxNode)
        buttons.append(booksNode)
        buttons.append(bearNode)
        buttons.append(rightArrow)
        
        self.currentFocused = bedNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == rightArrowNode {
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
