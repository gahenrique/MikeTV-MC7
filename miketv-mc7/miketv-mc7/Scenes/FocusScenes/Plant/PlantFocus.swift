//
//  PlantFocus.swift
//  miketv-mc7
//
//  Created by gabriel on 14/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class PlantFocus: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var backArrowNode: SelectionableNode?
    
    private var plantNode: SelectionableNode?
        
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let plantNode = self.childNode(withName: "Plant") as? SelectionableNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.plantNode = plantNode
        
        plantNode.delegate = self
        
        buttons.append(backArrowNode)
        buttons.append(plantNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        guard
            let plantTexture = model.scene2.plantTextures[model.scene2.plantState]
        else { return }
        
        plantNode?.texture = SKTexture(imageNamed: plantTexture)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == backArrowNode {
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

extension PlantFocus: SelectionableNodeDelegate {
    func getModel() -> GameModel? {
        return self.model
    }
    
    func changeState(_ node: SelectionableNode, to newState: State) {
    }
    
    func setLines(line: String) {
    }
    
    func changeScene(to scene: SceneName) {
        //lala
    }
    
    @objc func disableLine() {
    }
}