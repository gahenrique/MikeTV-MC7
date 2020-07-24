//
//  PlantNode.swift
//  miketv-mc7
//
//  Created by gabriel on 14/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class PlantNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .PlantFocus, from: .Scene2)
    }
}
