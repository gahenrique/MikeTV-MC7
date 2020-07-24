//
//  BedNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 09/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class BedNode: SelectionableNode {
    
    override func didTap() {
        delegate?.setLines(line: "Adoro minha cama, ela é tão macia!", duration: 3)
    }
}
