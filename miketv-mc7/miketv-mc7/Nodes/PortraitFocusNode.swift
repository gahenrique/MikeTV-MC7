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
        
        guard
            let fragment1Node = self.childNode(withName: "Fragment1") as? SKSpriteNode,
            let fragment2Node = self.childNode(withName: "Fragment2") as? SKSpriteNode,
            let fragment3Node = self.childNode(withName: "Fragment3") as? SKSpriteNode,
            let fragment4Node = self.childNode(withName: "Fragment4") as? SKSpriteNode,
            let passwordNode = self.childNode(withName: "Password") as? SKSpriteNode
        else { return }
        
        var insertedItem: Bool = false
        
        // Checking if player has fragments 2, 3 and 4
        if model.hasItem(.photoFragment2) {
            fragment2Node.alpha = 1
            model.useItem(.photoFragment2)
            insertedItem = true
        }
        if model.hasItem(.photoFragment3) {
            fragment3Node.alpha = 1
            model.useItem(.photoFragment3)
            insertedItem = true
        }
        if model.hasItem(.photoFragment4) {
            fragment4Node.alpha = 1
            model.useItem(.photoFragment4)
            insertedItem = true
        }
        
        if !insertedItem &&
            model.haveUsedItem(.photoFragment2) &&
            model.haveUsedItem(.photoFragment3) &&
            model.haveUsedItem(.photoFragment4) {
            let nextState = getNextState(current: model.scene3.photoState)
            model.scene3.photoState = nextState
            
            if nextState == .flipped {
                delegate?.setLines(line: "O que é isso? Parece uma senha", duration: 5)
                passwordNode.texture = SKTexture(imageNamed: model.scene1.passwordPhotoTexture)
                passwordNode.size = fragment1Node.size
            }
            
            let alpha: CGFloat = (nextState == .normal) ? 0 : 1
            passwordNode.alpha = alpha
            fragment1Node.alpha = 1-alpha
            fragment2Node.alpha = model.haveUsedItem(.photoFragment2) ? 1-alpha : 0
            fragment3Node.alpha = model.haveUsedItem(.photoFragment3) ? 1-alpha : 0
            fragment4Node.alpha = model.haveUsedItem(.photoFragment4) ? 1-alpha : 0
        }
    }
    
    private func getNextState(current: PhotoState) -> PhotoState {
        switch current {
        case .normal:
            return .flipped
        case .flipped:
            return .normal
        }
    }
}
