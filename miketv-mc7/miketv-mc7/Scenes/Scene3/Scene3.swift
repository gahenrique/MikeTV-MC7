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
            let lampNode = self.childNode(withName: "Lamp") as? SelectionableNode,
            let letterNode = self.childNode(withName: "Letter") as? SelectionableNode
        else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        self.portraitNode = portraitNode
        
        octopusNode.delegate = self
        doorNode.delegate = self
        portraitNode.delegate = self
        letterNode.delegate = self
        
        buttons.append(leftArrow)
        buttons.append(portraitNode)
        buttons.append(octopusNode)
        buttons.append(doorNode)
        buttons.append(letterNode)
        buttons.append(lampNode)
        buttons.append(rightArrow)
        
        self.currentFocused = portraitNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        self.setupInventory(items: model.inventory)
        
        guard
            let fragment1Node = portraitNode?.childNode(withName: "Fragment1") as? SKSpriteNode,
            let fragment2Node = portraitNode?.childNode(withName: "Fragment2") as? SKSpriteNode,
            let fragment3Node = portraitNode?.childNode(withName: "Fragment3") as? SKSpriteNode,
            let fragment4Node = portraitNode?.childNode(withName: "Fragment4") as? SKSpriteNode,
            let passwordNode = portraitNode?.childNode(withName: "Password") as? SKSpriteNode
        else { return }
        
        if model.scene3.photoState == .flipped {
            passwordNode.texture = SKTexture(imageNamed: model.scene1.passwordPhotoTexture)
            passwordNode.size = fragment2Node.size
            passwordNode.alpha = 1
            fragment1Node.alpha = 0
        } else {
            // Checking if player already used fragments 2, 3 and 4
            if model.haveUsedItem(.photoFragment2) {
                fragment2Node.alpha = 1
            }
            if model.haveUsedItem(.photoFragment3) {
                fragment3Node.alpha = 1
            }
            if model.haveUsedItem(.photoFragment4)  {
                fragment4Node.alpha = 1
            }
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
