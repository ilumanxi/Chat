//
//  PlayerViewModel.swift
//  PlayerViewModel
//
//  Created by 风起兮 on 2021/8/25.
//  VideoPlayer

import SwiftUI
import AVKit
import Combine

class PlayerViewModel: ObservableObject {
    
    var playerItem: AVPlayerItem
    
    var player: AVPlayer
    
    private var playerLooper: AVPlayerLooper?
    
    @Published private(set) var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                activeAudioSession()
            }
            else {
                inactiveAudioSession()
            }
        }
    }
    
    fileprivate var isAllowResumePlay = false
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(fileName: String, isLoop: Bool = false) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else { fatalError() }
        
        self.playerItem = AVPlayerItem(url: url)
        
        if isLoop {
            let queuePlayer = AVQueuePlayer(playerItem:  self.playerItem)
            self.player = queuePlayer
            self.playerLooper = AVPlayerLooper(player:  queuePlayer, templateItem: playerItem)
        }
        else {
            self.player = AVPlayer(playerItem:  self.playerItem)
        }
    }
    
}


extension PlayerViewModel {
    
    func play(){
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    private func playOrPause(_ isPlaying: Bool) {
        if isAllowResumePlay && isPlaying && !self.isPlaying {
            play()
        }
        else if self.isPlaying {
            pause()
        }
    }
}


extension PlayerViewModel {
    
    func allowResumePlay() {
        
        if !disposeBag.isEmpty {
            return
        }
        
        let foreground = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification, object: nil)
            .compactMap { _ in true }
            .eraseToAnyPublisher()
        
        let background = NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification, object: nil)
            .handleEvents(receiveOutput: { [unowned self] _ in
                self.isAllowResumePlay = self.isPlaying
            })
            .compactMap { _ in false }
            .eraseToAnyPublisher()
        
        Publishers.Merge(foreground, background)
            .sink(receiveValue: self.playOrPause)
            .store(in: &disposeBag)
    }
    
    func notAllowResumePlay() {
        
        if disposeBag.isEmpty {
            return
        }
        
        disposeBag.removeAll()
    }
}

extension PlayerViewModel {
    
    private func activeAudioSession() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playback)
            try session.setActive(true, options: [])
            
        } catch let e {
            fatalError(e.localizedDescription)
        }
    }
    
    private func inactiveAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false, options: [])
            
        } catch let e {
            fatalError(e.localizedDescription)
        }
    }
    
}
