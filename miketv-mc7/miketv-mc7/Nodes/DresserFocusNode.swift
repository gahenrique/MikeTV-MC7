//
//  DresserFocusNode.swift
//  miketv-mc7
//
//  Created by gabriel on 14/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class DresserFocusNode: SelectionableNode {
    
    override func didTap() {
        guard
            let model = delegate?.getModel()
        else { return }
        
        // TODO: Check if player has key
        if !model.hasItem(.key) {
            delegate?.setLines(line: "Tá trancado!")
            return
        }
        
        let currentState = model.scene4.dresserState
        let nextState = getNextState(current: currentState)
        
        switch currentState {
        case .closed:
            model.scene4.dresserState = .openedWithFragment
        case .openedWithFragment:
            model.collectItem(.photoFragment4)
            model.scene4.dresserState = .openedWithoutFragment
        default:
            return
        }
        
        if let newTexture = model.scene4.dresserTextures[nextState] {
            texture = SKTexture(imageNamed: newTexture)
        }
    }
    
    private func getNextState(current: DresserState) -> DresserState {
        switch current {
        case .closed:
            return .openedWithFragment
        case .openedWithFragment:
            fallthrough
        default:
            return .openedWithoutFragment
        }
    }
}
