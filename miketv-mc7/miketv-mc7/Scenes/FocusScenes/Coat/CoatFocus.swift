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
    
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let coatNode = self.childNode(withName: "Coat") as? SelectionableNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.coatNode = coatNode
        self.storyLine = storyLine
        
        coatNode.delegate = self
        
        buttons.append(backArrowNode)
        buttons.append(coatNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        //MARK: Mudar para coat
        switch model.scene2.coatState {
        case .normal:
            setLines(line: "Meu pai, o famoso rei Julian, deixou esse casaco aqui antes de ir viajar. Queria que ele tivesse me levado junto…")
        case .openWithMap:
            setLines(line: "Olha! Tem algo dentro do bolso...")
        case .destroyed:
            setLines(line: "Hm… Estranho… O casaco não estava assim antes…")
        default:
            setLines(line: "Meu pai, o famoso rei Julian, deixou esse casaco aqui antes de ir viajar")
        }
        
        guard
            let coatTexture = model.scene2.coatTextures[model.scene2.coatState]
        else { return }
        
        coatNode?.texture = SKTexture(imageNamed: coatTexture)
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

extension CoatFocus: SelectionableNodeDelegate {
    func getModel() -> GameModel? {
        return self.model
    }
    
    func changeState(_ node: SelectionableNode, to newState: State) {
//        guard let model = self.model as? Scene1Model else { return }
//
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
        //lala
    }
    
    @objc func disableLine() {
        storyLine?.text = " "
    }
}
