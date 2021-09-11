//
//  Gender.swift
//  Gender
//
//  Created by 风起兮 on 2021/9/11.
//

import SwiftUI


enum Gender: Int, CaseIterable {
    case male
    case female
}

extension Gender {
    
    var title: LocalizedStringKey {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
    
    var image: Image {
        switch self {
        case .male:
            return Image(systemName: "person.circle.fill")
        case .female:
            return Image(systemName: "person.circle.fill")
        }
    }
}

struct TabButton: View {
    
    var title: LocalizedStringKey
    var image: Image
    var isSelected: Bool
    
    var action:() -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 20) {
                
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .tint(isSelected ? .white : Color("Color.1"))
                
                Text(title)
                    .foregroundColor(isSelected ? .white : Color("Color.1"))
                
            }
        }
    }
}

struct GenderSelecting: View {
    
    @State private var gender: Gender?
    
    var disabled: Bool {
        gender == nil
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color("Color.1"), Color("Color.2")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                Text("Select your Gender")
                    .foregroundColor(Color("Color.3"))
                
                HStack(spacing: 40) {
                    
                    ForEach(Gender.allCases, id: \.self) { g in
                        
                        TabButton(title: g.title, image: g.image, isSelected: g == gender) {
                            withAnimation {
                                gender = g
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
                Button(action: genderSelecting) {
                    let color: Color = disabled ? .gray : .white
                    color
                        .frame(height: 45)
                        .overlay{
                            Text("Register")
                        }
                }
                .clipShape(Capsule())
                .contentShape(Capsule())
                .disabled(disabled)
                .padding(.horizontal, 28)
                .padding(.top, 40)
            }
            
        }
    }
    
    private func genderSelecting() {
        
    }
}

struct Gender_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelecting()
    }
}
