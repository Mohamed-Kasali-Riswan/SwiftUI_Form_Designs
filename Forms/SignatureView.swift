//
//  SignatureView.swift
//  zoxo
//
//  Created by Mohamed Kasali Riswan A on 08/12/25.
//

import SwiftUI
import PencilKit

struct SignatureView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

struct ContentVview: View {
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        VStack {
            SignatureView(canvasView: $canvasView)
                .frame(height: 200)
                .background(Color.white)
                .border(Color.gray)
            
            Button("Save Signature") {
                let signatureImage = canvasView.drawing.image(from: canvasView.bounds, scale: 1)
                // Save or attach to document
            }
        }
        .padding()
    }
}

#Preview {
    ContentVview()
}
