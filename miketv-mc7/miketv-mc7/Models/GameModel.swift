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

enum BearState {
    case normal
    case openedWithFragment
    case openedWithoutFragment
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

protocol SceneModel {
    var sceneName: SceneName { get set }
}

class Scene1Model: SceneModel {
    var sceneName: SceneName = .Scene1
    
    var bearTextures: [BearState: String] = [.normal: "Ursinho", .openedWithFragment: "UrsinhoAbertoFragmento", .openedWithoutFragment: "UrsinhoAberto", .destroyed: "UrsinhoDestruido"]
    
    var bearState: BearState = .normal
}

class Scene2Model: SceneModel {
    var sceneName : SceneName = .Scene2
}

class Scene3Model: SceneModel {
    var sceneName : SceneName = .Scene3
}

class Scene4Model: SceneModel {
    var sceneName : SceneName = .Scene4
}

