//
//  ContentView.swift
//  The Nailed it! Button
//
//  Main button interface with industrial hazard stripe design
//

import SwiftUI

struct ContentView: View {
    @State private var isPressed = false
    @AppStorage("selectedVoice") private var selectedVoice = "reed"
    @State private var showSettings = false
    
    var body: some View {
        ZStack {
            // Diagonal hazard stripe background
            HazardStripeBackground()
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
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.black.opacity(0.6)))
                    }
                    .padding()
                }
                
                Spacer()
                
                // Industrial button panel with hardware
                ZStack {
                    // Aluminum metal panel (square behind button)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(white: 0.75),
                                    Color(white: 0.55),
                                    Color(white: 0.65)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 360, height: 360)
                        .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 8)
                    
                    // Hardware bolts in corners of the aluminum panel
                    HexBolt()
                        .offset(x: -155, y: -155)
                    HexBolt()
                        .offset(x: 155, y: -155)
                    HexBolt()
                        .offset(x: -155, y: 155)
                    HexBolt()
                        .offset(x: 155, y: 155)
                    
                    // The Big Red Button (on top of panel)
                    Button(action: {
                        pressButton()
                    }) {
                        ZStack {
                            // Button shadow/depth
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.8, green: 0.1, blue: 0.1),
                                            Color(red: 0.6, green: 0.05, blue: 0.05)
                                        ]),
                                        center: .topLeading,
                                        startRadius: 20,
                                        endRadius: 200
                                    )
                                )
                                .frame(width: 280, height: 280)
                                .shadow(color: .black.opacity(0.6), radius: 20, x: 0, y: 10)
                            
                            // Glossy highlight
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.white.opacity(0.4),
                                            Color.clear
                                        ]),
                                        startPoint: .top,
                                        endPoint: .center
                                    )
                                )
                                .frame(width: 280, height: 280)
                            
                            // Button text
                            Text("NAILED IT!")
                                .font(.system(size: 36, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        }
                    }
                    .scaleEffect(isPressed ? 0.92 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                }
                
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

// Diagonal hazard stripe background (caution tape style)
struct HazardStripeBackground: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                
                // Create diagonal stripes at 45 degrees
                ForEach(0..<30) { index in
                    Rectangle()
                        .fill(index % 2 == 0 ? Color.yellow : Color.black)
                        .frame(width: 80)
                        .rotationEffect(.degrees(45))
                        .offset(x: CGFloat(index * 80) - geometry.size.width * 1.5)
                }
            }
        }
    }
}

// Industrial rivet hardware
struct HexBolt: View {
    var body: some View {
        ZStack {
            // Rivet head outer circle (darker base)
            Circle()
                .fill(Color(white: 0.35))
                .frame(width: 40, height: 40)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 1, y: 2)
            
            // Rivet head (metallic gradient)
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(white: 0.55),
                            Color(white: 0.40)
                        ]),
                        center: .topLeading,
                        startRadius: 2,
                        endRadius: 18
                    )
                )
                .frame(width: 35, height: 35)
            
            // Center indent (rivet detail)
            Circle()
                .fill(Color.black.opacity(0.3))
                .frame(width: 8, height: 8)
        }
    }
}

#Preview {
    ContentView()
}
