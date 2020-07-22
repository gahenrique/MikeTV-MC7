//
//  BoxFocusNode.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 22/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

protocol BoxFocusNodeDelegate: AnyObject {
    func showGift()
}

class BoxFocusNode: SelectionableNode {
    
    weak var delegateBox: BoxFocusNodeDelegate?
    
    override func didTap() {
        delegateBox?.showGift()
    }
}
