//
//  GameSceneDelegate.swift
//  miketv-mc7
//
//  Created by gabriel on 08/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import UIKit

protocol GameSceneDelegate: NSObject {
    func changeScene(to sceneName: SceneName, fromScene: SceneName)
}
