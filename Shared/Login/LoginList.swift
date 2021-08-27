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
    
    @EnvironmentObject var model: Model
    
    private var playerViewModel = PlayerViewModel(fileName: "login.player.mov")
    
    @State private var agree: Bool = false
    
    /// 现在，随着我们增加无效登录尝试的数量，矩形会抖动。
    @State var invalidAttempts = 0 
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    SignInWithAppleButton(.signIn, onRequest: { _ in }, onCompletion: model.authorizeUser)
                        .frame(minWidth: 100, maxWidth: 400)
                        .imageScale(.large)
                        .padding(.horizontal, 20)
                        .frame(height: 45)
                        .disabled(!agree)
                        .overlay {
                            if !agree {
                                Button(action: shake) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.clear)
                                }
                            }
                        }
                    
                    NavigationLink(destination: {
                        MobilePhoneLogin()
                            .navigationBarTitle("手机登录", displayMode: .inline)
                    }, label: {
                        
                        //  https://onevcat.com/2021/03/swiftui-text-2/
                        Text("\(Image(systemName: "iphone.homebutton")) Sign in with Phone")
                            //  https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, maxHeight: 45.0)
                    })
                    
                        .frame(maxWidth: .infinity, maxHeight: 45.0)
                        .padding(.horizontal, 20)
                        .lineSpacing(2)
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                }
                
                Spacer()
                    .frame(height: 60)
                
                Footnote(agree: $agree)
                    .shakeEffect(shakes: invalidAttempts * 2)
                    .animation(.linear, value: invalidAttempts)
            }
            .padding(.horizontal)
            .background {
                PlayerView(player: playerViewModel.player)
                    .ignoresSafeArea(.all)
            }
            .onAppear {
                playerViewModel.play()
            }
            .onDisappear {
                playerViewModel.pause()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        
    }
    
    func shake() {
        invalidAttempts += 1
    }
}



struct LoginList_Previews: PreviewProvider {
    static var previews: some View {
        LoginList()
    }
}
