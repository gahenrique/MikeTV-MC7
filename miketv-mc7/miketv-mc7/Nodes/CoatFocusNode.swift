//
//  CoatFocusNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class CoatFocusNode: SelectionableNode {
    
    override func didTap() {
        guard
            let model = delegate?.getModel()
        else { return }
        
        let currentState = model.scene2.coatState
        
        let nextState = getNextState(current: currentState)
        
        if nextState != .destroyed,
            let newTexture = model.scene2.coatTextures[nextState] {
            model.scene2.coatState = nextState
            self.texture = SKTexture(imageNamed: newTexture)
        }
        
        if nextState == .openEmpty {
            model.scene2.coatState = .destroyed
        }
    }
    
    private func getNextState(current: CoatState) -> CoatState {
        switch current {
        case .normal:
            return .openWithMap
        case .openWithMap:
            return .openEmpty
        case .openEmpty:
            fallthrough
        case .destroyed:
            return .destroyed
        }
    }
}
