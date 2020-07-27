//
//  CoatFocus.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class CoatFocus: BaseGameScene {
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var timer: Timer?
    private var storyLine: SKLabelNode?
    
    private var backArrowNode: SelectionableNode?
    private var coatNode: SelectionableNode?
    private var blackBackground: SKSpriteNode?
    private var mapNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let coatNode = self.childNode(withName: "Coat") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode,
            let blackBackground = self.childNode(withName: "blackBackground") as? SKSpriteNode,
            let map = self.childNode(withName: "map") as? SKSpriteNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.coatNode = coatNode
        self.storyLine = storyLine
        self.blackBackground = blackBackground
        self.mapNode = map
        
        coatNode.delegate = self
        if let coatNode = coatNode as? CoatFocusNode {
            coatNode.delegateCoat = self
        }
        
        buttons.append(backArrowNode)
        buttons.append(coatNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setup(model: GameModel, commingFrom scene: SceneName) {
        super.setup(model: model, commingFrom: scene)
        
        switch model.scene2.coatState {
        case .normal:
            setLines(line: "Meu pai, o rei Julian, deixou esse casaco aqui antes de ir viajar. Queria que ele tivesse me levado junto…", duration: 7)
        case .openWithMap:
            setLines(line: "Olha! Tem algo dentro do bolso...", duration: 3)
        case .openDestroyed:
            setLines(line: "Hm… Estranho… O casaco não estava assim antes…", duration: 4)
        case . closedDestroyed:
            setLines(line: "Hm… Estranho… O casaco não estava assim antes…", duration: 4)
        }
        
        guard
            let coatTexture = model.scene2.coatTextures[model.scene2.coatState]
        else { return }
        
        coatNode?.texture = SKTexture(imageNamed: coatTexture)
        coatNode?.size = CGSize(width: 874.28, height: 2774.23)
        
        if coatTexture == "CoatFocusClosed" || coatTexture == "CoatFocusWithMap" {
            coatNode?.position = CGPoint(x: -0, y: 350)
        } else {
            coatNode?.position = CGPoint(x: 26, y: -315)
            coatNode?.childNode(withName: "Highlight")?.position = CGPoint(x: 9, y: 315)
        }
    }
    
    func setUpSceneAfterGift() {
        blackBackground?.alpha = 0
        mapNode?.removeAllActions()
        mapNode?.alpha = 0
        
        if let backArrowNode = backArrowNode,
            let coatNode = coatNode {
            buttons = []
            buttons.append(backArrowNode)
            buttons.append(coatNode)
            currentFocused = backArrowNode
            coatNode.buttonDidLoseFocus()
        }
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == backArrowNode {
                if blackBackground?.alpha == 1 {
                    setUpSceneAfterGift()
                } else {
                    sceneDelegate?.changeScene(to: .Scene2, fromScene: .CoatFocus)
                }
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


extension CoatFocus: CoatFocusNodeDelegate {
    func showMap() {

        blackBackground?.alpha = 1
        let fade = SKAction.fadeAlpha(to: 1, duration: 1)
        mapNode?.run(fade)
        
        if let backArrowNode = backArrowNode {
            buttons = [backArrowNode]
        }
    
        backArrowNode?.buttonDidGetFocus()
        currentFocused = backArrowNode
        coatNode?.buttonDidLoseFocus()

    }
}
