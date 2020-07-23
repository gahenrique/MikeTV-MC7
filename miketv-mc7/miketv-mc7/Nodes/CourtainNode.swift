//
//  CourtainNode.swift
//  miketv-mc7
//
//  Created by gabriel on 20/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class CourtainNode: SelectionableNode {
    
    override func didTap() {
        guard let model = delegate?.getModel() else { return }
        
        let nextState = getNextState(current: model.scene4.courtainState)
        
        if model.scene4.courtainState != .broken,
            let newTexture = model.scene4.courtainTextures[nextState] {
            model.scene4.courtainState = nextState
            self.texture = SKTexture(imageNamed: newTexture)
            
            if nextState == .broken {
                model.collectItem(.courtainStuff)
                updateHighlight()
            } else if nextState == .firstTap {
                delegate?.setLines(line: "Cuidado! Tá caindo")
            } else if nextState == .secondTap {
                delegate?.setLines(line: "Mais um pouco e vai cair")
            }
        }
    }
    
    private func getNextState(current: CourtainState) -> CourtainState {
        switch current {
        case .normal:
            return .firstTap
        case .firstTap:
            return .secondTap
        default:
            return .broken
        }
    }
    
    override func buttonDidGetFocus() {
        super.buttonDidGetFocus()
        
        self.position.y -= 20
    }
    
    override func buttonDidLoseFocus() {
        super.buttonDidLoseFocus()
        
        self.position.y += 20
    }
    
    func updateHighlight() {
        if let highlight = self.childNode(withName: "Highlight") as? SKSpriteNode {
            highlight.texture = SKTexture(imageNamed: "CortinaQuebradaHighlight")
        }
    }
}
