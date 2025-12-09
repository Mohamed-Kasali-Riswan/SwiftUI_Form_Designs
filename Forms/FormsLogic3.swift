//
//  FormsLogic3.swift
//  zoxo
//
//  Created by Mohamed Kasali Riswan A on 03/12/25.
//

import SwiftUI
import PhotosUI

// MARK: - 1. Custom Theme Extensions
extension Color {
    // We keep these static because they don't change
    //    static let themeBackground = Color(red: 248/255, green: 249/255, blue: 253/255)
    //    static let themeCard = Color.white
    static let themeGreen = Color(red:1.0/255.0, green:175.0/255.0, blue:133.0/255.0, opacity: 1)
    static let themeBackground = Color(.systemGroupedBackground)  // Auto adaptive
    static let themeCard       = Color(.secondarySystemBackground) // Auto adaptive
    
}

struct FormsLogic3: View {
    
    // MARK: - State Properties
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
    @State var volume: Double = 50
    @State var docTypes: [String] = ["PDF", "DOCX", "PNG", "JPEG"]
    @State var isToggleOn: Bool = false
    @State var isPasswordVisible: Bool = false
    @State var showDropdown: Bool = false
    @State private var searchText: String = ""
    @State private var selectedCountry: String = ""
    let countries = ["USA", "UK", "Canada", "Australia", "India", "Germany", "France", "Japan", "Singapore"]
    let availableSkills = ["SwiftUI", "UIKit", "Node.js", "Python", "React", "AWS", "Figma"]
    @State var selectedSkills: Set<String> = []
    @State private var selectedDocument: URL?
    @State private var selectedDocuments: [URL] = []
    @State private var showSingleDocPicker = false
    @State private var showMultipleDocPicker = false
    
    // THEME COLOR STATE
    @State private var appThemeColor: Color = .themeGreen
    let palette: [Color] = [.red, .orange, .yellow, .green, .mint, .teal, .blue, .indigo, .purple, .pink]
    
    // Image Picker States
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImage: UIImage?
    @State private var selectedImages: [UIImage] = []
    
    // Keyboard Focus State
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                Color.themeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // MARK: - Header
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Profile Details")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            Text("Please fill in your information below.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        // MARK: - Section: Personal Info
                        VStack(spacing: 20) {
                            // FIX: Pass appThemeColor to the header
                            SectionHeader(title: "Personal Information", icon: "person.text.rectangle", color: appThemeColor)
                            
                            CustomTextField(title: "Full Name", placeholder: "Enter text", text: $userName)
                                .focused($isInputActive)
                            
                            CustomNumberField(title: "Age", placeholder: "Enter age", value: $age, keyboardType: .numberPad)
                                .focused($isInputActive)
                            
                            CustomDecimalField(title: "Weight", placeholder: "Enter weight", value: $weight)
                                .focused($isInputActive)
                            
                            CustomTextField(title: "Email", placeholder: "name@example.com", text: $email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .focused($isInputActive)
                            
                            CustomTextField(title: "Phone", placeholder: "Mobile Number", text: $mobileNumber)
                                .keyboardType(.phonePad)
                                .focused($isInputActive)
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.caption).fontWeight(.bold).foregroundColor(.secondary)
                                
                                HStack {
                                    ZStack {
                                        if !isPasswordVisible {
                                            SecureField("Password", text: $password)
                                        } else {
                                            TextField("Password", text: $password)
                                        }
                                    }
                                    .padding(.trailing, 36)
                                    .animation(.easeInOut(duration: 0.25), value: isPasswordVisible)
                                    
                                    Button {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            isPasswordVisible.toggle()
                                        }
                                    } label: {
                                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(appThemeColor) // FIX: Use variable directly
                                            .frame(width: 36)
                                    }
                                }
                                .padding()
                                .background(Color.themeBackground)
                                .cornerRadius(12)
                                .focused($isInputActive)
                            }
                        }
