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
    
    private(set) var model: GameModel?
    
    private(set) var inventoryNode: InventoryNode?
    
    func didSwipe(direction: UISwipeGestureRecognizer.Direction) {}
    
    func didTap() {}
    
    func setupModel(model: GameModel) {
        self.model = model
    }
    
    func setupInventory(items: [CollectionableItems]) {
        let inventoryNode = InventoryNode(screenSize: self.size)
        self.inventoryNode = inventoryNode
        addChild(inventoryNode)
        
        inventoryNode.updateItems(items)
    }
}

class InventoryNode: SKSpriteNode {
    
    private let firstItemMargin: CGFloat = 175
    private let lastItemMargin: CGFloat = 100
    private let itemSize: CGSize
    private let itemSpacing: CGFloat = 25
    let maxItems: Int
    
    var itemsNodes: [SKSpriteNode] = []
    
    init (screenSize: CGSize) {
        let width: CGFloat = 1740
        let height: CGFloat = 146
        
        self.itemSize = CGSize(width: height-25, height: height-25)
        
        let validWidth = width - firstItemMargin - lastItemMargin
        self.maxItems = Int(validWidth/(itemSize.width+itemSpacing))
        
        super.init(texture: SKTexture(imageNamed: "InventoryBackground"), color: UIColor.white, size: CGSize(width: width, height: height))
        
        let inventoryPosition = CGPoint(x: 0, y: screenSize.height/2 - height/2)
        self.position = inventoryPosition
        
        self.zPosition = 10
        
        // Bag Node
        let bagNode = SKSpriteNode(imageNamed: "InventoryBag")
        addChild(bagNode)
        bagNode.zPosition = 1
        bagNode.position = CGPoint(x: -width/2 + 50, y: -25)
        bagNode.size = CGSize(width: 200, height: 158)
        
        
        self.setupNodesItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateItems(_ items: [CollectionableItems]) {
        for i in 0..<items.count {
            self.itemsNodes[i].texture = SKTexture(imageNamed: items[i].rawValue)
        }
        for i in items.count ..< maxItems {
            self.itemsNodes[i].texture = nil
        }
    }
    
    func setupNodesItems() {
        for i in 0..<maxItems {
            let itemNode = SKSpriteNode(color: .clear, size: itemSize)
            itemNode.zPosition = 1
            
            let aux = CGFloat(i)
            let xPos: CGFloat = (firstItemMargin + itemSize.width/2 + aux*itemSize.width + aux*itemSpacing) - size.width/2
            itemNode.position = CGPoint(x: xPos, y: 0)
            
            addChild(itemNode)
            self.itemsNodes.append(itemNode)
        }
    }
}
