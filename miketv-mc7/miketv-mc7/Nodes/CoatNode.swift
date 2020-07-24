//
//  CoatNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import Foundation

class CoatNode: SelectionableNode {
    override func didTap() {
        delegate?.changeScene(to: .CoatFocus, from: .Scene2)
    }
}
