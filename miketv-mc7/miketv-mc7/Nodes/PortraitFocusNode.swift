//
//  PortraitFocusNode.swift
//  miketv-mc7
//
//  Created by gabriel on 22/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class PortraitFocusNode: SelectionableNode {
    
    override func didTap() {
        guard
            let model = delegate?.getModel()
        else { return }
        
        // Checking if player has fragments 2, 3 and 4
        if model.hasItem(.photoFragment2),
            let fragment2Node = self.childNode(withName: "Fragment2") as? SKSpriteNode {
            fragment2Node.alpha = 1
            model.useItem(.photoFragment2)
        }
        if model.hasItem(.photoFragment3),
            let fragment3Node = self.childNode(withName: "Fragment3") as? SKSpriteNode {
            fragment3Node.alpha = 1
            model.useItem(.photoFragment3)
        }
        if model.hasItem(.photoFragment4),
            let fragment4Node = self.childNode(withName: "Fragment4") as? SKSpriteNode {
            fragment4Node.alpha = 1
            model.useItem(.photoFragment4)
        }
        
    }
}
