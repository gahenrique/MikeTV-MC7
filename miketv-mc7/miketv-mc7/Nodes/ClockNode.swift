//
//  ClockNode.swift
//  miketv-mc7
//
//  Created by gabriel on 20/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import Foundation

class ClockNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .ClockFocus, from: .Scene4)
    }
}
