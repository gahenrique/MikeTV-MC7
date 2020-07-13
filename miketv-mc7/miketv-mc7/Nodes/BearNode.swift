//
//  BearNode.swift
//  miketv-mc7
//
//  Created by gabriel on 10/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class BearNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .BearFocus)
    }
}
