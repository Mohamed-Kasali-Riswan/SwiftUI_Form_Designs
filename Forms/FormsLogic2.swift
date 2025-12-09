//
//  FormsLogic2.swift
//  zoxo
//
//  Created by Mohamed Kasali Riswan A on 03/12/25.
//

import SwiftUI
import PhotosUI

enum PickerFormat { case date, time, dateTime }

struct FormsLogic2: View {
    
    let highLightColor: Color = Color(red: 1.0/255.0, green: 175.0/255.0, blue: 133.0/255.0)
    
    @State var selectedFormat: String = "pdf"
    
    @State var userName: String = ""
    
    @State var password: String = ""
    
    @State var age: Int?
    
    @State var weight: Decimal?
    
    @State var email: String = ""
    
    @State var mobileNumber: String = ""
    
    @State var date: Date = Date.now
    
    @State var defaultPicker: String = "Mentions"
    
    @State var segmentedPicker: String = "Mentions"
    
    @State var menuPicker: String = "Mentions"
    
    @State var radioGroupPicker: String = "Mentions"
    
    @State var navigationLinkPicker: String = "Mentions"
    
    @State var choice: String = "A"
    
    @State var count: Int = 0
    
    @State var volume: Double = 50
    
    @State var docTypes: [String] = ["pdf", "docx", "png", "jpeg"]
    
    @State var isToggleOn: Bool = false
    
    @State var isPasswordVisible: Bool = false
    
    @FocusState var isInputActive: Bool
    
    // Image Picker States
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImage: UIImage?
    @State private var selectedImages: [UIImage] = []
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Form {
                    
                    // MARK: - Text Boxes
                    Section (header: Text("Text Box")){
                        TextField("Enter text", text: $userName)
                            .textFieldStyle(.automatic)
                            .focused($isInputActive)
                    }
                    
                    Section (header: Text("NumberPad Text Box")){
                        TextField("Enter your age", value: $age, format: .number)
                            .keyboardType(.numberPad)
                            .focused($isInputActive)
                    }
                    
                    Section (header: Text("DecimalPad Text Box")){
                        TextField("Enter your weight", value: $weight, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                    }
                    
                    Section (header: Text("Email Address Text Box")){
                        TextField("Enter your email address", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .focused($isInputActive)
                    }
                    
                    Section (header: Text("PhonePad Text Box")){
                        TextField("Enter mobile number", text: $mobileNumber)
                            .keyboardType(.phonePad)
                            .focused($isInputActive)
                    }
                    
                    // MARK: - Custom Styled Pickers
                    // Replaced standard Compact Picker with your Custom Style
                    Section(header: Text("Custom Style Picker")) {
                        ExpirationCard(dueDate: $date, pickerType: .dateTime)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Standard Wheel Picker
                    Section(header: Text("Date Of Birth by Wheel Picker")) {
                        DatePicker("", selection: $date, in: ...Date())
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                    }
                    
                    // Graphical Picker with Highlight Color
                    Section(header: Text("Graphical Picker")) {
                        DatePicker("Select Date", selection: $date)
                            .datePickerStyle(.graphical)
                            .tint(highLightColor) // Applied Color
                    }
                    
                    // MARK: - Optional Pickers
                    Section(header: Text("Default Picker")) {
                        Picker("Select a Format" , selection: $selectedFormat) {
                            ForEach(docTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(highLightColor)
                    }
                    
                    Section(header: Text("Segmented Picker")) {
                        Text("Chosen choice is \(segmentedPicker)")
                        Picker("Notify Me About ", selection: $segmentedPicker) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(highLightColor) // Applied Color
                    }
                    
                    Section(header: Text("Menu Picker")) {
                        Picker("Notify Me About ", selection: $menuPicker) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .pickerStyle(.menu)
                        .tint(highLightColor)
                    }
                    
                    Section(header: Text("Notify Me About "),
                            footer: Text("Radio Group Picker")) {
                        Picker("", selection: $radioGroupPicker) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .labelsHidden()
                        .pickerStyle(.inline)
                        .tint(highLightColor)
                    }
                    
                    Section(header: Text("Navigation Link Picker")) {
                        Picker("Go & Choose", selection: $navigationLinkPicker) {
                            Text("Direct Msg").tag("Direct Msg")
                            Text("Mentions").tag("Mentions")
                            Text("Anything").tag("Anything")
                        }
                        .labelsHidden()
                        .pickerStyle(.navigationLink)
                    }
                    
                    // MARK: - Password
                    Section(
                        header: Text("Password"),
                        footer: Text("Make sure your password is strong!")
                    ) {
                        HStack {
                            ZStack {
                                SecureField("Password", text: $password)
                                    .opacity(isPasswordVisible ? 0 : 1)
                                
                                TextField("Password", text: $password)
                                    .opacity(isPasswordVisible ? 1 : 0)
                            }
                            .animation(.easeInOut(duration: 0.25), value: isPasswordVisible)
                            
                            Spacer()
                            
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(highLightColor) // Applied Color
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.15)) {
                                        isPasswordVisible.toggle()
                                    }
                                }
                        }
                    }
                    
                    // MARK: - Toggles
                    Section(header: Text("Automatic Toggle")) {
                        Toggle("Remember Me", isOn: $isToggleOn)
                            .tint(highLightColor) // Applied Color
                    }
                    
                    Section(header: Text("Button Toggle")) {
                        Toggle("Remember Me", isOn: $isToggleOn)
                            .toggleStyle(.button)
                            .tint(highLightColor) // Applied Color
                    }
                    
                    // MARK: - Steppers & Sliders
                    Section(header: Text("Stepper")) {
                        Stepper("Count: \(count)", value: $count)
                    }
                    
                    Section(header: Text("Slider \(Int(volume))")) {
                        HStack {
                            Image(systemName: "speaker.fill")
                                .foregroundColor(highLightColor)
                            
                            Slider(value: $volume, in: 0...100, step: 1)
                                .tint(highLightColor) // Applied Color
                            
                            Image(systemName: "speaker.wave.3.fill")
                                .foregroundColor(highLightColor)
                        }
                    }
                    
                    // MARK: - Image Pickers
                    Section(header: Text("Single Image")) {
                        VStack {
                            HStack {
                                Spacer()
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                }
                                Spacer()
                            }
                            
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                Label("Pick Image", systemImage: "photo")
                                    .foregroundColor(highLightColor)
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImage = UIImage(data: data)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    
                    Section(header: Text("Multiple Images")) {
                        VStack {
                            if !selectedImages.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(selectedImages, id: \.self) { img in
                                            Image(uiImage: img)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            
                            HStack {
                                Spacer()
                                PhotosPicker(selection: $selectedItems, maxSelectionCount: 0, matching: .images) {
                                    Label("Pick Multiple Images", systemImage: "photo.stack")
                                        .foregroundColor(highLightColor)
                                }
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
                                Spacer()
                            }
                        }
                        .padding(.vertical)
                    }
                }
                
            } .navigationTitle("Forms")
        }
    }
}


// MARK: - Custom Style Component (From your source code)

struct ExpirationCard: View {
    @Environment(\.colorScheme) private var scheme

