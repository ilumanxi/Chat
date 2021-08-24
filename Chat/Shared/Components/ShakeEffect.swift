//
//  ShakeEffect.swift
//  ShakeEffect
//
//  Created by 风起兮 on 2021/8/24.
//  https://talk.objc.io/episodes/S01E173-building-a-shake-animation

import SwiftUI

struct ShakeEffect: GeometryEffect {
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }
}

extension View {
    func shakeEffect(shakes: Int) -> some View {
        self.modifier(ShakeEffect(shakes: shakes))
    }
}
