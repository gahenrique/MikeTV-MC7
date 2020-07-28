//
//  LampNode.swift
//  miketv-mc7
//
//  Created by gabriel on 28/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class LampNode: SelectionableNode {
    
    override func didTap() {
        delegate?.setLines(line: "Já tem um tempo que não funciona…", duration: 3)
    }
}
