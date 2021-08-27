//
//  PlayerViewModel.swift
//  PlayerViewModel
//
//  Created by 风起兮 on 2021/8/25.
//  VideoPlayer

import Foundation
import AVKit

class PlayerViewModel {
    
    var playerItem: AVPlayerItem
    
    var player: AVQueuePlayer
    
    var playerLooper: AVPlayerLooper
    
    init(fileName: String) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else { fatalError() }
        
        self.playerItem = AVPlayerItem(url: url)
        self.player = AVQueuePlayer(playerItem:  self.playerItem)
        self.playerLooper = AVPlayerLooper(player:  player, templateItem: playerItem)
    }
    
    func play(){
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
}
