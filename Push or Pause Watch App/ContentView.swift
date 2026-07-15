//
//  ContentView.swift
//  Push or Pause Watch App
//
//  Created by Audrey Buckland on 7/14/26.
//

import SwiftUI

struct ContentView: View {
    // 1. Mock state values to drive our UI dynamically
    @State private var zScore: Double = 0.8
    @State private var totalSleep: Double = 7.5
    
    // 2. Computed properties to determine state based on your z-score logic
    private var isPush: Bool {
        zScore >= -0.5
    }
    
    private var statusColor: Color {
        if zScore < -1.5 {
            return .red
        } else if zScore < -0.5 {
            return .yellow
        } else {
            return .green
        }
    }
    
    private var statusText: String {
        if zScore < -1.5 {
            return "PAUSE"
        } else if zScore < -0.5 {
            return "CAUTION"
        } else {
            return "PUSH"
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // Top Header
            Text("TODAY'S READINESS")
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundColor(.secondary)
            
            // The Hero Circular Interface
            // Clicking this mock button cycles through different score profiles so you can test transitions!
            Button(action: cycleMockScores) {
                ZStack {
                    // Outer ring that glows with the active color status
                    Circle()
                        .stroke(statusColor.opacity(0.3), lineWidth: 6)
                        .frame(width: 115, height: 115)
                    
                    // Solid inner circle containing the main action text
                    Circle()
                        .fill(statusColor)
                        .frame(width: 100, height: 100)
                        .shadow(color: statusColor.opacity(0.5), radius: 10)
                    
                    // Inside-button text stack
                    VStack(spacing: 2) {
                        Text(statusText)
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .foregroundColor(statusColor == .yellow ? .black : .white)
                        
                        Text("Z-Score: \(String(format: "%.1f", zScore))")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundColor(statusColor == .yellow ? .black.opacity(0.7) : .white.opacity(0.8))
                    }
                }
            }
            .buttonStyle(.plain) // Clears watchOS's default grey button rectangle
            
            // Micro-Biometric Dashboard
            HStack(spacing: 12) {
                Label {
                    Text("\(String(format: "%.1f", totalSleep))h")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                } icon: {
                    Image(systemName: "moon.stars.fill")
                        .foregroundColor(.blue)
                }
                
                Label {
                    Text(isPush ? "Ready" : "Fatigued")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                } icon: {
                    Image(systemName: isPush ? "bolt.fill" : "battery.25")
                        .foregroundColor(statusColor)
                }
            }
            .padding(.top, 4)
        }
        .padding(.horizontal)
    }
    
    // 3. Helper function to simulate data transitions when the user taps the screen
    private func cycleMockScores() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            if zScore == 0.8 {
                // Transition to Moderate Fatigue
                zScore = -0.9
                totalSleep = 6.1
            } else if zScore == -0.9 {
                // Transition to Severe Fatigue (PAUSE)
                zScore = -1.8
                totalSleep = 4.8
            } else {
                // Reset back to Optimal Recovery (PUSH)
                zScore = 0.8
                totalSleep = 7.5
            }
        }
    }
}

// Simple preview provider to see your watch interface live inside Xcode
#Preview {
    ContentView()
}