//                        .modifier(CardStyle())
                        
                        // MARK: - Section: Color Picker
                        VStack(spacing: 20) {
                            SectionHeader(title: "Theme Color", icon: "paintpalette", color: appThemeColor)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(palette, id: \.self) { color in
                                        Button {
                                            withAnimation { appThemeColor = color }
                                        } label: {
                                            ZStack {
                                                Circle().fill(color).frame(width: 30, height: 30)
                                                if appThemeColor == color {
                                                    Circle().stroke(Color.primary.opacity(0.6), lineWidth: 3)
                                                        .frame(width: 38, height: 38)
                                                }
                                            }
                                            .padding(4)
                                        }
                                    }
                                }
                            }
                        }
//                        .modifier(CardStyle())
                        
                        VStack(spacing: 20) {
                            SectionHeader(title: "Country & Skills", icon: "location.magnifyingglass", color: appThemeColor)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Country Origin").font(.caption).bold().foregroundColor(.secondary).padding(.bottom, 8)
                                
                                Button { withAnimation { showDropdown.toggle() } } label: {
                                    HStack {
                                        Text(selectedCountry.isEmpty ? "Select Country" : selectedCountry)
                                            .foregroundColor(selectedCountry.isEmpty ? .secondary : .primary)
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .rotationEffect(.degrees(showDropdown ? 180 : 0))
                                    }
                                    .padding()
                                    .background(Color.themeBackground)
                                    .cornerRadius(12)
                                }
                                
                                if showDropdown {
                                    VStack(alignment: .leading, spacing: 0) {
                                        TextField("Search...", text: $searchText)
                                            .padding(10).background(Color.white).padding(5)
                                        Divider()
                                        ScrollView {
                                            LazyVStack(alignment: .leading) {
                                                let filtered = countries.filter { searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }
                                                ForEach(filtered, id: \.self) { country in
                                                    Button {
                                                        selectedCountry = country
                                                        withAnimation { showDropdown = false }
                                                        searchText = ""
                                                    } label: {
                                                        Text(country).foregroundColor(.primary)
                                                            .padding(.vertical, 10).padding(.horizontal, 15)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                    }
                                                    Divider()
                                                }
                                            }
                                        }.frame(maxHeight: 150)
                                    }
                                    .background(Color.themeBackground)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    .padding(.top, 5)
                                }
                            }
                            .zIndex(10) // Important for dropdown
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Select Skills").font(.caption).bold().foregroundColor(.secondary)
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
                                    ForEach(availableSkills, id: \.self) { skill in
                                        let isSelected = selectedSkills.contains(skill)
                                        Button {
                                            withAnimation {
                                                if isSelected { selectedSkills.remove(skill) }
                                                else { selectedSkills.insert(skill) }
                                            }
                                        } label: {
                                            Text(skill)
                                                .font(.system(size: 14, weight: .medium))
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 16)
                                                .background(isSelected ? appThemeColor : Color.themeBackground)
                                                .foregroundColor(isSelected ? .white : .primary)
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                            }
                            
                        }
