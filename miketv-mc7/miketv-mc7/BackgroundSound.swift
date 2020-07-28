//
//  BackgorundSound.swift
//  miketv-mc7
//
//  Created by Luiza Fattori on 28/07/20.
//  Copyright © 2020 gabriel. All rights reserved.
//

import Foundation
import AVFoundation

class BackgroundSoundSetUp {
    static let shared = BackgroundSoundSetUp()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "themeSong", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
}
