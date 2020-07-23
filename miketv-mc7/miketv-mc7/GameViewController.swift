//
//  GameViewController.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import UIKit
import SpriteKit
import GameController

class GameViewController: UIViewController {
    
    private(set) var gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupMenu()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeRightGesture.direction = .right
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeUpGesture.direction = .up
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeDownGesture.direction = .down
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
        view.addGestureRecognizer(swipeUpGesture)
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        if let view = self.view as! SKView?,
            let scene = view.scene as? BaseGameScene {
            scene.didTap()
        }
    }
    
    @objc private func swipeGestureHandler(_ sender: UISwipeGestureRecognizer) {
        if let view = self.view as! SKView?,
            let scene = view.scene as? BaseGameScene {
            scene.didSwipe(direction: sender.direction)
        }
    }
    
    private func setupMenu() {
        if let view = self.view as! SKView? {
            // Load the SKScene from .sks
            if let scene = SKScene(fileNamed: "MainScene") as? BaseGameScene {
                scene.sceneDelegate = self
                scene.setupModel(model: self.gameModel)
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

enum SceneName: String {
    case Tutorial = "TutorialScene"
    case Menu = "MainScene"
    case Scene0 = "Scene0"
    case Scene1 = "Scene1"
    case Scene2 = "Scene2"
    case Scene3 = "Scene3"
    case Scene4 = "Scene4"
    case BearFocus = "BearFocus"
    case PlantFocus = "PlantFocus"
    case DresserFocus = "DresserFocus"
    case BoxFocus = "BoxFocus"
    case ClockFocus = "ClockFocus"
    case CoatFocus = "CoatFocus"
    case PortraitFocus = "PortraitFocus"
    case DoorFocus = "DoorFocus"
}

extension GameViewController: GameSceneDelegate {
    func changeScene(to sceneName: SceneName) {
        if sceneName == .Menu {
            gameModel = GameModel()
        }
        
        if let view = self.view as! SKView?,
            let scene = BaseGameScene(fileNamed: sceneName.rawValue) {
            
            scene.sceneDelegate = self
            scene.scaleMode = .aspectFit
            view.presentScene(scene)
            
            scene.setupModel(model: self.gameModel)
        }
    }
}
