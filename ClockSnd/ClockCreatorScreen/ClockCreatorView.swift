//
//  ClockCreatorView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import SwiftUI

struct ClockCreatorView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var isClockShown = false
    
    @StateObject var clockCreatorViewModel = ClockCreatorViewModel()
    @ObservedObject var viewModel: TabBarViewModel
    @State var divider = 1.7
    @State private var showMessage = true
    @State private var isAnimating = false
    
    let rotate = AnyTransition.modifier(
        active: RotationModifier(angle: .degrees(0)),
        identity: RotationModifier(angle: .degrees(360))
    )
    struct RotationModifier: ViewModifier {
        let angle: Angle
        
        func body(content: Content) -> some View {
            content
                .rotationEffect(angle)
                .scaleEffect(0.5)
                .opacity(0.5)
        }
    }
    var body: some View {
        VStack {
            HStack {
                SndText(style: .extraBold, size: 32, "Clock Creator")
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            
            Spacer()
            
            HStack {
                VStack(spacing: 15) {
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .color
                                clockCreatorViewModel.selectedPicker = .background
                            }
                        }
                    } label: {
                        SndText(style: clockCreatorViewModel.selectedPicker == .background && clockCreatorViewModel.selectedCustomizer == .color ? .extraBold : .regular,
                                "Background")
                        .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .color
                                clockCreatorViewModel.selectedPicker = .clock
                            }
                        }
                    } label: {
                        SndText(style: clockCreatorViewModel.selectedPicker == .clock && clockCreatorViewModel.selectedCustomizer == .color ? .extraBold : .regular, "Clock")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .color
                                clockCreatorViewModel.selectedPicker = .shadow
                            }
                        }
                    } label: {
                        SndText(style: clockCreatorViewModel.selectedPicker == .shadow && clockCreatorViewModel.selectedCustomizer == .color ? .extraBold : .regular, "Shadow")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .size
                            }
                        }
                    } label: {
                        SndText(style: clockCreatorViewModel.selectedCustomizer == .size ? .extraBold : .regular, "Size")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .spacing
                            }
                        }
                    } label: {
                        SndText(style: clockCreatorViewModel.selectedCustomizer == .spacing ? .extraBold : .regular, "Spacing")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .font
                            }
                        }
                    } label: {
                        SndText(style: clockCreatorViewModel.selectedCustomizer == .font ? .extraBold : .regular, "Font")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .fontStyle
                            }
                        }
                    } label: {
                        SndText(style: clockCreatorViewModel.selectedCustomizer == .fontStyle ? .extraBold : .regular, "Font Style")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                clockCreatorViewModel.selectedCustomizer = .save
                                clockCreatorViewModel.saveClock()
                                showMessage = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation(.easeInOut) {
                                        showMessage = false
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            SndText("Save")
                                .foregroundColor(colorScheme == .light ? .customColor1 : .customColor2)
                                .padding(7)
                        }
                        .background(colorScheme == .light ? Color.customColor4 : Color.customColor1)
                        .cornerRadius(10)
                    }
                    
                    if clockCreatorViewModel.selectedCustomizer == .font {
                        HStack(spacing: 0) {
                            Picker(selection: $clockCreatorViewModel.font, label: Text("")) {
                                ForEach(Font.FontFamily.allFontFamilies, id: \.self) { fontFamily in
                                    Text(fontFamily.rawValue)
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if clockCreatorViewModel.selectedCustomizer == .fontStyle {
                        HStack(spacing: 0) {
                            Picker(selection: $clockCreatorViewModel.fontStyle, label: Text("")) {
                                ForEach(Font.FontStyle.allFontFamilies, id: \.self) { fontStyle in
                                    Text(fontStyle.description)
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if clockCreatorViewModel.selectedCustomizer == .size {
                        HStack(spacing: 0) {
                            Picker(selection: $clockCreatorViewModel.size, label: Text("")) {
                                ForEach(1 ..< 201, id: \.self) { fontSize in
                                    Text("\(fontSize)%")
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if clockCreatorViewModel.selectedCustomizer == .spacing {
                        HStack(spacing: 0) {
                            Picker(selection: $clockCreatorViewModel.spacing, label: Text("")) {
                                ForEach(-60 ..< 20, id: \.self) { spacingSize in
                                    Text("\(spacingSize)%")
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if clockCreatorViewModel.selectedCustomizer == .save && showMessage {
                        HStack(spacing: 0) {
                            SndText(style: .bold, "Saved")
                                .foregroundColor(colorScheme == .light ? .customColor4 : .customColor1)
                                .padding(7)
                        }
                    }
                }
                .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0))
                .shadow(radius: 4)
                .frame(minWidth: 100)
                Button {
                    UIApplication.shared.isIdleTimerDisabled = true
                    viewModel.coordinator.push(page: .clock(clock: SndClock(font: clockCreatorViewModel.font.rawValue, size: String(clockCreatorViewModel.size), spacing: String(clockCreatorViewModel.spacing), fontStyle: clockCreatorViewModel.fontStyle.rawValue, textColor: clockCreatorViewModel.fontColor.toHexWithAlpha(), shadow: clockCreatorViewModel.shadow.toHexWithAlpha(), backgroundColor: clockCreatorViewModel.backgroundColor.toHexWithAlpha())))
                } label: {
                    viewModel.coordinator.build(page: .clock(clock: SndClock(font: clockCreatorViewModel.font.rawValue, size: String(Double(0.7 * Double(clockCreatorViewModel.size))), spacing: String(clockCreatorViewModel.spacing), fontStyle: clockCreatorViewModel.fontStyle.rawValue, textColor: clockCreatorViewModel.fontColor.toHexWithAlpha(), shadow: clockCreatorViewModel.shadow.toHexWithAlpha(), backgroundColor: clockCreatorViewModel.backgroundColor.toHexWithAlpha())))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(colorScheme == .light ? .gray.opacity(0.3) : Color.customColor2, lineWidth: 2)
                        )
                        .shadow(color: .customColor2.opacity(0.3), radius: 2)
                        .disabled(true)
                }
                .frame(maxWidth: 250, maxHeight: 500)
                .overlay {
                    VStack {
                        Spacer()
                        if clockCreatorViewModel.selectedCustomizer == .color {
                            ColorPicker("Picker", selection: selectedColorBinding)
                                .scaleEffect(3)
                                .labelsHidden()
                                .padding(.bottom, -15)
                        }
                    }
                }
            }
           
            .padding(.bottom, 100)
        }
        .opacity(isAnimating ? 1 : 0)
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    isAnimating = true
                }
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                withAnimation {
                    isAnimating = false
                }
            }
        }
    }
    
    var selectedColorBinding: Binding<CGColor> {
        switch clockCreatorViewModel.selectedPicker {
        case .background:
            return $clockCreatorViewModel.backgroundColor
        case .clock:
            return $clockCreatorViewModel.fontColor
        case .shadow:
            return $clockCreatorViewModel.shadow
        }
    }
}
