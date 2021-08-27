//
//  Footnote.swift
//  Footnote
//
//  Created by 风起兮 on 2021/8/27.
//

import SwiftUI

struct Footnote: View {
    
    @Binding var agree: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                agree.toggle()
            } label: {
                Image(systemName: agree ? "checkmark.square" : "square")
                    .foregroundColor(agree ? .red : .gray)
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

struct Footnote_Previews: PreviewProvider {
    static var previews: some View {
        Footnote(agree: .constant(true))
    }
}
