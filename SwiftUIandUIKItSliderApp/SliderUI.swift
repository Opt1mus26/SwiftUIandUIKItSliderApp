//
//  SliderUI.swift
//  SwiftUIandUIKItSliderApp
//
//  Created by Pavel Tsyganov on 31.01.2022.
//

import SwiftUI

struct SliderUI: UIViewRepresentable {
    
    @Binding var currentValue: Double
    
    let color: UIColor
    let alpha: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.changeValue),
            for: .valueChanged
        )
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.thumbTintColor = color.withAlphaComponent(CGFloat(alpha) / 100)
        uiView.value = Float(currentValue)
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $currentValue)
    }
}

extension SliderUI {
    class Coordinator: NSObject {
        @Binding var value: Double
        
        init(value: Binding<Double>) {
            self._value = value
            
        }
        @objc func changeValue(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }
}

struct SliderUI_Previews: PreviewProvider {
    static var previews: some View {
        SliderUI(currentValue: .constant(50), color: .blue, alpha: 100)
    }
}

