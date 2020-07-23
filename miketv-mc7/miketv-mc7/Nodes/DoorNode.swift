//
//  DoorNode.swift
//  miketv-mc7
//
//  Created by gabriel on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class DoorNode: SelectionableNode {
    
    override func didTap() {
        guard
            let model = delegate?.getModel()
        else { return }
        
        if model.haveUsedItem(.gift) {
            delegate?.changeScene(to: .DoorFocus)
        } else {
            delegate?.setLines(line: "Não posso ir lá fora, existem muitos monstros lá!")
        }
    }
}
