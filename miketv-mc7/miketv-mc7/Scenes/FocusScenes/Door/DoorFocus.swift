//
//  DoorFocus.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 22/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class DoorFocus: BaseGameScene {
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var noButton: SelectionableNode?
    private var yesButton: SelectionableNode?
    private var arrowNode: SelectionableNode?
    private var backgroundNode: SKSpriteNode?
    private var finalText: SKLabelNode?
    private var count: Int = 0
    private var choice: Int = 0 // 0: Yes ; 1: No
    
    let arrayYes: [String] = ["Quando saiu você viu quem eram os verdadeiros monstros. Não são aqueles que moram no seu armário, ou embaixo da sua cama. São aqueles que comandam e mandam outros em seu nome para matar e destruir.", "Você é uma criança que está sem o pai e não sabe se o terá de volta. A guerra, os conflitos armados, a ganância e sede por poder deixam milhares de crianças órfãs todo o ano.", "Para essas crianças, viver no mundo da fantasia seria muito melhor, mas a realidade delas é bastante dura.", "Você não pode fechar os olhos para essa realidade e fingir que está em um mundo encantado.", "Você pode ser a diferença. Conheça organizações que trabalham com orfandade, com refugiados de guerra e que promovem a paz.", "Não podemos ignorar a nossa realidade. Decida fazer a diferença."]
    
    let arrayNo: [String] = ["Você decidiu não sair, preferiu ficar na segurança do seu quarto, longe dos monstros de lá de fora. Eles são bem mais assustadores do que os que moram nos armários ou debaixo da cama.", "Você é uma criança que está sem o pai e não sabe se o terá de volta. A guerra, os conflitos armados, a ganância e sede por poder deixão milhares de crianças órfãs todo o ano.", "Para essas crianças, viver no mundo da fantasia é a melhor alternativa que elas têm, já que a realidade delas é bastante dura.", "Elas podem continuar no mundo da fantasia, mas você pode ser a diferença. Você pode lutar contra esses monstros de verdade.", "Conheça organizações que trabalham com orfandade, com refugiados de guerra e que promovem a paz.", "Não podemos ignorar a nossa realidade. Decida fazer a diferença."]
    
    override func didMove(to view: SKView) {
        
        guard
            let yesButton = self.childNode(withName: "YesButton") as? SelectionableNode,
            let noButton = self.childNode(withName: "NoButton") as? SelectionableNode,
            let arrowNode = self.childNode(withName: "BackArrowRight") as? SelectionableNode,
            let backgroundNode = self.childNode(withName: "background") as? SKSpriteNode,
            let finalText = self.childNode(withName: "FinalText") as? SKLabelNode
            else { return }
        
        self.yesButton = yesButton
        self.noButton = noButton
        self.arrowNode = arrowNode
        self.backgroundNode = backgroundNode
        self.finalText = finalText
        
        buttons.append(yesButton)
        buttons.append(noButton)
        
        self.currentFocused = yesButton
        self.currentFocused?.buttonDidGetFocus()
    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == yesButton {
                choice = 0
                showArrow()
                changeText(arrayText: arrayYes)
            } else if currentFocused == noButton {
                choice = 1
                showArrow()
                changeText(arrayText: arrayNo)
            } else {
                if choice == 0 {
                    changeText(arrayText: arrayYes)
                } else {
                    changeText(arrayText: arrayNo)
                }
            }
        }
        currentFocused?.didTap()
    }
    
    func showArrow() {
        yesButton?.alpha = 0
        noButton?.alpha = 0
        backgroundNode?.alpha = 0
        finalText?.alpha = 1
        if let arrowNode = arrowNode {
            buttons = [arrowNode]
            arrowNode.alpha = 1
            currentFocused = arrowNode
            arrowNode.buttonDidGetFocus()
        }
    }
    
    func changeText(arrayText: [String]) {
        if count < 6 {
            finalText?.text = arrayText[count]
            count += 1
        } else {
            sceneDelegate?.changeScene(to: .Menu)
        }
    }
    
    override func didSwipe(direction: UISwipeGestureRecognizer.Direction) {
        guard
            let currentFocused = self.currentFocused,
            let currentFocusedIndex = buttons.firstIndex(of: currentFocused)
            else { return }
        
        currentFocused.buttonDidLoseFocus()
        
        var nextFocusIndex: Int = currentFocusedIndex
        
        switch direction {
        case .left:
            nextFocusIndex = currentFocusedIndex > 0 ? currentFocusedIndex - 1 : 0
        case .right:
            let lastIndex = buttons.count - 1
            nextFocusIndex = currentFocusedIndex < lastIndex ? currentFocusedIndex + 1 : lastIndex
            break
        default:
            break
        }
        
        self.currentFocused = buttons[nextFocusIndex]
        self.currentFocused?.buttonDidGetFocus()
    }
}
