//
//  PlayerView.swift
//  PlayerView
//
//  Created by 风起兮 on 2021/8/23.
//  VideoPlayer

import SwiftUI
import AVKit

struct PlayerView: View {
    
    var player: AVPlayer
    
    var body: some View {
        Representable(player: player)
    }
}

extension PlayerView {
    struct Representable: UIViewControllerRepresentable {
        
        var player: AVPlayer
        
        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
        
        func makeUIViewController(context: Context) -> AVPlayerViewController {
            let playerViewController = AVPlayerViewController()
            playerViewController.showsPlaybackControls = false
            playerViewController.videoGravity = .resizeAspectFill
            return playerViewController
        }
        
        func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
            uiViewController.player = player
            uiViewController.delegate = context.coordinator
        }
    }
    
    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        
    }
}

struct Player_Previews: PreviewProvider {
    static var previews: some View {
        let url = Bundle.main.url(forResource: "login.player", withExtension: "mov")!
        PlayerView(player: AVPlayer(url: url))
            .ignoresSafeArea(.all)
    }
}
