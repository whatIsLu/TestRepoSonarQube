//
//  MainView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        MainFlowView(targetPage: SndUserDefaults.onboarding ? .basic : .onboarding) {}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
