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
                    // The Big Red Button
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
                    
                    // Hardware bolts in corners
                    HexBolt()
                        .offset(x: -160, y: -160)
                    HexBolt()
                        .offset(x: 160, y: -160)
                    HexBolt()
                        .offset(x: -160, y: 160)
                    HexBolt()
                        .offset(x: 160, y: 160)
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

// Steampunk hex bolt/allen bolt hardware
struct HexBolt: View {
    var body: some View {
        ZStack {
            // Bolt head (hexagon)
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(white: 0.5),
                            Color(white: 0.3)
                        ]),
                        center: .topLeading,
                        startRadius: 5,
                        endRadius: 20
                    )
                )
                .frame(width: 35, height: 35)
                .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 2)
            
            // Hex pattern in center
            Path { path in
                let center = CGPoint(x: 17.5, y: 17.5)
                let radius: CGFloat = 12
                
                for i in 0..<6 {
                    let angle = CGFloat(i) * .pi / 3 - .pi / 2
                    let point = CGPoint(
                        x: center.x + radius * cos(angle),
                        y: center.y + radius * sin(angle)
                    )
                    
                    if i == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }
                path.closeSubpath()
            }
            .stroke(Color.black.opacity(0.6), lineWidth: 2)
        }
    }
}

#Preview {
    ContentView()
}
