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
            let pegasusNode = self.childNode(withName: "Pegasus") as? SelectionableNode
            else { return }
        
        self.leftArrowNode = leftArrow
        self.rightArrowNode = rightArrow
        
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
    
    override func setup(model: GameModel, commingFrom scene: SceneName) {
        super.setup(model: model, commingFrom: scene)
        
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
        
        // Removing octopus interaction
        if (model.hasItem(.photoFragment3) || model.haveUsedItem(.photoFragment3)),
            let pegasusNode = self.pegasusNode,
            let pegasusIndex = buttons.firstIndex(of: pegasusNode) {
            buttons.remove(at: pegasusIndex)
            
            if let trainNode = childNode(withName: "Train") as? SKSpriteNode,
                let ballNode = childNode(withName: "Ball") as? SKSpriteNode {
                tRexNode?.texture = SKTexture(imageNamed: "T-RexReal")
                pegasusNode.texture = SKTexture(imageNamed: "CavalinhoReal")
                trainNode.texture = SKTexture(imageNamed: "TrenzinhoReal")
                ballNode.texture = SKTexture(imageNamed: "BolaReal")
            }
        }
        
        if model.backgroundState == .destroyed,
            let windowNode = childNode(withName: "Window") as? SKSpriteNode {
            windowNode.texture = SKTexture(imageNamed: "JanelaReal")
            courtainNode?.texture = SKTexture(imageNamed: "CortinaQuebradaReal")
        }
        
//        if model.hasItem(.photoFragment4) || model.haveUsedItem(.photoFragment4) {
//            dresserNode?.texture = SKTexture(imageNamed: "ComodaAbertaReal")
//        }
    }
    
    override func setupFocus(commingFrom scene: SceneName) {
        // Adjusting focus
        currentFocused?.buttonDidLoseFocus()
        switch scene {
        case .DresserFocus:
            currentFocused = dresserNode
        case .ClockFocus:
            currentFocused = clockNode
        case .Scene3:
            currentFocused = leftArrowNode
        case .Scene1:
            currentFocused = rightArrowNode
        default:
            break
        }
        currentFocused?.buttonDidGetFocus()
        // End focus adjustment
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == leftArrowNode {
                sceneDelegate?.changeScene(to: .Scene3, fromScene: .Scene4)
            } else if currentFocused == rightArrowNode {
                sceneDelegate?.changeScene(to: .Scene1, fromScene: .Scene4)
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
