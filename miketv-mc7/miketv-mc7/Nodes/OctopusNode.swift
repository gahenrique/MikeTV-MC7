//
//  OctopusNode.swift
//  miketv-mc7
//
//  Created by gabriel on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class OctopusNode: SelectionableNode {
    
    override func didTap() {
        delegate?.setLines(line: "Essa é a senhora Opupu, ganhei ela quanto tinha 6 anos da minha mãe!")
    }
}