//                        .modifier(CardStyle())
                        
                        // MARK: - Section: Dates
                        VStack(spacing: 20) {
                            SectionHeader(title: "Dates & Timings", icon: "calendar", color: appThemeColor)
                            
                            VStack(alignment: .leading) {
                                Text("Custom Expiration").font(.caption).bold().foregroundColor(.secondary)
                                ExpirationCard(dueDate: $date, pickerType: .dateTime , WDGreenColor : $appThemeColor )
                            }
                            
                            Divider()
                            
                            DatePicker("Date of Birth", selection: $date, in: ...Date(), displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .tint(appThemeColor) // FIX
                            
                            Divider()
                            
                            DatePicker("Graphical Selection", selection: $date, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .tint(appThemeColor) // FIX
                                .padding()
                                .background(Color.themeBackground)
                                .cornerRadius(12)
                        }
//                        .modifier(CardStyle())
                        
                        // MARK: - Section: Preferences
                        VStack(spacing: 20) {
                            SectionHeader(title: "Preferences", icon: "gearshape", color: appThemeColor)
                            
                            // Menu Picker
                            HStack {
                                Text("File Format")
                                Spacer()
                                Picker("Format", selection: $selectedFormat) {
                                    ForEach(docTypes, id: \.self) { Text($0) }
                                }
                                .pickerStyle(.menu)
                                .tint(appThemeColor) // FIX: Removed Color. prefix
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.themeBackground)
                                .cornerRadius(8)
                            }
                            
                            // Segmented
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Notification Type").font(.caption).bold().foregroundColor(.secondary)
                                Picker("Notify", selection: $blah) {
                                    Text("Direct").tag("Direct Msg")
                                    Text("Mentions").tag("Mentions")
                                    Text("All").tag("Anything")
                                }
                                .pickerStyle(.segmented)
                                .colorMultiply(appThemeColor) // FIX
                            }
                            
                            // Radio Style
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Radio Selection").font(.caption).bold().foregroundColor(.secondary)
                                ForEach(["Direct Msg", "Mentions", "Anything"], id: \.self) { option in
                                    Button(action: { blah = option }) {
                                        HStack {
                                            Text(option).foregroundColor(.primary)
                                            Spacer()
                                            Image(systemName: blah == option ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(blah == option ? appThemeColor : .gray.opacity(0.5)) // FIX
                                                .font(.title3)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                        }
//                        .modifier(CardStyle())
                        
                        // MARK: - Section: Controls
                        VStack(spacing: 20) {
                            SectionHeader(title: "Controls", icon: "slider.horizontal.3", color: appThemeColor)
                            
                            Toggle("Automatic Sync", isOn: $isToggleOn)
                                .tint(appThemeColor)
                            
                            HStack {
                                Text("Button Toggle")
                                Spacer()
                                Toggle("Remember Me", isOn: $isToggleOn)
                                    .toggleStyle(.button)
                                    .tint(appThemeColor)
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Volume")
                                    Spacer()
                                    Text("\(Int(volume))%").bold().foregroundColor(appThemeColor)
                                }
                                HStack {
                                    Image(systemName: "speaker.fill").foregroundColor(.gray)
                                    Slider(value: $volume, in: 0...100, step: 1)
                                        .tint(appThemeColor) // FIX
                                    Image(systemName: "speaker.wave.3.fill").foregroundColor(.gray)
                                }
                            }
                            
                            Stepper("Count Value: \(count)", value: $count)
                                .padding()
                                .background(Color.themeBackground)
                                .cornerRadius(10)
                        }
//                        .modifier(CardStyle())
                        
                        // MARK: - Section: Media
                        VStack(spacing: 20) {
                            SectionHeader(title: "Media Upload", icon: "photo.on.rectangle", color: appThemeColor)
                            
                            VStack {
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .shadow(radius: 3)
                                } else {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.themeBackground)
                                        .frame(width: 100, height: 100)
                                        .overlay(Image(systemName: "photo").foregroundColor(.gray))
                                }
                                
                                PhotosPicker(selection: $selectedItem, matching: .images) {
                                    Text("Select Profile Photo")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(appThemeColor) // FIX
                                        .cornerRadius(10)
                                }
                                .onChange(of: selectedItem) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            selectedImage = UIImage(data: data)
                                        }
                                    }
                                }
                            }
                            
                            Divider()
                            
                            // Multiple Images
                            VStack(alignment: .leading) {
                                Text("Gallery").font(.caption).bold().foregroundColor(.secondary)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(selectedImages, id: \.self) { img in
                                            Image(uiImage: img)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 70, height: 70)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                        
                                        PhotosPicker(selection: $selectedItems, maxSelectionCount: 0, matching: .images) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                                .foregroundColor(appThemeColor) // FIX
                                                .frame(width: 70, height: 70)
                                                .overlay(Image(systemName: "plus").foregroundColor(appThemeColor)) // FIX
                                        }
                                    }
                                }
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
                        }
