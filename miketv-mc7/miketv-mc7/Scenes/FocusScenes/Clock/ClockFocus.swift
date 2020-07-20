//
//  ClockFocus.swift
//  miketv-mc7
//
//  Created by gabriel on 20/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class ClockFocus: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var backArrowNode: SelectionableNode?
    private var storyLine: SKLabelNode?
    
    private var clockNode: SelectionableNode?
    private var timer: Timer?
        
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let clockNode = self.childNode(withName: "Clock") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.clockNode = clockNode
        self.storyLine = storyLine
        
        clockNode.delegate = self
        
        buttons.append(backArrowNode)
        buttons.append(clockNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)

        guard
            let clockTexture = model.scene4.clockTextures[model.scene4.clockState]
        else { return }

        clockNode?.texture = SKTexture(imageNamed: clockTexture)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == backArrowNode {
                sceneDelegate?.changeScene(to: .Scene4)
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

extension ClockFocus: SelectionableNodeDelegate {
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
