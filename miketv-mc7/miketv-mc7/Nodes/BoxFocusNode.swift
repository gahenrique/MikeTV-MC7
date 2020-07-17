//
//  BoxFocusNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 17/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class BoxFocusNode: SelectionableNode {
    
    override func didTap() {
        
        guard
            let model = delegate?.getModel()
        else { return }
        
        if !model.hasItem(.gift) {
            delegate?.setLines(line: "Está trancado!")
            return
        }
        
        let currentState = model.scene1.boxState
        let nextState = getNextStage(current: currentState)
        
        if let newTexture = model.scene1.boxTextures[nextState] {
            texture = SKTexture(imageNamed: newTexture)
        }
    }
    
    private func getNextStage(current: BoxState) -> BoxState {
        switch current {
        case .closed:
            return .open
        case .open:
            return .destroyed
        default:
            return .closed
        }
    }
}
