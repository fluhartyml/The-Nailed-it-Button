//
//  AudioService.swift
//  The Nailed it! Button
//
//  Audio playback management for voice files
//
//  Last updated: 2025 OCT 21 0836
//

import AVFoundation

class AudioService {
    static let shared = AudioService()
    
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        // Configure audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func playVoice(_ voiceName: String) {
        // Load from bundle
        guard let url = Bundle.main.url(forResource: "nailed-it-\(voiceName)", withExtension: "aiff") else {
            print("Audio file not found: nailed-it-\(voiceName).aiff")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play audio: \(error)")
        }
    }
    
    // Available voices
    static let voices = [
        "reed": "Reed (Professional)",
        "zarvox": "Zarvox (Classic Robot)",
        "rishi": "Rishi (Smooth Robot)",
        "rocko": "Rocko (Energetic Robot)",
        "albert": "Albert (Gruff Robot)"
    ]
}
