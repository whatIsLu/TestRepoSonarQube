//
//  AboutView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: AboutViewModel

    var body: some View {
        VStack {
            viewModel.coordinator.defaultNavigationBar
                .foregroundColor(colorScheme == .light ? .black : .white)

            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(.top, 20)
                .shadow(radius: 5)

            Text("Clock Stand")
                .font(.title)
                .padding(.top, 10)

            Text("Version 1.0")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 5)

            Spacer()

            Text("About App")
                .font(.headline)
                .padding(.top, 20)

            Text("This app is designed to enhance your workspace with a customizable clock that pleases your eyes.")
                .font(.body)
                .padding()

            Spacer()

            Text("Copyright © \( Date().formatted(Date.FormatStyle().year())) ClockSnd")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .padding()
    }
}
