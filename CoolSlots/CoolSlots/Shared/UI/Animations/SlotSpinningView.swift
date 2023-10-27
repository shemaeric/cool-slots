//
//  SlotSpinningView.swift
//  CoolSlots
//
//  Created by Eric Shema on 27/10/2023.
//

import UIKit
import Lottie

class SlotSpinningView: UIView {
    private var animationView = LottieAnimationView(name: "loader777")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAnimationView() {
        animationView.frame = frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        addSubview(animationView)
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
    }
}
