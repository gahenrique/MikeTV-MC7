//
//  SelectionableNode.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class SelectionableNode: SKSpriteNode {
    
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
    }
    
    func buttonDidLoseFocus() {
        self.color = normalColor ?? UIColor.black
        self.setScale(1.0)
        self.highlightNode?.alpha = 0
    }
    
}
