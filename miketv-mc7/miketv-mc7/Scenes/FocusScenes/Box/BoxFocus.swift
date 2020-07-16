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

//    private var boxNode: SelectionableNode?
    private var firstDigitNode: SelectionableNode?
    private var secondDigitNode: SelectionableNode?
    private var thirdDigitNode: SelectionableNode?
    
    private var firstDigit : SKLabelNode?
    private var secondDigit : SKLabelNode?
    private var thirdDigit : SKLabelNode?
    
    private var timer: Timer?
    
    private let arrayNumbers = ["0","1","2","3","4","5","6","7","8","9"]
    private let possiblePasswords: [String] = ["921", "803", "547"]
    private var digits: [Int]?
    private var rightPassword: String?
    
    override func didMove(to view: SKView) {
        
        generatePassword()
        
        guard
            let backArrowNode = self.childNode(withName: "BackArrow") as? SelectionableNode,
            let firstDigitNode = self.childNode(withName: "firstDigitNode") as? SelectionableNode,
            let secondDigitNode = self.childNode(withName: "secondDigitNode") as? SelectionableNode,
            let thirdDigitNode = self.childNode(withName: "thirdDigitNode") as? SelectionableNode,
            let firstDigit = firstDigitNode.childNode(withName: "firstDigit") as? SKLabelNode,
            let secondDigit = secondDigitNode.childNode(withName: "secondDigit") as? SKLabelNode,
            let thirdDigit = thirdDigitNode.childNode(withName: "thirdDigit") as? SKLabelNode
//            let storyLine = self.childNode(withName: "StoryLine") as? SKLabelNode
            else { return }
        
        self.backArrowNode = backArrowNode
        self.firstDigitNode = firstDigitNode
        self.secondDigitNode = secondDigitNode
        self.thirdDigitNode = thirdDigitNode
        self.firstDigit = firstDigit
        self.secondDigit = secondDigit
        self.thirdDigit = thirdDigit
//        self.storyLine = storyLine
        
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

//        guard
//            let dresserTexture = model.scene4.dresserTextures[model.scene4.dresserState]
//        else { return }

//        firstDigitNode?.texture = SKTexture(imageNamed: dresserTexture)
    }
    
    func generatePassword() {
        if let randomPassword = possiblePasswords.randomElement() {
            rightPassword = randomPassword
            print(randomPassword)
        }
        digits = rightPassword?.digits
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == backArrowNode {
                sceneDelegate?.changeScene(to: .Scene1)
            } else if currentFocused == firstDigitNode {
                changeDigit(currentFocusedLabel: firstDigit ?? SKLabelNode.init(text: "0"))
            } else if currentFocused == secondDigitNode {
                changeDigit(currentFocusedLabel: secondDigit ?? SKLabelNode.init(text: "0"))
            } else if currentFocused == thirdDigitNode {
                changeDigit(currentFocusedLabel: thirdDigit ?? SKLabelNode.init(text: "0"))
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
            //MARK: Trocar asset
            print("Acertou mizeravi")
        }
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
