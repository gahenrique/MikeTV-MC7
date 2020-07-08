//
//  BaseGameScene.swift
//  miketv-mc7
//
//  Created by gabriel on 08/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit

class BaseGameScene: SKScene {
    weak var sceneDelegate: GameSceneDelegate?
    
    func didSwipe(direction: UISwipeGestureRecognizer.Direction) {}
    
    func didTap() {}
}
