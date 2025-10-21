//
//  ContentView.swift
//  The Nailed it! Button
//
//  Main button interface with hazard stripe design
//

import SwiftUI

struct ContentView: View {
    @State private var isPressed = false
    @AppStorage("selectedVoice") private var selectedVoice = "reed"
    @State private var showSettings = false
    
    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            
            VStack {
                // Settings button in top-right
                HStack {
                    Spacer()
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.7))
                            .padding()
                    }
                }
                
                Spacer()
                
                // The Big Red Button
                Button(action: {
                    pressButton()
                }) {
                    ZStack {
                        // Base circle
                        Circle()
                            .fill(Color.red)
                            .frame(width: 280, height: 280)
                            .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                        
                        // Hazard stripes overlay
                        HazardStripes()
                            .frame(width: 280, height: 280)
                            .clipShape(Circle())
                            .opacity(0.6)
                        
                        // Button text
                        Text("NAILED IT!")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
                    }
                }
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
    
    private func pressButton() {
        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .heavy)
        impact.impactOccurred()
        
        // Button press animation
        isPressed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPressed = false
        }
        
        // Play audio
        AudioService.shared.playVoice(selectedVoice)
    }
}

// Hazard stripe pattern view
struct HazardStripes: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<20) { index in
                    Rectangle()
                        .fill(index % 2 == 0 ? Color.yellow : Color.red)
                        .frame(width: 60)
                        .rotationEffect(.degrees(45))
                        .offset(x: CGFloat(index * 40) - geometry.size.width)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