    @Binding var dueDate: Date
    @Binding var WDGreenColor: Color
    var pickerType: PickerFormat

    init(dueDate: Binding<Date>, pickerType: PickerFormat,
         WDGreenColor: Binding<Color> = .constant(Color(red: 1/255, green: 175/255, blue: 133/255))) {
        self._dueDate = dueDate
        self.pickerType = pickerType
        self._WDGreenColor = WDGreenColor
    }

    private var formattedText: String {
        let formatter = DateFormatter()
        switch pickerType {
        case .date: formatter.dateFormat = "dd MMM yyyy"
        case .time: formatter.dateFormat = "hh:mm a"
        case .dateTime: return ""
        }
        return formatter.string(from: dueDate)
    }

    private var displayedComponent: DatePicker.Components {
        switch pickerType {
        case .date: return .date
        case .time: return .hourAndMinute
        case .dateTime: return []
        }
    }

    var body: some View {
        Group {
            if pickerType == .dateTime {
                HStack(spacing: 10) {
                    ExpirationCard(dueDate: $dueDate, pickerType: .date, WDGreenColor: $WDGreenColor)
                    ExpirationCard(dueDate: $dueDate, pickerType: .time, WDGreenColor: $WDGreenColor)
                    Spacer()
                }
            } else {
                ZStack {
                    // 🟢 Adaptive card background
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))

                    /// Green text stays visible on both themes
                    HStack {
                        Text(formattedText)
                            .foregroundColor(WDGreenColor)
                            .font(.system(size: 16, weight: .medium))
                            .minimumScaleFactor(0.8)
                    }

                    // Invisible DatePicker tappable area
                    DatePicker("", selection: $dueDate, displayedComponents: displayedComponent)
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .tint(WDGreenColor)
                        .blendMode(.destinationOver)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            scheme == .dark ?
                                Color.white.opacity(0.15) : // Softer in dark mode
                                Color.black.opacity(0.1),
                            lineWidth: 1
                        )
                )
                .fixedSize()
                .frame(minHeight: 40)
            }
        }
    }
}

#Preview {
    FormsLogic2()
}