//                        .modifier(CardStyle())
                        
                        // MARK: - Section: Files Picker
                        VStack(spacing: 20) {
                            SectionHeader(title: "Documents", icon: "doc.on.doc", color: appThemeColor)

                            // Single file picker
                            Button {
                                showSingleDocPicker = true
                            } label: {
                                HStack {
                                    Image(systemName: "doc.badge.plus")
                                    Text("Select a File")
                                    Spacer()
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(appThemeColor)
                                .cornerRadius(12)
                            }
                            .fileImporter(
                                isPresented: $showSingleDocPicker,
                                allowedContentTypes: [.item], // any type
                                allowsMultipleSelection: false
                            ) { result in
                                switch result {
                                case .success(let urls):
                                    selectedDocument = urls.first
                                    print("📄 Single doc: \(urls.first?.lastPathComponent ?? "")")
                                case .failure(let error):
                                    print("❌ Picker error: \(error.localizedDescription)")
                                }
                            }

                            if let url = selectedDocument {
                                Text("Selected: \(url.lastPathComponent)")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            }

                            Divider()

                            // Multiple file picker
                            Button {
                                showMultipleDocPicker = true
                            } label: {
                                HStack {
                                    Image(systemName: "folder.badge.plus")
                                    Text("Select Multiple Files")
                                    Spacer()
                                }
                                .foregroundColor(appThemeColor)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(appThemeColor, lineWidth: 2)
                                )
                            }
                            .fileImporter(
                                isPresented: $showMultipleDocPicker,
                                allowedContentTypes: [.item],
                                allowsMultipleSelection: true
                            ) { result in
                                switch result {
                                case .success(let urls):
                                    selectedDocuments = urls
                                    urls.forEach { print("📦 \( $0.lastPathComponent )") }
                                case .failure(let error):
                                    print("❌ Picker error: \(error.localizedDescription)")
                                }
                            }

                            if !selectedDocuments.isEmpty {
                                VStack(alignment: .leading, spacing: 6) {
                                    ForEach(selectedDocuments, id: \.self) { url in
                                        Text(url.lastPathComponent)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
//                        .modifier(CardStyle())
                        
                        Spacer().frame(height: 20)
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                    .fontWeight(.bold)
                    .foregroundColor(appThemeColor) // FIX
                }
            }
        }
    }
}

// MARK: - Reusable Styles & Components
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(Color.themeCard)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

struct SectionHeader: View {
    @Environment(\.colorScheme) var scheme

    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(scheme == .dark ? color.opacity(0.8) : color)
                .font(.title3)

            Text(title)
                .font(.headline).bold()
                .foregroundColor(.primary)

            Spacer()
        }
        .padding(.bottom, 5)
    }
}

// Custom Text Field Wrapper
struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .padding()
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.ultraThinMaterial)          // Background color
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1) // Border line
                )
        }
    }
}

// Custom Number Field Wrapper
struct CustomNumberField: View {
    let title: String
    let placeholder: String
    @Binding var value: Int?
    var keyboardType: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            TextField(placeholder, value: $value, format: .number)
                .keyboardType(keyboardType)
                .padding()
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.ultraThinMaterial)            // Background color
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1) // Border line
                )
        }
    }
}

// Custom Decimal Field Wrapper
struct CustomDecimalField: View {
    let title: String
    let placeholder: String
    @Binding var value: Decimal?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            TextField(placeholder, value: $value, format: .number)
                .keyboardType(.decimalPad)
                .padding()
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.ultraThinMaterial)            // Background color
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1) // Border line
                )
        }
    }
}
 
#Preview {
    FormsLogic3()
}
