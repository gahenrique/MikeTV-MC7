//
//  Scene4.swift
//  miketv-mc7
//
//  Created by gabriel on 10/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class Scene4: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var leftArrowNode: SelectionableNode?
    private var rightArrowNode: SelectionableNode?
    private var storyLine: SKLabelNode?
    
    private var dresserNode: SelectionableNode?
    private var clockNode: SelectionableNode?
    private var courtainNode: SelectionableNode?
    private var tRexNode: SelectionableNode?
    private var pegasusNode: SelectionableNode?
    private var timer: Timer?

    
    override func didMove(to view: SKView) {
        
        guard
            let leftArrow = self.childNode(withName: "LeftArrow") as? SelectionableNode,
            let rightArrow = self.childNode(withName: "RightArrow") as? SelectionableNode,
            let dresserNode = self.childNode(withName: "Dresser") as? SelectionableNode,
            let clockNode = self.childNode(withName: "Clock") as? SelectionableNode,
            let courtainNode = self.childNode(withName: "Courtain") as? SelectionableNode,
            let tRexNode = self.childNode(withName: "TRex") as? SelectionableNode,
            let pegasusNode = self.childNode(withName: "Pegasus") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
        else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        self.storyLine = storyLine
        
        self.dresserNode = dresserNode
        self.clockNode = clockNode
        self.courtainNode = courtainNode
        self.tRexNode = tRexNode
        self.pegasusNode = pegasusNode
        
        dresserNode.delegate = self
        courtainNode.delegate = self
        clockNode.delegate = self
        pegasusNode.delegate = self
        tRexNode.delegate = self
        
        buttons.append(leftArrow)
        buttons.append(dresserNode)
        buttons.append(clockNode)
        buttons.append(courtainNode)
        buttons.append(tRexNode)
        buttons.append(pegasusNode)
        buttons.append(rightArrow)
        
        self.currentFocused = dresserNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        self.setupInventory(items: model.inventory)
        
        guard
            let dresserTexture = model.scene4.dresserTextures[model.scene4.dresserState],
            let courtainTexture = model.scene4.courtainTextures[model.scene4.courtainState],
            let clockTexture = model.scene4.clockTextures[model.scene4.clockState]
        else { return }
        
        dresserNode?.texture = SKTexture(imageNamed: dresserTexture)
        courtainNode?.texture = SKTexture(imageNamed: courtainTexture)
        clockNode?.texture = SKTexture(imageNamed: clockTexture)
        
        if model.scene4.courtainState == .broken,
            let courtainNode = courtainNode as? CourtainNode {
            courtainNode.updateHighlight()
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == leftArrowNode {
                sceneDelegate?.changeScene(to: .Scene3)
            } else if currentFocused == rightArrowNode {
                sceneDelegate?.changeScene(to: .Scene1)
            }
        }
        currentFocused?.didTap()
        
        guard
            let inventoryNode = self.inventoryNode,
            let model = model
        else { return }
        inventoryNode.updateItems(model.inventory)
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

extension Scene4: SelectionableNodeDelegate {
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
