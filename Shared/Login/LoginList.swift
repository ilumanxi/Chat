//
//  LoginList.swift
//  LoginList
//
//  Created by 风起兮 on 2021/8/23.
//

import SwiftUI
import AVKit
import AuthenticationServices



struct LoginList: View {
    
    private var playerViewModel = PlayerViewModel(fileName: "login.player.mov")
    
    @State private var selected: Bool = false
    
    @State var invalidAttempts = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    
                    SignInWithAppleButton(
                        .signIn,
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            print(result)
                        }
                    )
                    .frame(height: 35)
                    
                    
                    Button {
                        invalidAttempts += 1
                    } label: {
                        Label("Sign in with Phone", systemImage: "iphone.homebutton")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                }
                .padding(.bottom, 20)
                
                footnote
                    .shakeEffect(shakes: invalidAttempts * 2)
                    .animation(.linear, value: invalidAttempts)
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
            .background {
                PlayerView(player: playerViewModel.player)
                    .ignoresSafeArea(.all)
            }
            .onAppear {
                playerViewModel.play()
            }
        }
        
    }
    
    var footnote: some View {
        HStack(spacing: 0) {
            Button {
                selected.toggle()
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
