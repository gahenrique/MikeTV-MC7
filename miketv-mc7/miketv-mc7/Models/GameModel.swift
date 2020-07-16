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

enum PlantState {
    case withKey
    case withoutKey
}

enum DresserState {
    case closed
    case openedWithFragment
    case openedWithoutFragment
}

enum BoxState {
    case closed
    case open
    case destroyed
}

enum CollectionableItems: String {
    case photoFragment1 = "Parte1Inventario"
    case photoFragment2 = "Parte2Inventario"
    case photoFragment3 = "Parte3Inventario"
    case photoFragment4 = "Parte4Inventario"
    case key = "ChaveInventario"
    case courtainStuff = ""
}

class GameModel {
    
    private(set) var inventory: [CollectionableItems] = []
    
    // Game State Models
    var backgroundState: State = .normal
    let scene1 = Scene1Model()
    let scene2 = Scene2Model()
    let scene3 = Scene3Model()
    let scene4 = Scene4Model()
    
    func collectItem(_ item: CollectionableItems) {
        inventory.append(item)
    }
    
    func hasItem(_ item: CollectionableItems) -> Bool {
        inventory.contains(item)
    }
}

protocol SceneModel {
    var sceneName: SceneName { get set }
}

class Scene1Model: SceneModel {
    
    let randomPassword: String
    private let possiblePasswords: [String] = ["921", "803", "547"]
    
    init() {
        randomPassword = possiblePasswords.randomElement() ?? "921"
    }
    
    var currentPassword: [String] = ["0","0","0"]
    
    var sceneName: SceneName = .Scene1
    
    var bearTextures: [BearState: String] = [.normal: "Ursinho", .openedWithFragment: "UrsinhoAbertoFragmento", .openedWithoutFragment: "UrsinhoAberto", .destroyed: "UrsinhoDestruido"]
    var bearState: BearState = .normal
    
    //MARK: Add asset
    var boxTextures: [BoxState: String] = [.closed: "Caixa", .open: "CaixaAberta", .destroyed: ""]
    var boxState: BoxState = .closed
}

class Scene2Model: SceneModel {
    var sceneName : SceneName = .Scene2
    
    var plantTextures: [PlantState: String] = [.withKey: "PlantaChave", .withoutKey: "Planta"]
    var plantState: PlantState = .withKey
}

class Scene3Model: SceneModel {
    var sceneName : SceneName = .Scene3
}

class Scene4Model: SceneModel {
    var sceneName : SceneName = .Scene4
    
    // Only for focused
    var dresserTextures: [DresserState: String] = [.closed: "Comoda",.openedWithFragment: "ComodaAbertaFragmento", .openedWithoutFragment: "ComodaAberta"]
    var dresserState: DresserState = .closed
}

