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
    private var storyLine: SKLabelNode?
    
    private var bedNode: SelectionableNode?
    private var bearNode: SelectionableNode?
    private var booksNode: SelectionableNode?
    private var boxNode: SelectionableNode?
    private var timer: Timer?
    
    override func didMove(to view: SKView) {
        
        guard
            let leftArrow = self.childNode(withName: "LeftArrow") as? SelectionableNode,
            let rightArrow = self.childNode(withName: "RightArrow") as? SelectionableNode,
            let bedNode = self.childNode(withName: "Bed") as? SelectionableNode,
            let bearNode = self.childNode(withName: "Bear") as? SelectionableNode,
            let booksNode = self.childNode(withName: "Books") as? SelectionableNode,
            let boxNode = self.childNode(withName: "Box") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
            else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        self.storyLine = storyLine
        
        self.bedNode = bedNode
        bedNode.delegate = self
        self.bearNode = bearNode
        bearNode.delegate = self
        self.booksNode = booksNode
        self.boxNode = boxNode
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

extension Scene1: SelectionableNodeDelegate {
    func getModel() -> GameModel? {
        return self.model
    }
    
    func changeState(_ node: SelectionableNode, to newState: State) {
        
//        if node == bearNode,
//            let newTexture = model.bearTextures[newState] {
//            model.bearState = newState
//            bearNode?.texture = SKTexture(imageNamed: newTexture)
//        }
    }
    
    func setLines(line: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(disableLine), userInfo: nil, repeats: false)
        storyLine?.text = line
    }
    
    func changeScene(to scene: SceneName) {
        sceneDelegate?.changeScene(to: scene)
    }
    
    @objc func disableLine() {
        storyLine?.text = " "
    }
}
