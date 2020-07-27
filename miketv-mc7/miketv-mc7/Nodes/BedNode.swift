//
//  BedNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 09/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class BedNode: SelectionableNode {
    
    override func didTap() {
        guard let model = delegate?.getModel() else { return }
        
        if model.haveUsedItem(.photoFragment2) || model.hasItem(.photoFragment2) {
            delegate?.setLines(line: "Às vezes não consigo dormir por conta dos barulhos", duration: 4)
        } else {
            delegate?.setLines(line: "Adoro minha cama, ela é tão macia!", duration: 3)
        }
    }
}
