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

protocol GameSceneProtocol {
    func didSwipe(direction: UISwipeGestureRecognizer.Direction)
    func didTap()
}

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupScene1()
    }
    
    private func setupGestures() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        swipeRightGesture.direction = .right
        
//        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let normalizedForce = touch.force/touch.maximumPossibleForce
        print("Touch force = \(normalizedForce)")
    }
    
    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        if let view = self.view as! SKView?,
            let scene = view.scene as? GameSceneProtocol {
            scene.didTap()
        }
    }
    
    @objc private func swipeGestureHandler(_ sender: UISwipeGestureRecognizer) {
        if let view = self.view as! SKView?,
            let scene = view.scene as? GameSceneProtocol {
            scene.didSwipe(direction: sender.direction)
        }
    }
    
    private func setupScene1() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Scene1") as? Scene1 {
                scene.sceneDelegate = self
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    private func setupGameScene() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

extension GameViewController: GameSceneDelegate {
    func changeScene(sceneName: String) {
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: sceneName) {
//                scene.sceneDelegate = self
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
        }
        
    }
}
