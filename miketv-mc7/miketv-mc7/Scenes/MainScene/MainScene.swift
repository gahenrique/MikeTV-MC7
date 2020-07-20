//
//  MainScene.swift
//  miketv-mc7
//
//  Created by Juliana Vigato Pavan on 20/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class MainScene: BaseGameScene {
    private var buttons: [SelectionableNode] = []
    private var currentFocused: SelectionableNode?
    
    private var btnPlay: SelectionableNode?
    private var btnTutorial: SelectionableNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let btnPlay = self.childNode(withName: "btnPlay") as? SelectionableNode,
            let btnTutorial = self.childNode(withName: "btnTutorial") as? SelectionableNode            
            else { return }
        
        self.btnPlay = btnPlay
        self.btnTutorial = btnTutorial
        
        buttons.append(btnPlay)
        buttons.append(btnTutorial)
        
        self.currentFocused = btnPlay
        self.currentFocused?.buttonDidGetFocus()

    }
    
    override func didTap() {
        if let currentFocused = self.currentFocused {
            if currentFocused == btnPlay {
                sceneDelegate?.changeScene(to: .Scene0)
            } else if currentFocused == btnTutorial {
                //MARK: Criar scene de tutorial
                sceneDelegate?.changeScene(to: .Scene1)
            }
        }
        currentFocused?.didTap()
    }
    
    override func didSwipe(direction: UISwipeGestureRecognizer.Direction) {
        guard
            let currentFocused = self.currentFocused,
            let currentFocusedIndex = buttons.firstIndex(of: currentFocused)
            else { return }
        
        currentFocused.buttonDidLoseFocus()
        
        var nextFocusIndex: Int = currentFocusedIndex
        
        switch direction {
        case .up:
            nextFocusIndex = currentFocusedIndex > 0 ? currentFocusedIndex - 1 : 0
        case .down:
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


