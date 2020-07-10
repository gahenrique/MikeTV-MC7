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
    
    let gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupScene1()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeRightGesture.direction = .right
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
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
    
    private func setupScene1() {
        if let view = self.view as! SKView? {
            // Load the SKScene from .sks
            if let scene = SKScene(fileNamed: "Scene1") as? Scene1 {
                scene.sceneDelegate = self
                scene.setupModel(model: self.gameModel.scene1)
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
    case Scene1 = "Scene1"
    case Scene2 = "Scene2"
    case Scene3 = "Scene3"
    case Scene4 = "Scene4"
}

extension GameViewController: GameSceneDelegate {
    func changeScene(to sceneName: SceneName) {
        if let view = self.view as! SKView?,
            let scene = BaseGameScene(fileNamed: sceneName.rawValue) {
                scene.sceneDelegate = self
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            
            switch sceneName {
            case .Scene1:
                scene.setupModel(model: self.gameModel.scene1)
            default:
                break
            }
        }
    }
}
