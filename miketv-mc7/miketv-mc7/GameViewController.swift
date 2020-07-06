//
//  GameViewController.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
//    override var preferredFocusEnvironments: [UIFocusEnvironment] {
//        if let view = self.view as! SKView? {
//            return view.preferredFocusEnvironments
//        }
//        
//        return []
//    }

}
