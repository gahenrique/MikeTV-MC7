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

    private var boxNode: SelectionableNode?
    private var firstDigitNode: SelectionableNode?
    private var secondDigitNode: SelectionableNode?
    private var thirdDigitNode: SelectionableNode?
    
    private var firstDigit : SKLabelNode?
    private var secondDigit : SKLabelNode?
    private var thirdDigit : SKLabelNode?
    
    private var timer: Timer?
    private var backgroundImg: SKSpriteNode?
    private var gift: SKSpriteNode?
    
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
            let backgroundImg = self.childNode(withName: "backgroundBlack") as? SKSpriteNode,
            let gift = self.childNode(withName: "gift") as? SKSpriteNode,
            let boxNode = self.childNode(withName: "Box") as? SelectionableNode
            
            else { return }
        
        self.backArrowNode = backArrowNode
        self.firstDigitNode = firstDigitNode
        self.secondDigitNode = secondDigitNode
        self.thirdDigitNode = thirdDigitNode
        self.firstDigit = firstDigit
        self.secondDigit = secondDigit
        self.thirdDigit = thirdDigit
        self.boxNode = boxNode
        self.backgroundImg = backgroundImg
        self.gift = gift
        
        boxNode.delegate = self
        if let boxNode = boxNode as? BoxFocusNode {
            boxNode.delegateBox = self
        }
        
        buttons.append(backArrowNode)
        buttons.append(firstDigitNode)
        buttons.append(secondDigitNode)
        buttons.append(thirdDigitNode)
        
        self.currentFocused = backArrowNode
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func setup(model: GameModel, commingFrom scene: SceneName) {
        super.setup(model: model, commingFrom: scene)
        
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
            setUpSceneAfterGift()
        } else if model.scene1.boxState == .closed {
            setLines(line: "É a caixa secreta do meu pai! Ele deixou comigo quando foi viajar mas ainda não consegui abrir ela", duration: 6)
        }
        print(model.scene1.randomPassword)
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused, let model = model, let firstDigit = firstDigit, let secondDigit = secondDigit, let thirdDigit = thirdDigit {
            if currentFocused == backArrowNode {
                if backgroundImg?.alpha == 1 {
                    setUpSceneAfterGift()
                } else {
                    sceneDelegate?.changeScene(to: .Scene1, fromScene: .BoxFocus)
                }
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
    
    func setUpSceneAfterGift() {
        gift?.removeAllActions()
        
        backgroundImg?.alpha = 0
        gift?.alpha = 0
        
        if let backArrowNode = backArrowNode,
            let boxNode = boxNode {
            buttons = []
            buttons.append(backArrowNode)
            buttons.append(boxNode)
            currentFocused = backArrowNode
            boxNode.buttonDidLoseFocus()
            //MARK: Digitos seguindo o scale
            firstDigit?.alpha = 0
            secondDigit?.alpha = 0
            thirdDigit?.alpha = 0
        }
        
        model?.setTextCached("O papai está lutando contra os monstros reais. Eu preciso encontrar minha mãe!", duration: 6)
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
            model.useItem(.gift)
            model.backgroundState = .destroyed
            model.scene1.boxState = .destroyed
            showGift()
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

extension StringProtocol  {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}

extension BoxFocus: BoxFocusNodeDelegate {
    
    func showGift() {
        backgroundImg?.alpha = 1
        let fade = SKAction.fadeAlpha(to: 1, duration: 1)
        gift?.run(fade)
        
        if let firstDigitNode = firstDigitNode,
            let secondDigitNode = secondDigitNode,
            let thirdDigitNode = thirdDigitNode,
            let backArrowNode = backArrowNode {
            thirdDigitNode.buttonDidLoseFocus()
            secondDigitNode.buttonDidLoseFocus()
            firstDigitNode.buttonDidLoseFocus()
            buttons = [backArrowNode]
            backArrowNode.buttonDidGetFocus()
            currentFocused = backArrowNode
            boxNode?.buttonDidLoseFocus()
        }
    }
}
