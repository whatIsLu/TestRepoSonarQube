//
//  StoreView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct StoreView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @State var clockShown = false
    @State var isAnimating: Bool = false
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var clockManager: GlobalClockManager = GlobalClockManager.shared
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SndText(family: .nunito, style: .extraBold, size: 32, "Your saved clocks")
                .padding(.bottom, 5)
                .padding(.top, 10)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.gray.opacity(0.2))
                .shadow(radius: 5)
            if clockManager.savedClocks.isEmpty { 
                VStack(spacing: 25) {
                    Spacer()
                    SndText(family: .nunito, style: .extraBold, size: 32, "No Clocks")
                        .foregroundStyle(.gray.opacity(0.5))
                    Button(action: {
                        viewModel.coordinator.selectedTab = .create
                    }) {
                        SndText(style: .bold, "Create Clock")
                            .font(.headline)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .padding()
                            .background(colorScheme == .light ? .black : .white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 100)
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout) {
                        ForEach(clockManager.savedClocks.reversed(), id: \.self) { item in
                            Button {
                                UIApplication.shared.isIdleTimerDisabled = true
                                viewModel.coordinator.push(page: .clock(clock: item))
                            } label: {
                                viewModel.coordinator.build(page: .clock(clock: SndClock(font: item.font, size: item.size, spacing: item.spacing, fontStyle: item.fontStyle, textColor: item.textColor, shadow: item.shadow, backgroundColor: item.backgroundColor), scaleEffect: 0.3))
                                    .frame(height: 250)
                                    .frame(minWidth: 100)
                                    .cornerRadius(20)
                                    .disabled(true)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(colorScheme == .light ? .gray.opacity(0.3) : Color.customColor2, lineWidth: 2)
                                    )
                                    .shadow(color: .customColor2.opacity(0.3), radius: 2)
                                
                            }
                            .padding(.top, 5)
                            .contextMenu {
                                Button("Delete") {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                        withAnimation {
                                            clockManager.realmManager.deleteClock(clock: item, config: .savedClocks)
                                            clockManager.syncClocksWithDB()
                                        }
                                    }
                                }
                            }
                        }
                        EmptyView()
                            .padding(.bottom, 100)
                    }
                    .padding(.horizontal, 5)
                }
            }
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
        .fullScreenCover(isPresented: $clockShown) {
            clockManager.clockView
        }
    }
}
