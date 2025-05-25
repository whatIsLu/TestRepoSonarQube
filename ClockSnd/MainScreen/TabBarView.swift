//
//  TabBarView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

enum Tabs: String {
    case home
    case catalog
    case create
    case settings
}

struct TabBarView: View {
    @ObservedObject var viewModel: TabBarViewModel
    let tabs = [Tabs.home, Tabs.catalog, Tabs.create, Tabs.settings]

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {

            TabView(selection: $viewModel.coordinator.selectedTab) {
                ForEach(tabs, id: \.self) { tab in
                    contentView(for: tab.rawValue)
                        .tag(tab)

                }
            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    TabButton(image: image.rawValue, selectedTab: $viewModel.coordinator.selectedTab)

                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 35)
            .padding(.top, 10)
            .background(Color.customColor2)
            .background(Color.customColor7.shadow(color: .white.opacity(0.28), radius: 5, x: 0, y: -5))
            .clipShape(TopRoundedRectangle(radius: 20))
            .shadow(color: .black.opacity(0.28), radius: 30)
        }
        .ignoresSafeArea(edges: .bottom)

    }
    
    @ViewBuilder
    func contentView(for tab: String) -> some View {
        switch tab {
        case "catalog":
            StoreView(viewModel: viewModel)
        case "home":
            HomeView(viewModel: viewModel)
        case "settings":
            SettingsView(viewModel: viewModel)
        case "create":
            ClockCreatorView(viewModel: viewModel)
        default:
            EmptyView()
        }
    }
    
}

struct TabButton: View {
    var image: String
    @Binding var selectedTab: Tabs
    var body: some View {
        Button(action: {
            selectedTab = Tabs(rawValue: image) ?? .home
        }) {
            VStack {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(selectedTab.rawValue == image ? Color.white : Color.customColor5)
                    .font(.title2)
            }.padding(.horizontal, 20)
        }
    }
}

struct TopRoundedRectangle: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
