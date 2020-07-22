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
        
        bedNode.delegate = self
        bearNode.delegate = self
        booksNode.delegate = self
        boxNode.delegate = self
        
        buttons.append(leftArrow)
        buttons.append(bedNode)
        buttons.append(boxNode)
        buttons.append(booksNode)
        buttons.append(bearNode)
        buttons.append(rightArrow)
        
        self.currentFocused = bedNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        self.setupInventory(items: model.inventory)
        
        guard
            let bearTexture = model.scene1.bearTextures[model.scene1.bearState],
            let boxTexture = model.scene1.boxTextures[model.scene1.boxState]
        else { return }
        
        bearNode?.texture = SKTexture(imageNamed: bearTexture)
        boxNode?.texture = SKTexture(imageNamed: boxTexture)
        
        if model.scene1.boxState == .destroyed, let highlight = boxNode?.childNode(withName: "Highlight") as? SKSpriteNode {
            boxNode?.size = CGSize(width: 217.143, height: 117.655)
            boxNode?.position = CGPoint(x: 84.287, y: 162.793)
            highlight.size = CGSize(width: 248.325, height: 139.743)
            highlight.position = CGPoint(x: 3.162, y: 0.531)
            highlight.texture = SKTexture(imageNamed: "HighlightCaixaDestruida")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == leftArrowNode {
                sceneDelegate?.changeScene(to: .Scene4)
            } else if currentFocused == rightArrowNode {
                sceneDelegate?.changeScene(to: .Scene2)
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
