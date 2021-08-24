//
//  LoginList.swift
//  LoginList
//
//  Created by 风起兮 on 2021/8/23.
//

import SwiftUI
import AVFoundation



struct LoginList: View {
    

    var playerItem: AVPlayerItem
    
    var player: AVQueuePlayer
    
    var playerLooper: AVPlayerLooper
    
    
    init() {
        let playerItem: AVPlayerItem = .init(url: Bundle.main.url(forResource: "login.player", withExtension: "mov")!)
        let player: AVQueuePlayer = AVQueuePlayer(url: Bundle.main.url(forResource: "login.player", withExtension: "mov")!)
        
        let playerLooper = AVPlayerLooper(player:  player, templateItem: playerItem)
        
        self.init(playerItem: playerItem, player: player, playerLooper: playerLooper)
        
    }
    
    private init(playerItem: AVPlayerItem, player: AVQueuePlayer, playerLooper: AVPlayerLooper) {
        self.playerItem = playerItem
        self.player = player
        self.playerLooper = playerLooper
    }
    
    @State private var selected: Bool = false
    
    @State var invalidAttempts = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.black)
                                .frame(height: 48)
                            
                            HStack {
                                Image(systemName: "applelogo")
                                    .foregroundColor(.white)
                                .font(.title)
                                
                                Text("Sign in with Apple")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.black)
                                .frame(height: 48)
                            
                            HStack {
                                Image(systemName: "iphone.homebutton")
                                    .foregroundColor(.white)
                                .font(.title)
                                
                                Text("Sign in with Phone")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    
                }
                .padding(.bottom, 20)
                
                footnote
                    .shakeEffect(shakes: invalidAttempts * 2)
                    .animation(.linear, value: selected)
                   
                    
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
            .background {
                PlayerView(player: player)
                    .ignoresSafeArea(.all)
                    .onAppear {
                        player.play()
                    }
            }
           
        }
        
    }
    
    var footnote: some View {
        HStack(spacing: 0) {
            Button {
                selected.toggle()
                invalidAttempts += 1
            } label: {
                Image(systemName: selected ? "checkmark.square" : "square")
                    .foregroundColor(selected ? .red : .gray)
            }
            
            Text("已阅读并同意”")
            NavigationLink(destination: Text("用户协议")) {
                Text("用户协议")
                    .foregroundColor(.primary)
            }
            
            Text("“和“")
            NavigationLink(destination: Text("隐私政策")) {
                Text("隐私政策")
                    .foregroundColor(.primary)
            }
            Text("“")
        }
        .font(.footnote)
        .foregroundColor(.secondary)
    }
}

struct LoginList_Previews: PreviewProvider {
    static var previews: some View {
        LoginList()
    }
}
