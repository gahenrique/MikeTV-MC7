//
//  BooksNode.swift
//  miketv-mc7
//
//  Created by gabriel on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class BooksNode: SelectionableNode {
    
    override func didTap() {
        delegate?.setLines(line: "Adorava quando meus pais liam para eu dormir. Meu livro favorito é da moça que se transforma a meia noite!", duration: 6)
    }
}
