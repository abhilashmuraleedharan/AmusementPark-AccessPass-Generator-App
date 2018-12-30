//
//  AudioPlayer.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import AudioToolbox

enum AudioType: String {
    case mp3
    case wav
}

enum SwipeStatus: String {
    case accessDenied = "AccessDenied"
    case accessGranted = "AccessGranted"
}

enum AudioError: Error {
    case invalidResource
}

struct AudioPlayer {
    private var swipeStatusAlertSound: SystemSoundID = 0
    
    mutating func playAlert(for status: SwipeStatus) {
        do {
            switch status {
            case .accessDenied:
                try load(audio: SwipeStatus.accessDenied.rawValue)
            case .accessGranted:
                try load(audio: SwipeStatus.accessGranted.rawValue)
            }
            play(swipeStatusAlertSound)
        } catch AudioError.invalidResource {
            fatalError("Unable to load audio. Necessary audio files are missing")
        } catch let error {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    /// Helper method to load an audio
    private mutating func load(audio: String, ofType type: AudioType = .wav) throws {
        guard let path = Bundle.main.path(forResource: audio, ofType: type.rawValue) else {
            throw AudioError.invalidResource
        }
        let audioUrl = URL(fileURLWithPath: path)
        AudioServicesCreateSystemSoundID(audioUrl as CFURL, &swipeStatusAlertSound)
    }
    
    /// Helper method to play an audio
    private func play(_ alertSound: SystemSoundID) {
        AudioServicesPlaySystemSound(alertSound)
    }
}
