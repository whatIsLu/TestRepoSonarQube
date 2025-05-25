//
//  HomeIndicatorComponentView.swift
//  ClockSnd
//
//  Created by Vlady on 05.02.2024.
//

import Foundation
import SwiftUI
import UIKit

struct HomeIndicatorHiddenView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        CustomViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the UI if needed
    }
}

class CustomViewController: UIViewController {
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}

