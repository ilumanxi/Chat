//
//  PlayerViewModel.swift
//  PlayerViewModel
//
//  Created by 风起兮 on 2021/8/25.
//  VideoPlayer

import Foundation
import AVKit

struct PlayerViewModel {
    
    var playerItem: AVPlayerItem
    
    var player: AVQueuePlayer
    
    var playerLooper: AVPlayerLooper
    
    
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                player.play()
            }
            else {
                player.pause()
            }
        }
    }
    
    init(fileName: String) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else { fatalError() }
        
        self.playerItem = AVPlayerItem(url: url)
        self.player = AVQueuePlayer(playerItem:  self.playerItem)
        self.playerLooper = AVPlayerLooper(player:  player, templateItem: playerItem)
    }
    
    func play(){
        player.play()
    }
    
}
