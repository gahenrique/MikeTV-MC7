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
import AVFoundation

class GameViewController: UIViewController {
    
    private(set) var gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupMenu()
//        BackgroundSoundSetUp.shared.startBackgroundMusic()
    }
    
    let threshold: CGFloat = 192
    var firstPoint: CGPoint?
    public func touchDown(at pos: CGPoint) {
        firstPoint = pos
    }
    
    public func touchMoved(to pos: CGPoint) {
        checkSwipe(on: pos)
    }
    
    public func touchUp(at pos: CGPoint) {
        checkSwipe(on: pos)
    }
    
    private func checkSwipe(on pos: CGPoint) {
        guard let firstPoint = firstPoint else {
            return
        }
        let movement = CGPoint(x: pos.x - firstPoint.x, y: pos.y - firstPoint.y)
        let value = max(abs(movement.x), abs(movement.y))
        if value > threshold {
            self.firstPoint = pos
            if abs(movement.x) == value {
                if movement.x < 0 {
                    swipeOccur(direction: .left)
                } else {
                    swipeOccur(direction: .right)
                }
            } else if abs(movement.y) == value {
                if movement.y < 0 {
                    swipeOccur(direction: .up)
                } else {
                    swipeOccur(direction: .down)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(at: t.location(in: self.view)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(to: t.location(in: self.view)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(at: t.location(in: self.view)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(at: t.location(in: self.view)) }
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    private func swipeOccur(direction: UISwipeGestureRecognizer.Direction) {
        if let view = self.view as! SKView?,
            let scene = view.scene as? BaseGameScene {
            scene.didSwipe(direction: direction)
        }
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
                scene.setup(model: self.gameModel, commingFrom: .Menu)
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
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
    case LetterFocus = "LetterFocus"
}

extension GameViewController: GameSceneDelegate {
    func changeScene(to sceneName: SceneName, fromScene: SceneName) {
        if sceneName == .Menu {
            gameModel = GameModel()
        }
        
        if let view = self.view as! SKView?,
            let scene = BaseGameScene(fileNamed: sceneName.rawValue) {
            
            scene.sceneDelegate = self
            scene.scaleMode = .aspectFit
            view.presentScene(scene)
            
            scene.setup(model: self.gameModel, commingFrom: fromScene)
        }
    }
}
