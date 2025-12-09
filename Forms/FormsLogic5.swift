//
//  FormsLogic5.swift
//  zoxo
//
//  Created by Mohamed Kasali Riswan A on 05/12/25.
//
 
import SwiftUI
import PhotosUI // Native SwiftUI Photo Picker
import UniformTypeIdentifiers

struct FormsLogic5: View {
    // MARK: - State Variables
    
    // Text & Keyboards
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var bio: String = ""
    @State private var website: String = ""
    
    // Numeric & Math
    @State private var age: Int = 18
    @State private var satisfactionLevel: Double = 5.0
    @State private var priceTarget: Double? = nil
    
    // Bools & Logic
    @State private var isSubscriber: Bool = false
    @State private var notificationsEnabled: Bool = true
    
    // Pickers & Categories
    @State private var selectedCountry: String = "USA"
    @State private var selectedRole: UserRole = .viewer
    @State private var selectedCategory: String = "Technology"
    
    // Date & Time
    @State private var birthDate = Date()
    @State private var wakeUpTime = Date()
    @State private var appointmentDate = Date()
    
    // Visuals
    @State private var themeColor: Color = .indigo
    
    // Media (Photos)
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedPhotoData: Data? = nil
    
    @State private var selectedMultipleItems: [PhotosPickerItem] = []
    @State private var selectedMultipleImagesData: [Data] = []
    
    // Files
    @State private var isImportingFile = false
    @State private var fileName: String = "No file selected"

    // MARK: - Data Models
    let countries = ["USA", "India", "UK", "Japan", "Germany", "Canada", "Brazil"]
    let categories = ["Technology", "Art", "Science", "Music"]
    
    enum UserRole: String, CaseIterable, Identifiable {
        case admin = "Admin"
        case editor = "Editor"
        case viewer = "Viewer"
        var id: String { self.rawValue }
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                // MARK: 1. Identity & Text
                Section {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.accentColor)
                        TextField("Full Name", text: $fullName)
                            .textContentType(.name)
                            .submitLabel(.next)
                    }
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.accentColor)
                        TextField("Email Address", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.accentColor)
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                    }
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.accentColor)
                        SecureField("Password", text: $password)
                    }
                    
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(.accentColor)
                        TextField("Website", text: $website)
                            .keyboardType(.URL)
                            .textInputAutocapitalization(.never)
                    }
                    
                } header: {
                    Text("Identity")
                } footer: {
                    Text("Your information is stored locally.")
                }

                // MARK: 2. Rich Text
                Section("Bio") {
                    TextField("Tell us about yourself...", text: $bio, axis: .vertical)
                        .lineLimit(3...6)
                }

                // MARK: 3. Numeric & Measurements
                Section("Metrics") {
                    Stepper(value: $age, in: 0...120) {
                        Label("Age: \(age)", systemImage: "calendar")
                    }
                    
                    VStack(alignment: .leading) {
                        Label("Satisfaction Level", systemImage: "star.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        HStack {
                            Slider(value: $satisfactionLevel, in: 0...10, step: 1)
                            Text("\(Int(satisfactionLevel))")
                                .bold()
                                .frame(width: 30)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    HStack {
                        Label("Bid Price", systemImage: "dollarsign.circle")
                        Spacer()
                        TextField("0.00", value: $priceTarget, format: .currency(code: "USD"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                }

                // MARK: 4. Selection & Pickers
                Section("Preferences") {
                    // Toggle Switch
                    Toggle(isOn: $isSubscriber) {
                        Label("Subscribe to Newsletter", systemImage: "newspaper")
                    }
                    .tint(.green)
                    
                    // Toggle Button Style
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Enable Notifications", systemImage: "bell.badge")
                    }
                    .toggleStyle(.button) // Button aesthetic
                    
                    // Menu Picker (Dropdown style)
                    Picker(selection: $selectedRole) {
                        ForEach(UserRole.allCases) { role in
                            Text(role.rawValue).tag(role)
                        }
                    } label: {
                        Label("User Role", systemImage: "person.badge.key")
                    }
                    .pickerStyle(.menu)
                    
                    // Segmented Picker
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical, 5)
                    
                    // Wheel Picker (Navigation Link style usually, but inline here)
                    Picker(selection: $selectedCountry) {
                        ForEach(countries, id: \.self) { country in
                            Text(country).tag(country)
                        }
                    } label: {
                        Label("Country", systemImage: "globe")
                    }
                    .pickerStyle(.navigationLink)
                }

                // MARK: 5. Date & Time
                Section("Scheduling") {
                    DatePicker(selection: $birthDate, displayedComponents: .date) {
                        Label("Birth Date", systemImage: "birthday.cake")
                    }
                    .datePickerStyle(.compact)
                    
                    DatePicker(selection: $wakeUpTime, displayedComponents: .hourAndMinute) {
                        Label("Alarm Time", systemImage: "alarm")
                    }
                    
                    DatePicker("Event", selection: $appointmentDate)
                        .datePickerStyle(.graphical) // Calendar view
                }

                // MARK: 6. Visuals
                Section("Appearance") {
                    ColorPicker(selection: $themeColor) {
                        Label("Theme Color", systemImage: "paintpalette")
                    }
                }

                // MARK: 7. Media (Native SwiftUI)
                Section("Media") {
                    // Single Image Picker
                    PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                        HStack {
                            Label("Select Profile Photo", systemImage: "photo")
                            Spacer()
                            if let data = selectedPhotoData, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onChange(of: selectedPhotoItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedPhotoData = data
                            }
                        }
                    }
                    
                    // Multiple Image Picker
                    PhotosPicker(selection: $selectedMultipleItems, maxSelectionCount: 5, matching: .images) {
                        Label("Select Gallery Images", systemImage: "photo.stack")
                    }
                    .onChange(of: selectedMultipleItems) { newItems in
                        Task {
                            selectedMultipleImagesData = []
                            for item in newItems {
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    selectedMultipleImagesData.append(data)
                                }
                            }
                        }
                    }
                    
                    if !selectedMultipleImagesData.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(selectedMultipleImagesData, id: \.self) { data in
                                    if let uiImage = UIImage(data: data) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets()) // Edge to edge
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                }

                // MARK: 8. Files
                Section("Documents") {
                    Button {
                        isImportingFile = true
                    } label: {
                        HStack {
                            Label("Upload Document", systemImage: "doc.fill")
                            Spacer()
                            Text(fileName)
                                .foregroundColor(.secondary)
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                    .fileImporter(
                        isPresented: $isImportingFile,
                        allowedContentTypes: [.pdf, .plainText, .image],
                        allowsMultipleSelection: false
                    ) { result in
                        switch result {
                        case .success(let url):
                            // NOTE: You must access security scoped resources for real files
                            // url.startAccessingSecurityScopedResource()
                            self.fileName = url.first?.lastPathComponent ?? "File selected"
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
                
                // MARK: 9. Submit Action
                Section {
                    Button(action: {
                        print("Form Submitted")
                    }) {
                        Text("Submit Form")
                            .frame(maxWidth: .infinity)
                            .bold()
                            .padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(themeColor) // Uses the dynamic color picker value
                }
                .listRowBackground(Color.clear) // Transparent background for button section
                .listRowInsets(EdgeInsets()) // Remove default padding
            }
            .navigationTitle("Ultimate Form")
        }
    }
}

#Preview {
    FormsLogic5()
}
