//
//  PortraitNode.swift
//  miketv-mc7
//
//  Created by gabriel on 22/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class PortraitNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .PortraitFocus, from: .Scene3)
    }
}
