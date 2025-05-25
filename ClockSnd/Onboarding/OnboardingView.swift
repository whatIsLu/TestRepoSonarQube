//
//  OnboardingView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var isAnimating: Bool = false
    var body: some View {
        ZStack{
            Color.clear
            VStack {
                Spacer()
                
                VStack {
                    SndText(style: .extraBold, size: 38, "Wellcome ")
                    SndText(style: .extraBold, size: 32, "to")
                }
                .foregroundColor(colorScheme == .light ? .black : .white)

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .scaleEffect(isAnimating ? 1.0 : 0.3)
                Spacer()
                
                Button(action: {
                    viewModel.endOnboarding()
                }) {
                    SndText(style: .bold, "Get Started")
                        .font(.headline)
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .padding()
                        .background(colorScheme == .light ? .black : .white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 100)
                
            }
            .onAppear {
                isAnimating = false
                DispatchQueue.main.async {
                    withAnimation(.easeOut(duration: 1.5)) {
                        isAnimating = true
                    }
                }
            }
        }.ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
