//
//  PlantFocusNode.swift
//  miketv-mc7
//
//  Created by gabriel on 14/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class PlantFocusNode: SelectionableNode {
    
    override func didTap() {
        guard
            let model = delegate?.getModel()
        else { return }
        
        // If already got the key
        if model.scene2.plantState == .withoutKey {
            return
        }
        
        model.collectItem(.key)
        model.scene2.plantState = .withoutKey
        
        delegate?.setLines(line: "Peguei um chave! O que será que ela abre?", duration: 4)
        
        if let newTexture = model.scene2.plantTextures[.withoutKey] {
            texture = SKTexture(imageNamed: newTexture)
        }
    }
}
