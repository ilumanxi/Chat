//
//  CheckboxToggleStyle.swift
//  CheckboxToggleStyle
//
//  Created by 风起兮 on 2021/9/7.
//

import SwiftUI


extension ToggleStyle where Self == CheckboxToggleStyle {
    
    static var checkbox: CheckboxToggleStyle {  CheckboxToggleStyle() }
}

struct CheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.$isOn.wrappedValue.toggle()
            }
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
        }
    }
    
}

struct CheckboxToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle(isOn: .constant(true)) {
            Text("Toggle")
        }
        .labelsHidden()
        .toggleStyle(.button)
        
        
        
    }
}
