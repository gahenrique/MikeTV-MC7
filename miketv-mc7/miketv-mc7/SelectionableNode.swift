//
//  SelectionableNode.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

protocol SelectionableNodeDelegate: AnyObject {
    func setLines(line: String)
    func changeScene(to scene: SceneName)
    func changeState(_ node: SelectionableNode, to newState: State)
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
        self.color = .systemGreen
        self.setScale(1.2)
        self.highlightNode?.alpha = 1
//        self.highlightNode?.setScale(1.2)
    }
    
    func buttonDidLoseFocus() {
        self.color = normalColor ?? UIColor.black
        self.setScale(1.0)
        self.highlightNode?.alpha = 0
//        self.highlightNode?.setScale(1.0)
    }
    
    func didTap() { }
}
