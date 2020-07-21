//
//  CoatFocusNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class CoatFocusNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .CoatFocus)
    }
}
