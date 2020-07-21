//
//  GameScene.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene2: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var leftArrowNode: SelectionableNode?
    private var rightArrowNode: SelectionableNode?
    private var storyLine: SKLabelNode?
    
    private var coatNode: SelectionableNode?
    private var plantNode: SelectionableNode?
    private var timer: Timer?
    
    
    override func didMove(to view: SKView) {
        
        guard
            let leftArrow = self.childNode(withName: "LeftArrow") as? SelectionableNode,
            let rightArrow = self.childNode(withName: "RightArrow") as? SelectionableNode,
            let coatNode = self.childNode(withName: "Coat") as? SelectionableNode,
            let plantNode = self.childNode(withName: "Plant") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
            else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        self.storyLine = storyLine
        
        self.plantNode = plantNode
        self.coatNode = coatNode
        
        plantNode.delegate = self
        coatNode.delegate = self
        
        buttons.append(leftArrow)
        buttons.append(coatNode)
        buttons.append(plantNode)
        buttons.append(rightArrow)
        
        self.currentFocused = coatNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        self.setupInventory(items: model.inventory)
        
        guard
            let plantTexture = model.scene2.plantTextures[model.scene2.plantState],
            let coatTexture = model.scene2.coatTextures[model.scene2.coatState]
        else { return }
        
        plantNode?.texture = SKTexture(imageNamed: plantTexture)
        coatNode?.texture = SKTexture(imageNamed: coatTexture)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == leftArrowNode {
                sceneDelegate?.changeScene(to: .Scene1)
            } else if currentFocused == rightArrowNode {
                sceneDelegate?.changeScene(to: .Scene3)
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

extension Scene2: SelectionableNodeDelegate {
    func setLines(line: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(disableLine), userInfo: nil, repeats: false)
        storyLine?.text = line
    }
    
    func changeScene(to scene: SceneName) {
        sceneDelegate?.changeScene(to: scene)
    }
    
    func changeState(_ node: SelectionableNode, to newState: State) {
        
    }
    
    func getModel() -> GameModel? {
        return self.model
    }
    
    @objc func disableLine() {
        storyLine?.text = " "
    }
}
