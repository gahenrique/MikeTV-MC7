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

enum CourtainState {
    case normal
    case firstTap
    case secondTap
    case broken
    case brokenDestroyed
    case destroyed
}

enum ClockState {
    case normal
    case fixed
    case fixedOpenWithFragment
    case fixedOpenEmpty
    case openDestroyed
}

enum CoatState {
    case normal
    case openWithMap
    case closedDestroyed
    case openDestroyed
}

enum PhotoState {
    case normal
    case flipped
}

enum CollectionableItems: String {
    case photoFragment1 = "Parte1Inventario"
    case photoFragment2 = "Parte2Inventario"
    case photoFragment3 = "Parte3Inventario"
    case photoFragment4 = "Parte4Inventario"
    case key = "ChaveInventario"
    case courtainStuff = ""
    case gift = "gift"
}

class GameModel {
    
    private(set) var inventory: [CollectionableItems] = []
    private(set) var usedItems: [CollectionableItems] = []
    
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
    
    func useItem(_ item: CollectionableItems) {
        if let itemIndex = inventory.firstIndex(of: item) {
            inventory.remove(at: itemIndex)
            usedItems.append(item)
        }
    }
    
    func haveUsedItem(_ item: CollectionableItems) -> Bool {
        usedItems.contains(item)
    }
}

protocol SceneModel {
    var sceneName: SceneName { get set }
}

class Scene1Model: SceneModel {
    
    let randomPassword: String
    let passwordPhotoTexture: String
    private let possiblePasswords: [String] = ["921", "803", "547"]
        
    init() {
        let randomIndex = Int.random(in: 0..<possiblePasswords.count)
        randomPassword = possiblePasswords[randomIndex]
        passwordPhotoTexture = "PhotoPassword\(randomIndex+1)"
    }
    
    var currentPassword: [String] = ["0","0","0"]
    
    var sceneName: SceneName = .Scene1
    
    var bearTextures: [BearState: String] = [.normal: "Ursinho", .openedWithFragment: "UrsinhoAbertoFragmento", .openedWithoutFragment: "UrsinhoAberto", .destroyed: "UrsinhoDestruido"]
    var bearState: BearState = .normal
    
    //MARK: Add asset
    var boxTextures: [BoxState: String] = [.closed: "Caixa", .open: "CaixaAberta", .destroyed: "CaixaDestruida"]
    var boxState: BoxState = .closed
}

class Scene2Model: SceneModel {
    var sceneName : SceneName = .Scene2
    
    var plantTextures: [PlantState: String] = [.withKey: "PlantaChave", .withoutKey: "Planta"]
    var plantState: PlantState = .withKey
    
    var coatTextures: [CoatState: String] = [.normal: "CoatFocusClosed", .openWithMap: "CoatFocusWithMap", .closedDestroyed: "CoatClosedDestroyed", .openDestroyed: "CoatDestroyed"]
    var coatState: CoatState = .normal
}

class Scene3Model: SceneModel {
    var sceneName : SceneName = .Scene3
    
    var photoState: PhotoState = .normal
}

class Scene4Model: SceneModel {
    var sceneName : SceneName = .Scene4
    
    // Only for focused
    var dresserTextures: [DresserState: String] = [.closed: "Comoda",.openedWithFragment: "ComodaAbertaFragmento", .openedWithoutFragment: "ComodaAberta"]
    var dresserState: DresserState = .closed
    
    // Courtain
    var courtainState: CourtainState = .normal
    var courtainTextures: [CourtainState: String] = [.normal: "Cortina", .firstTap: "Cortina", .secondTap: "Cortina", .broken: "CortinaQuebrada", .brokenDestroyed: "CortinaQuebrada", .destroyed: "Cortina"]
    
    // Clock
    var clockState: ClockState = .normal
    var clockTextures: [ClockState: String] = [.normal: "Relogio", .fixed: "RelogioImaginarioArrumado", .fixedOpenWithFragment: "RelogioImaginarioAbertoFragmento", .fixedOpenEmpty: "RelogioImaginarioAbertoVazio", .openDestroyed: "RelogioRealAberto"]
}
