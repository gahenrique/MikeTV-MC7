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
    
    private var portraitNode: SelectionableNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let leftArrow = self.childNode(withName: "LeftArrow") as? SelectionableNode,
            let rightArrow = self.childNode(withName: "RightArrow") as? SelectionableNode,
            let portraitNode = self.childNode(withName: "Portrait") as? SelectionableNode,
            let doorNode = self.childNode(withName: "Door") as? SelectionableNode,
            let octopusNode = self.childNode(withName: "Octopus") as? SelectionableNode,
            let lampNode = self.childNode(withName: "Lamp") as? SelectionableNode
        else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        self.portraitNode = portraitNode
        
        octopusNode.delegate = self
        doorNode.delegate = self
        portraitNode.delegate = self
        
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
        
        // Checking if player already used fragments 2, 3 and 4
        if model.haveUsedItem(.photoFragment2),
            let fragment2Node = portraitNode?.childNode(withName: "Fragment2") as? SKSpriteNode {
            fragment2Node.alpha = 1
        }
        if model.haveUsedItem(.photoFragment3),
            let fragment3Node = portraitNode?.childNode(withName: "Fragment3") as? SKSpriteNode {
            fragment3Node.alpha = 1
        }
        if model.haveUsedItem(.photoFragment4),
            let fragment4Node = portraitNode?.childNode(withName: "Fragment4") as? SKSpriteNode {
            fragment4Node.alpha = 1
        }
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
