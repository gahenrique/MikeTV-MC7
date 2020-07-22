//
//  Scene3.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 10/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class Scene3: BaseGameScene {
    
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
            let portraitNode = self.childNode(withName: "Portrait") as? SelectionableNode,
            let doorNode = self.childNode(withName: "Door") as? SelectionableNode,
            let octopusNode = self.childNode(withName: "Octopus") as? SelectionableNode,
            let lampNode = self.childNode(withName: "Lamp") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
        else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        self.storyLine = storyLine
        
        octopusNode.delegate = self
        doorNode.delegate = self
        
        buttons.append(leftArrow)
        buttons.append(portraitNode)
        buttons.append(octopusNode)
        buttons.append(doorNode)
        buttons.append(lampNode)
        buttons.append(rightArrow)
        
        self.currentFocused = portraitNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        self.setupInventory(items: model.inventory)
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == leftArrowNode {
                sceneDelegate?.changeScene(to: .Scene2)
            } else if currentFocused == rightArrowNode {
                sceneDelegate?.changeScene(to: .Scene4)
            }
        }
        currentFocused?.didTap()
    }
    
    // MARK: Mudar funcao para game scene
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
