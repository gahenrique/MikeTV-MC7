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
        if !model.hasItem(.courtainStuff) && !model.haveUsedItem(.courtainStuff) {
            return
        } else if model.hasItem(.courtainStuff) {
            model.useItem(.courtainStuff)
        }
        
        let currentState = model.scene4.clockState
        let nextState = getNextState(current: currentState)
        
        if nextState == .fixed {
            delegate?.setLines(line: "Deu certo! A argola da cortina serviu para algo", duration: 5)
        } else if nextState == .fixedOpenEmpty {
            model.collectItem(.photoFragment3)
            delegate?.setLines(line: "Um pedaço da foto do pai!", duration: 3)
        }
        
        model.scene4.clockState = nextState
        
        if nextState != .openDestroyed,
            let newTexture = model.scene4.clockTextures[nextState] {
            self.texture = SKTexture(imageNamed: newTexture)
        }
        
        if nextState == .fixedOpenEmpty {
            model.scene4.clockState = .openDestroyed
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
