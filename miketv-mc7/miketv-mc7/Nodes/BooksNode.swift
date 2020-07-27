//
//  BooksNode.swift
//  miketv-mc7
//
//  Created by gabriel on 21/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

class BooksNode: SelectionableNode {
    
    override func didTap() {
        guard let model = delegate?.getModel() else { return }
        
        if model.haveUsedItem(.photoFragment2) || model.hasItem(.photoFragment2) {
            delegate?.setLines(line: "Faz tempo que meu pai não vem ler para mim", duration: 4)
        } else {
            delegate?.setLines(line: "Adorava quando meus pais liam para eu dormir. Meu livro favorito é da moça que se transforma a meia noite!", duration: 6)
        }
    }
}
