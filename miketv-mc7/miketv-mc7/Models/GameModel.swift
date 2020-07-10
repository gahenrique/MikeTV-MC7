//
//  GameModel.swift
//  miketv-mc7
//
//  Created by gabriel on 10/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import Foundation

enum State {
    case normal
    case destroyed
}

class GameModel {
    
    enum CollectionableItems {
        case photoFragment1
        case photoFragment2
        case photoFragment3
        case key
        case courtainStuff
    }
    
    var inventory: [CollectionableItems] = []
    
    // Game State Models
    var backgroundState: State = .normal
    let scene1 = Scene1Model()
    
}

class SceneModel {
    let sceneName: String
    
    init(sceneName: String) {
        self.sceneName = sceneName
    }
}

class Scene1Model: SceneModel {
    
    var bearTextures: [State: String] = [.normal: "Ursinho", .destroyed: "UrsinhoDestruido"]
    
    init() {
        super.init(sceneName: "Scene1")
    }
    
    var bearState: State = .normal
}
