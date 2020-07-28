//
//  DinoNode.swift
//  miketv-mc7
//
//  Created by gabriel on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class DinoNode: SelectionableNode {
    
    override func didTap() {
        guard let model = delegate?.getModel() else { return }
        
        if model.hasItem(.photoFragment3) || model.haveUsedItem(.photoFragment3) {
            delegate?.setLines(line: "Não quero mais brincar", duration: 3)
        } else {
            delegate?.setLines(line: "Rawh!", duration: 2)
        }
    }
}
