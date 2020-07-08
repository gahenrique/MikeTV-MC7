//
//  BoxPasswordScene.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 08/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit
import GameplayKit

class BoxPasswordScene: SKScene {
    
    private var firstDigit : SKLabelNode?
    private var secondDigit : SKLabelNode?
    private var thirdDigit : SKLabelNode?
    private var box: SKSpriteNode?
    private var backgroundImg: SKSpriteNode?
    private var rightPassword: String?
    private let possiblePasswords: [String] = ["921", "803", "547"]
    private var digits: [Int]?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.white
        
        self.backgroundImg = self.childNode(withName: "//background") as? SKSpriteNode
        if let backgroundImg = self.backgroundImg {
            backgroundImg.size = view.bounds.size
        }
        
        self.firstDigit = self.childNode(withName: "//firstDigit") as? SKLabelNode
        if let firstDigit = self.firstDigit {
            firstDigit.text = "1"
        }
        generatePassword()
        checkPassword()
    }
    
    func changeNumber() {
        let numbers = ["1","2","3","4","5","6","7","8","9"]
        
    }
    
    func generatePassword() {
        if let randomPassword = possiblePasswords.randomElement() {
            rightPassword = randomPassword
            print(randomPassword)
        }
        digits = rightPassword?.digits
    }
    
    // Checar se a senha colocada é a senha correta
    func checkPassword() {
        if firstDigit?.text == String(digits?[0] ?? 0) && secondDigit?.text == String(digits?[1] ?? 0) && thirdDigit?.text == String(digits?[2] ?? 0) {
            print("Acertou mizeravi")
        }
    }
}

extension StringProtocol  {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}
