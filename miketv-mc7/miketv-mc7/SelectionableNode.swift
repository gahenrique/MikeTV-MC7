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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.normalColor = self.color
        self.isUserInteractionEnabled = true
        self.focusBehavior = .focusable
    }
    
    override var canBecomeFocused: Bool {
        get {
            return true
        }
    }
    
    func buttonDidGetFocus() {
        self.color = .blue
        self.setScale(1.5)
    }
    
    func buttonDidLoseFocus() {
        self.color = normalColor ?? UIColor.black
        self.setScale(1.0)
    }
    
}
