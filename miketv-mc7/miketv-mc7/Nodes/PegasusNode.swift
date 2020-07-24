//
//  PegasusNode.swift
//  miketv-mc7
//
//  Created by gabriel on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class PegasusNode: SelectionableNode {
    
    override func didTap() {
        delegate?.setLines(line: "Meu lindo Pegasus! Ele adora voar acima das nuvens!", duration: 4)
    }
}
