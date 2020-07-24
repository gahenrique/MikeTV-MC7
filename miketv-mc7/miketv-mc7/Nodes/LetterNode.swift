//
//  LetterNode.swift
//  miketv-mc7
//
//  Created by gabriel on 23/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class LetterNode: SelectionableNode {
    
    override func didTap() {
        delegate?.changeScene(to: .LetterFocus, from: .Scene3)
    }
}
