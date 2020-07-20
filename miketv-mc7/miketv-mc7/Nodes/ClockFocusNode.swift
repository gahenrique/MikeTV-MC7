//
//  ClockFocusNode.swift
//  miketv-mc7
//
//  Created by gabriel on 20/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class ClockFocusNode: SelectionableNode {
    
    override func didTap() {
        guard
            let model = delegate?.getModel()
        else { return }
        
        // TODO: Check if player has key
        if !model.hasItem(.courtainStuff) {
            delegate?.setLines(line: "Tem algo errado nesse relógio...")
            return
        }
        
        let currentState = model.scene4.clockState
        let nextState = getNextState(current: currentState)
        
        if currentState == .fixedOpenWithFragment {
            model.collectItem(.photoFragment3)
        }
        
        model.scene4.clockState = nextState
        
        if nextState != .openDestroyed,
            let newTexture = model.scene4.clockTextures[nextState] {
            self.texture = SKTexture(imageNamed: newTexture)
        }
    }
    
    private func getNextState(current: ClockState) -> ClockState {
        switch current {
        case .normal:
            return .fixed
        case .fixed:
            return .fixedOpenWithFragment
        case .fixedOpenWithFragment:
            return .fixedOpenEmpty
        default:
            return .openDestroyed
        }
    }
}
