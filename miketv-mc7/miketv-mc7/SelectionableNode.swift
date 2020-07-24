//
//  SelectionableNode.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

protocol SelectionableNodeDelegate: AnyObject {
    func setLines(line: String, duration: TimeInterval)
    func changeScene(to scene: SceneName, from: SceneName)
    func getModel() -> GameModel?
}

class SelectionableNode: SKSpriteNode {
    
    weak var delegate: SelectionableNodeDelegate?
    
    var normalColor: UIColor?
    var highlightNode: SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.normalColor = self.color
        self.highlightNode = self.childNode(withName: "Highlight") as? SKSpriteNode
    }
    
    func buttonDidGetFocus() {
        self.color = .clear
        self.setScale(1.2)
        self.highlightNode?.alpha = 1
    }
    
    func buttonDidLoseFocus() {
        self.color = normalColor ?? UIColor.black
        self.setScale(1.0)
        self.highlightNode?.alpha = 0
    }
    
    func didTap() { }
}
