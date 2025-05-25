//
//  ClockView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI
import Combine

struct ClockView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @StateObject private var accelManager = AccelerometerManager()
    @ObservedObject var viewModel: ClockViewModel
    @StateObject var clockManager: GlobalClockManager = GlobalClockManager.shared
    @Environment(\.presentationMode) var presentationMode
    @State var showInstruments: Bool = false
    @State var hideNotch: Bool = false
    @State var rotationIndex: Int = 0
    @State var hour: String = "00"
    @State var minute: String = "00"
    @State var updateTimer: Timer?
    
    @State private var timeRemaining = SndUserDefaults.sleepTime
    @State private var timer: Timer?
    @State private var isActive = true
    var scaleEffect: CGFloat = 1

    var body: some View {
        ZStack(alignment: .bottom) {
            viewModel.clockModel.backgroundColor.colorFromHexWithOpacity()
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                clockView
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }.frame(minWidth: 230)
            
            if hideNotch {
                nouchHideBuilder
                    .zIndex(1)
            }
            
            if showInstruments {
                VStack {
                    Spacer()
                    instrumentsView
                    Spacer()
                }.zIndex(2)
                
            }
            
            if !isActive && UIApplication.shared.isIdleTimerDisabled {
                Color.black
                    .ignoresSafeArea()
                    .zIndex(3)
            }
        }
        .transition(.identity)
        .onTapGesture {
            DispatchQueue.main.async {
                withAnimation() {
                    showInstruments.toggle()
                    clockManager.clockView = self
                    resetTimer()
                }
            }
        }
        .onAppear {
            resetTimer()
            updateTime()
            updateTimer = {
               Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                                    block: {_ in
                   updateTime()
               })
            }()
        }
        .onDisappear {
            updateTimer?.invalidate()
            updateTimer = nil
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if !SndUserDefaults.neverSleep {
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    withAnimation(.easeInOut(duration: 5)) {
                        isActive = false
                    }
                }
            }
        }
        .onChange(of: accelManager.acceleration) {
            resetTimer()
        }
        .statusBar(hidden: true)
        .persistentSystemOverlays(.hidden)
    }
    
    func resetTimer() {
        timeRemaining = SndUserDefaults.sleepTime
        withAnimation(.easeInOut(duration: 5)) {
            isActive = true
        }
    }
    
    @ViewBuilder
    var nouchHideBuilder: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width * 1.1
                let height = geometry.size.height * 0.95
                let rect = CGRect(x: (geometry.size.width - width) / 2,
                                  y: (geometry.size.height - height) / 2,
                                  width: width,
                                  height: height)
                let cornerRadius: CGFloat = 60
                
                path.addRoundedRect(in: rect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
            }
            .stroke(Color.black, style: StrokeStyle(lineWidth: 60, lineCap: .round, lineJoin: .round))
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

extension ClockView {
    
    var clockView: some View {
        VStack(spacing: 0) {
            Spacer()
            hourView
                .padding(.bottom, viewModel.clockModel.spacing.toCGFloat())
            dividerView
                .frame(width: 80, height: 100)
                .padding(.vertical, -25)
            minutesView
                .padding(.top, viewModel.clockModel.spacing.toCGFloat())

            Spacer()
        }
        .padding(.bottom, rotationIndex == 0 ? 0 : 20)
        .shadow(color: viewModel.clockModel.shadow.colorFromHexWithOpacity(), radius: 3, x: 0, y: 4)
        .scaleEffect(viewModel.clockModel.size.toCGFloat() * 0.01 * scaleEffect)
    }
    
    var hourView: some View {
        Group {
            if rotationIndex == 1 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, hour)
                        .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(90))
            } else if rotationIndex == 2 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, minute)
                        .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(270))
            } else {
                SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, hour)
                    .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
            }
        }
    }
    
    var minutesView: some View {
        Group {
            if rotationIndex == 1 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, minute)
                        .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(90))
            } else if rotationIndex == 2 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, hour)
                        .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(270))
            } else {
                SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, minute)
                    .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
            }
        }
    }
    
    var dividerView: some View {
        Group {
            if rotationIndex == 1 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, ":")
                        .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
                        .padding(.bottom, 40)
                }.rotationEffect(.degrees(90))
            } else if rotationIndex == 2  {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: viewModel.clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: viewModel.clockModel.fontStyle) ?? .regular, size: 250, ":")
                        .foregroundColor(viewModel.clockModel.textColor.colorFromHexWithOpacity())
                        .padding(.bottom, 40)
                }.rotationEffect(.degrees(270))
            }
        }
    }
    
    var instrumentsView: some View {
        VStack {
            ZStack {
                Color.gray.opacity(0.2).blur(radius: 3.0).cornerRadius(20)
                HStack {
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                UIApplication.shared.isIdleTimerDisabled = false
                                updateTimer?.invalidate()
                                updateTimer = nil
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        SndText(family: .nunito, style: .extraBold, "Back")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                hideNotch.toggle()
                            }
                        }
                    } label: {
                        SndText(family: .nunito, style: .extraBold, "Hide Notch")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                if rotationIndex < 2 {
                                    rotationIndex += 1
                                } else {
                                    rotationIndex = 0
                                }
                            }
                        }
                    } label: {
                        SndText(family: .nunito, style: .extraBold, "Orientation")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                }
            }
            .frame(height: 100)
            .shadow(color: .black, radius: 3, x: 0, y: 4)
            .padding()
        }
    }
    
    func updateTime() {
        hour = Date().formatted(Date.FormatStyle().hour(.twoDigits(amPM: .omitted)))
        minute = Date().formatted(Date.FormatStyle().minute(.twoDigits))
    }
}
