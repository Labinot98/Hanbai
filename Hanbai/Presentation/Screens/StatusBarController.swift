//
//  StatusBarController.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import SwiftUI
import AppKit

class StatusBarController {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    init() {
        if let button = statusItem.button {
            button.title = "Marvel Comics"
            button.action = #selector(showComics)
        }
    }
    
    @objc func showComics() {
        let comicsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        comicsWindow.center()
        comicsWindow.title = "Marvel Comics"
        comicsWindow.contentView = NSHostingView(rootView: ComicsView())
        comicsWindow.makeKeyAndOrderFront(nil)
        comicsWindow.isReleasedWhenClosed = false
    }
}
