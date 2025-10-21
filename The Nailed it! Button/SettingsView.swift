//
//  SettingsView.swift
//  The Nailed it! Button
//
//  Voice selection interface with preview playback
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedVoice") private var selectedVoice = "reed"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Select Voice")) {
                    ForEach(Array(AudioService.voices.keys.sorted()), id: \.self) { voiceKey in
                        Button(action: {
                            selectedVoice = voiceKey
                            AudioService.shared.playVoice(voiceKey)
                        }) {
                            HStack {
                                Text(AudioService.voices[voiceKey] ?? voiceKey)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if selectedVoice == voiceKey {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    Text("Tap a voice to preview")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
