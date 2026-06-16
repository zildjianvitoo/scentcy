//
//  ScannerCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//
//  Interactive camera scanner illustration for OnboardingHow.
//  Simulates a viewfinder scanning a perfume bottle with:
//  - Corner bracket indicators
//  - Animated laser sweep line
//  - Auto-filling progress bar
//  - Cycling status text
//

import SwiftUI

struct ScannerCard: View {

    // MARK: - Public binding — parent reads this to enable/disable Next button
    @Binding var isScanComplete: Bool

    // MARK: - Internal state
    @State private var laserY: CGFloat = 0
    @State private var scanProgress: CGFloat = 0.0
    @State private var statusText: String = "Detecting bottle label..."
    @State private var progressTimer: Timer?

    // Scanner card dimensions
    private let cardHeight: CGFloat = 320
    private let bracketLength: CGFloat = 24
    private let bracketWeight: CGFloat = 2.5
    private let bracketInset: CGFloat = 20
    private let scanDuration: TimeInterval = 3.0

    // Laser color — warm cream/tan with glow
    private let laserColor = Color(red: 0.91, green: 0.81, blue: 0.65)
    
    private let demoPerfume = perfumeDataArray[0]

    // Status messages and their progress thresholds
    private let statusSteps: [(threshold: CGFloat, text: String)] = [
        (0.00, "Detecting bottle label..."),
        (0.30, "Analyzing molecular sillage..."),
        (0.60, "Matching scent profile..."),
        (0.90, "Scent Profile Identified!"),
    ]

    var body: some View {
        VStack(spacing: 10) {
            // Scanner card
            ZStack {
                // Card background
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.primary.opacity(0.06), lineWidth: 1)
                    )

                // Corner brackets
                cornerBrackets

                // Perfume bottle image
                if !isScanComplete {
                    Image(demoPerfume.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                // Scan laser line — sweeps top to bottom
                if !isScanComplete {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(laserColor)
                        .frame(height: 2.5)
                        .padding(.horizontal, bracketInset + 6)
                        .shadow(color: laserColor.opacity(0.6), radius: 8, y: 0)
                        .shadow(color: laserColor.opacity(0.3), radius: 16, y: 0)
                        .offset(y: laserY)
                }
                
                if isScanComplete {
                    PerfumeListCard(data: demoPerfume)
                        .padding(.horizontal, 20)
                        .transition(.scale(scale: 0.8, anchor: .bottom).combined(with: .opacity))
                        .zIndex(2)
                }
            }
            .frame(height: cardHeight)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            // Status text
            Text(statusText)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(
                    isScanComplete
                        ? Color.appButton
                        : Color.primary.opacity(0.45)
                )
                .animation(.easeInOut(duration: 0.3), value: statusText)

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    // Track
                    Capsule()
                        .fill(Color.primary.opacity(0.06))
                        .frame(height: 4)

                    // Fill
                    Capsule()
                        .fill(laserColor)
                        .frame(width: geo.size.width * scanProgress, height: 4)
                        .animation(.linear(duration: 0.15), value: scanProgress)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 4)
        }
        .onAppear {
            startLaserAnimation()
            startScanProgress()
        }
        .onDisappear {
            progressTimer?.invalidate()
            progressTimer = nil
        }
    }

    // MARK: - Corner brackets overlay

    private var cornerBrackets: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let color = Color.primary.opacity(0.45)

            // Top-left
            bracket(at: CGPoint(x: bracketInset, y: bracketInset),
                    dx: bracketLength, dy: bracketLength,
                    flipX: false, flipY: false, color: color)
            // Top-right
            bracket(at: CGPoint(x: w - bracketInset, y: bracketInset),
                    dx: bracketLength, dy: bracketLength,
                    flipX: true, flipY: false, color: color)
            // Bottom-left
            bracket(at: CGPoint(x: bracketInset, y: h - bracketInset),
                    dx: bracketLength, dy: bracketLength,
                    flipX: false, flipY: true, color: color)
            // Bottom-right
            bracket(at: CGPoint(x: w - bracketInset, y: h - bracketInset),
                    dx: bracketLength, dy: bracketLength,
                    flipX: true, flipY: true, color: color)
        }
    }

    @ViewBuilder
    private func bracket(
        at origin: CGPoint,
        dx: CGFloat, dy: CGFloat,
        flipX: Bool, flipY: Bool,
        color: Color
    ) -> some View {
        Path { path in
            let xDir: CGFloat = flipX ? -1 : 1
            let yDir: CGFloat = flipY ? -1 : 1
            // Horizontal stroke
            path.move(to: origin)
            path.addLine(to: CGPoint(x: origin.x + dx * xDir, y: origin.y))
            // Vertical stroke
            path.move(to: origin)
            path.addLine(to: CGPoint(x: origin.x, y: origin.y + dy * yDir))
        }
        .stroke(color, style: StrokeStyle(lineWidth: bracketWeight, lineCap: .round))
    }

    // MARK: - Animations

    private func startLaserAnimation() {
        let sweepRange: CGFloat = 90
        
        laserY = -sweepRange
            withAnimation(
                .linear(duration: 2)
                .repeatForever(autoreverses: true)
            ) {
                laserY = sweepRange
            }
    }

    private func startScanProgress() {
        let interval: TimeInterval = 0.05
        let totalSteps = scanDuration / interval
        let increment: CGFloat = 1.0 / CGFloat(totalSteps)

        progressTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            scanProgress = min(scanProgress + increment, 1.0)

            // Update status text based on thresholds
            for step in statusSteps.reversed() {
                if scanProgress >= step.threshold {
                    if statusText != step.text {
                        statusText = step.text
                    }
                    break
                }
            }

            // Scan complete
            if scanProgress >= 1.0 {
                timer.invalidate()
                progressTimer = nil
                withAnimation(.easeOut(duration: 0.4)) {
                    isScanComplete = true
                }
            }
        }
    }
}

#Preview {
    VStack {
        ScannerCard(isScanComplete: .constant(false))
            .padding(32)
    }
    .background(Color.appBackground)
}
