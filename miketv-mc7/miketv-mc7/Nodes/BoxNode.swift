//
//  BoxNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 15/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import Foundation

class BoxNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .BoxFocus, from: .Scene1)
    }
}
