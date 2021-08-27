//
//  ChatApp.swift
//  Shared
//
//  Created by 风起兮 on 2021/8/23.
//

import SwiftUI

@main
struct ChatApp: App {
    
    @StateObject var model = Model()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
