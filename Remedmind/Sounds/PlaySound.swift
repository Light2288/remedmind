//
//  PlaySound.swift
//  Remedmind
//
//  Created by Davide Aliti on 29/08/23.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(soundName: String, type: String) {
    guard let path = Bundle.main.path(forResource: soundName, ofType: type) else { return }
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
        audioPlayer?.play()
    } catch {
        print("Could not play the sound")
    }
}
