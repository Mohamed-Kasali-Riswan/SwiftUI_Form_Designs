//
//  FormsLogic1.swift
//  zoxo
//
//  Created by Mohamed Kasali Riswan A on 03/12/25.
//

import SwiftUI
import PhotosUI

struct FormsLogic1: View {
    
    let highLightColor: Color = Color(red:1.0/255.0, green:175.0/255.0, blue:133.0/255.0, opacity: 1)
    
    @State var selectedFormat: String = "pdf"
    
    @State var userName: String = ""
    
    @State var password: String = ""
    
    @State var age: Int?
    
    @State var weight: Decimal?
    
    @State var email: String = ""
    
    @State var mobileNumber: String = ""
    
    @State var date: Date = Date.now
    
    @State var blah: String = "Mentions"
    
    @State var choice: String = "A"
    
    @State var count: Int = 0
    
    @State var volume: Double = 0
    
    @State var docTypes: [String] = ["pdf", "docx", "png", "jpeg"]
    
    @State var isToggleOn: Bool = false
    
    @State var isPasswordVisible: Bool = false
    
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var selectedItems: [PhotosPickerItem] = []
    
    @State private var selectedImage: UIImage?
    
    @State private var selectedImages: [UIImage] = []
    
    @FocusState var isKeyboardFocused : Bool
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Form {
                    
                    // Text Boxes
                    Section (header: Text("Text Box")){
                        TextField("Enter text", text: $userName)
                            .textFieldStyle(.automatic)
                            .focused($isKeyboardFocused)
                    }
                    
                    Section (header: Text("NumberPad Text Box")){
                        TextField("Enter your age", value: $age, format: .number)
                            .textFieldStyle(.automatic)
                            .keyboardType(.numberPad)
                            .focused($isKeyboardFocused)
                    }
                    Section (header: Text("DecimalPad Text Box")){
                        TextField("Enter your weight", value: $weight, format: .number)
                            .textFieldStyle(.automatic)
                            .keyboardType(.decimalPad)
                            .focused($isKeyboardFocused)
                    }
                    Section (header: Text("Email Address Text Box")){
                        TextField("Enter your email address", text: $email)
                            .textFieldStyle(.automatic)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .focused($isKeyboardFocused)
                    }
                    Section (header: Text("PhonePad Text Box")){
                        TextField("Enter mobile number", text: $mobileNumber)
                            .textFieldStyle(.automatic)
                            .keyboardType(.phonePad)
                            .focused($isKeyboardFocused)
                    }
                    
                    // Date Pickers
                    Section(header: Text("Compact Picker")) {
                        DatePicker("Date Of Birth", selection: $date, in: ...Date())
                            .datePickerStyle(.compact)
                    }
                    
                    Section(header: Text("Wheel Picker")) {
                        DatePicker("Date Of Birth", selection: $date, in: ...Date())
                            .datePickerStyle(.wheel)
                    }
                    
                    Section(header: Text("Graphical Picker")) {
                        DatePicker("Select Date", selection: $date)
                            .datePickerStyle(.graphical)
                    }
                    
                    // Optional Pickers
                    Section(header: Text("Default Picker")) {
                        Picker("Select a Format" , selection: $selectedFormat) {
                            ForEach(docTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Segmented Picker")) {
                        Text("Chosen choice is \(blah)")
                        Picker("Notify Me About ", selection: $blah) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(highLightColor)
                    }
                    
                    Section(header: Text("Menu Picker")) {
                        Picker("Notify Me About ", selection: $blah) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section(header: Text("Notify Me About "),
                            footer: Text("Radio Group Picker")) {
                        Picker("", selection: $blah) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .labelsHidden()
                        .pickerStyle(.inline)
                    }
                    
                    Section(header: Text("Navigation Link Picker")) {
                        Picker("Go & Choose", selection: $blah) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .labelsHidden()
                        .pickerStyle(.navigationLink)
                    }
                    
                    // Secure Field
                    Section(
                        header: Text("Password"),
                        footer: Text("Make sure your password is strong!")
                    ) {
                        HStack {
                            ZStack {
                                // Secure field (hidden when visible)
                                SecureField("Password", text: $password)
                                    .opacity(isPasswordVisible ? 0 : 1)
                                
                                // Text field (shown when visible)
                                TextField("Password", text: $password)
                                    .opacity(isPasswordVisible ? 1 : 0)
                            }
                            .animation(.easeInOut(duration: 0.25), value: isPasswordVisible)
                            
                            Spacer()
                            
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        isPasswordVisible.toggle()
                                    }
                                }
                        }
                    }
                    
                    // Togglers
                    Section(header: Text("Automatic Toggle")) {
                        Toggle("Remember Me", isOn: $isToggleOn)
                    }
                    
                    Section(header: Text("Button Toggle")) {
                        Toggle("Remember Me", isOn: $isToggleOn)
                            .toggleStyle(.button)
                    }
                    
                    // Stepper
                    Section(header: Text("Stepper")) {
                        Stepper("Count: \(count)", value: $count)
                    }
                    
                    // Custom Stepper
                    Section(header: Text("Custom Stepper")) {
                        Stepper("Value: \(count)") {
                            count += 2   // on increment
                        } onDecrement: {
                            count -= 2   // on decrement
                        }
                    }
                    
                    // Slider
                    Section(header: Text("Stepper \(Int(volume))")) {
                        HStack {
                            Image(systemName: "speaker.fill")
                            Slider(value: $volume, in: 0...100)
                                .tint(highLightColor)
                            Image(systemName: "speaker.wave.3.fill")
                        }
                        
                    }
                    
                    // Image Picker for single Photo
                    VStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                        }
                        
                        PhotosPicker("Pick Image", selection: $selectedItem, matching: .images)
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImage = UIImage(data: data)
                                    }
                                }
                            }
                    }
                    .padding()
                    
                    // Photos Picker for Multiple Photos
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(selectedImages, id: \.self) { img in
                                    Image(uiImage: img)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        
                        PhotosPicker("Pick Images",
                                     selection: $selectedItems,
                                     maxSelectionCount: 0,
                                     matching: .images)
                        .onChange(of: selectedItems) { newItems in
                            Task {
                                selectedImages.removeAll()
                                for item in newItems {
                                    if let data = try? await item.loadTransferable(type: Data.self),
                                       let img = UIImage(data: data) {
                                        selectedImages.append(img)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
            } .navigationTitle("Forms")
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isKeyboardFocused = false
                }
            }
        }
    }
}

#Preview {
    FormsLogic1()
}
