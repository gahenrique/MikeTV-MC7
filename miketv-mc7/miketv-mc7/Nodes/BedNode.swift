//
//  BedNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 09/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import Foundation

class BedNode: SelectionableNode {
    
    override func didTap() {
        delegate?.setLines(line: "Hello There")
    }
}
