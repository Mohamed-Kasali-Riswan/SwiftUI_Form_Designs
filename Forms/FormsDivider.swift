//
//  FormsDivider.swift
//  zoxo
//
//  Created by Mohamed Kasali Riswan A on 03/12/25.
//

import SwiftUI
import PhotosUI

struct FormsDivider: View {
    
    @State private var showFormsLogic1 = false
    @State private var showFormsLogic2 = false
    @State private var showFormsLogic3 = false
    @State private var showFormsLogic4 = false
    @State private var showFormsLogic5 = false
    @State private var showFormsLogic6 = false
    @State private var showFormsLogic7 = false
    
    var body: some View {
        Form {
            Section(header:
                Text("Folders")
                    .font(.caption)
            ) {
                
                ListOfButtons(title: "1", icon: "star", iconColor: Color.orange.opacity(0.6)) {
                    showFormsLogic1 = true
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom, 5)
                
                ListOfButtons(title: "2", icon: "star", iconColor: Color.orange.opacity(0.6)) {
                    showFormsLogic2 = true
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom, 5)
                
                ListOfButtons(title: "3", icon: "star", iconColor: Color.orange.opacity(0.6)) {
                    showFormsLogic3 = true
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom, 5)
                
                ListOfButtons(title: "4", icon: "star", iconColor: Color.orange.opacity(0.6)) {
                    showFormsLogic4 = true
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom, 5)
                
                ListOfButtons(title: "5", icon: "star", iconColor: Color.orange.opacity(0.6)) {
                    showFormsLogic6 = true
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom, 5)
                
                ListOfButtons(title: "6", icon: "star", iconColor: Color.orange.opacity(0.6)) {
                    showFormsLogic7 = true
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom, 5)

            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .navigationDestination(isPresented: $showFormsLogic1) { FormsLogic1() }
        .navigationDestination(isPresented: $showFormsLogic2) { FormsLogic2() }
        .navigationDestination(isPresented: $showFormsLogic3) { FormsLogic3() }
        .navigationDestination(isPresented: $showFormsLogic4) { FormsLogic4() }
        .navigationDestination(isPresented: $showFormsLogic5) { FormsLogic5() }
        .navigationDestination(isPresented: $showFormsLogic6) { FormsLogic6() }
        .navigationDestination(isPresented: $showFormsLogic7) { FormsLogic7() }
    }
    
}
