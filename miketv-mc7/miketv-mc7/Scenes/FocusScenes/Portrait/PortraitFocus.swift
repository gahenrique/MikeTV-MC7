//
//  PortraitFocus.swift
//  miketv-mc7
//
//  Created by gabriel on 22/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class PortraitFocus: BaseGameScene {
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
        
    private var backArrowNode: SelectionableNode?
    private var portraitNode: SelectionableNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let portraitNode = self.childNode(withName: "Portrait") as? SelectionableNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.portraitNode = portraitNode
        
        portraitNode.delegate = self
        
        buttons.append(backArrowNode)
        buttons.append(portraitNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
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
            if currentFocused == backArrowNode {
                sceneDelegate?.changeScene(to: .Scene3)
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
