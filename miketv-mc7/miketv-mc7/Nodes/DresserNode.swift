//
//  DresserNode.swift
//  miketv-mc7
//
//  Created by gabriel on 14/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class DresserNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .DresserFocus, from: .Scene4)
    }
}
