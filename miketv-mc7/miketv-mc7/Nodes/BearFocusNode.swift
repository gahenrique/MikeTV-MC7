//
//  BearFocusNode.swift
//  miketv-mc7
//
//  Created by gabriel on 13/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class BearFocusNode: SelectionableNode {
    
    override func didTap() {
        guard
            let model = delegate?.getModel()
        else { return }
        
        let currentState = model.scene1.bearState
        
        let nextState = getNextState(current: currentState)
        
        if nextState != .destroyed,
            let newTexture = model.scene1.bearTextures[nextState] {
            model.scene1.bearState = nextState
            self.texture = SKTexture(imageNamed: newTexture)
        }
        
        if nextState == .openedWithoutFragment {
            model.scene1.bearState = .destroyed
            if model.scene2.coatState == .normal {
                model.scene2.coatState = .closedDestroyed
            } else if model.scene2.coatState == .openWithMap {
                model.scene2.coatState = .openDestroyed
            }
            model.collectItem(.photoFragment2)
            delegate?.setLines(line: "O que é isso? Um pedaço da foto!", duration: 4)
        }
    }
    
    private func getNextState(current: BearState) -> BearState {
        switch current {
        case .normal:
            return .openedWithFragment
        case .openedWithFragment:
            return .openedWithoutFragment
        case .openedWithoutFragment:
            fallthrough
        case .destroyed:
            return .destroyed
        }
    }
}
