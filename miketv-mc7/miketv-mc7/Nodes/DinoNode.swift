//
//  DinoNode.swift
//  miketv-mc7
//
//  Created by gabriel on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class DinoNode: SelectionableNode {
    
    override func didTap() {
        delegate?.setLines(line: "Rawh!", duration: 2)
    }
}
