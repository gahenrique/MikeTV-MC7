//
//  GameScene.swift
//  miketv-mc7
//
//  Created by gabriel on 06/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var buttons: [SelectionableNode] = []
    
    private var currentFocused: SelectionableNode?
    
    override func didMove(to view: SKView) {
        
        guard
            let button1 = self.childNode(withName: "Button1") as? SelectionableNode,
            let button2 = self.childNode(withName: "Button2") as? SelectionableNode,
            let button3 = self.childNode(withName: "Button3") as? SelectionableNode,
            let button4 = self.childNode(withName: "Button4") as? SelectionableNode
        else { return }
        
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        print("Touch Down")
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        print("Touch Moved")
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        print("Touch Up")
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("Touches Began")
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("Touches Moved")
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("Touches Ended")
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("Touches Cancelled")
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        print("Presses Ended")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        let prevItem = context.previouslyFocusedItem
        let nextItem = context.nextFocusedItem
        
        if let prevButton = prevItem as? SelectionableNode {
            prevButton.buttonDidLoseFocus()
        }
        if let nextButton = nextItem as? SelectionableNode {
            nextButton.buttonDidGetFocus()
            currentFocused = nextButton
        }
    }
}
