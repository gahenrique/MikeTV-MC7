//
//  BoxFocus.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 15/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class BoxFocus: BaseGameScene {
    
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var backArrowNode: SelectionableNode?
    private var storyLine: SKLabelNode?

    private var boxNode: SKSpriteNode?
    private var firstDigitNode: SelectionableNode?
    private var secondDigitNode: SelectionableNode?
    private var thirdDigitNode: SelectionableNode?
    
    private var firstDigit : SKLabelNode?
    private var secondDigit : SKLabelNode?
    private var thirdDigit : SKLabelNode?
    
    private var timer: Timer?
    
    private let arrayNumbers = ["0","1","2","3","4","5","6","7","8","9"]
    
    private var digits: [Int]?
    private var rightPassword: String?
    
    override func didMove(to view: SKView) {
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let firstDigitNode = self.childNode(withName: "firstDigitNode") as? SelectionableNode,
            let secondDigitNode = self.childNode(withName: "secondDigitNode") as? SelectionableNode,
            let thirdDigitNode = self.childNode(withName: "thirdDigitNode") as? SelectionableNode,
            let firstDigit = firstDigitNode.childNode(withName: "firstDigit") as? SKLabelNode,
            let secondDigit = secondDigitNode.childNode(withName: "secondDigit") as? SKLabelNode,
            let thirdDigit = thirdDigitNode.childNode(withName: "thirdDigit") as? SKLabelNode,
            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode,
            let boxNode = self.childNode(withName: "Box") as? SKSpriteNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.firstDigitNode = firstDigitNode
        self.secondDigitNode = secondDigitNode
        self.thirdDigitNode = thirdDigitNode
        self.firstDigit = firstDigit
        self.secondDigit = secondDigit
        self.thirdDigit = thirdDigit
        self.storyLine = storyLine
        self.boxNode = boxNode
        
//        boxNode.delegate = self
        
        buttons.append(backArrowNode)
        buttons.append(firstDigitNode)
        buttons.append(secondDigitNode)
        buttons.append(thirdDigitNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    //MARK: Mudar a textura da caixa
    override func setupModel(model: GameModel) {
        super.setupModel(model: model)
        
        guard
            let boxTexture = model.scene1.boxTextures[model.scene1.boxState]
        else { return }
        
        boxNode?.texture = SKTexture(imageNamed: boxTexture)

        digits = model.scene1.randomPassword.digits
        
        firstDigit?.text = model.scene1.currentPassword[0]
        secondDigit?.text = model.scene1.currentPassword[1]
        thirdDigit?.text = model.scene1.currentPassword[2]
        
        if model.scene1.boxState == .destroyed {
            changeNodesPosition()
        } else if model.scene1.boxState == .closed {
            setLines(line: "É a caixa secreta do meu pai! Ele deixou comigo quando foi viajar mas ainda não consegui abrir ela")
        }
        print(model.scene1.randomPassword)
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused, let model = model, let firstDigit = firstDigit, let secondDigit = secondDigit, let thirdDigit = thirdDigit {
            if currentFocused == backArrowNode {
                sceneDelegate?.changeScene(to: .Scene1)
            } else if currentFocused == firstDigitNode {
                changeDigit(currentFocusedLabel: firstDigit)
                model.scene1.currentPassword[0] = firstDigit.text ?? "9"
            } else if currentFocused == secondDigitNode {
                changeDigit(currentFocusedLabel: secondDigit)
                model.scene1.currentPassword[1] = secondDigit.text ?? "2"
            } else if currentFocused == thirdDigitNode {
                changeDigit(currentFocusedLabel: thirdDigit)
                model.scene1.currentPassword[2] = thirdDigit.text ?? "1"
            }
        }
        currentFocused?.didTap()
    }
    
    func changeDigit(currentFocusedLabel: SKLabelNode) {
        if let index = arrayNumbers.firstIndex(of: currentFocusedLabel.text ?? "pu") {
            if index == 9 {
                currentFocusedLabel.text = arrayNumbers[0]
            } else {
                currentFocusedLabel.text = arrayNumbers[index+1]
            }
        }
        checkPassword()
    }
    
    func checkPassword() {
        guard let digits = digits else { return }
        
        if firstDigit?.text == String(digits[0]) && secondDigit?.text == String(digits[1]) && thirdDigit?.text == String(digits[2]) {
            model?.scene1.boxState = .open
            
            guard
                let model = model,
                let boxTexture = model.scene1.boxTextures[model.scene1.boxState]
            else { return }
            
            boxNode?.texture = SKTexture(imageNamed: boxTexture)
            changeNodesPosition()
            model.collectItem(.gift)
            model.scene1.boxState = .destroyed
        }
    }
    
    func changeNodesPosition() {
        boxNode?.size = CGSize(width: 1216.57, height: 758)
        boxNode?.position = CGPoint(x: 34.341, y: 118.288)
        firstDigitNode?.position = CGPoint(x: -144.73, y: -52.37)
        secondDigitNode?.position = CGPoint(x: -42.55, y: -52.37)
        thirdDigitNode?.position = CGPoint(x: 59.135, y: -52.37)
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

extension BoxFocus: SelectionableNodeDelegate {
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

extension StringProtocol  {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}
