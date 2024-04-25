//
//  HanbaiApp.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 24.4.24..
//

import SwiftUI

@main
struct HanbaiApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ComicsView()
        }
    }
}
