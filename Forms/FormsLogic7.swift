//
//  FormsLogic7.swift
//  zoxo
//
//  Created by Mohamed Kasali Riswan A on 08/12/25.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct FormsLogic7: View {
    
    // MARK: - 📝 Input State
    @State private var fullName = ""
    
    @State private var email = ""
    
    @State private var password = ""
    
    @State private var isPasswordVisible = false
    
    @State private var phoneNumber = ""
    
    @State private var website = ""
    
    @State private var age: Double = 25
    
    @State private var budget: Double?
    
    @State private var experienceYears: Int = 1
     
    @State private var selectedCountry = "United States"
    
    @State private var showCountrySheet = false
    
    @State private var selectedCategory = "Design"
    
    @State private var notificationsEnabled = true
    
    @State private var marketingEmails = false
    
    @State private var selectedDate = Date()
    
    @State private var selectedTime = Date()
    
    @State private var brandColor: Color = .blue
    
    @State private var singlePhotoItem: PhotosPickerItem?
    
    @State private var singlePhoto: Image?
    
    @State private var multiplePhotoItems: [PhotosPickerItem] = []
    
    @State private var multiplePhotos: [Image] = []
     
    @State private var showFileImporter = false
    
    @State private var selectedFiles: [URL] = []
    
    let categories = ["Design", "Development", "Marketing", "Business", "Testing"]
    
    let countries = ["United States", "India", "United Kingdom", "Germany", "Japan", "Canada", "Australia", "France", "United Arab Emirates", "Vatican City", "kenya", "Ethiopia", "South Africa", "Botswana", "Namibia", "Zimbabwe", "Mozambique", "Zambia", "Malawi", "Tanzania", "yemen", "Seychelles"]
     
    @FocusState private var focusedField: String?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // MARK: Header
                        VStack(spacing: 8) {
                            Text("Create Profile")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundStyle(DesignSystem.primaryGradient)
                            Text("Fill in the details to join the network.")
                                .font(.subheadline)
                                .foregroundColor(DesignSystem.textSecondary)
                        }
                        .padding(.top, 20)
                        
                        // MARK: 1. Identity Section
                        VStack(spacing: 20) {
                            SectionLabel(title: "Identity", icon: "person.crop.circle.fill")
                            
                            FloatingTextField(title: "Full Name", icon: "person", text: $fullName)
                                .focused($focusedField, equals: "name")
                            
                            FloatingTextField(title: "Email Address", icon: "envelope", text: $email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .focused($focusedField, equals: "email")
                            
                            // Custom Password Field
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(DesignSystem.textSecondary)
                                    .frame(width: 20)
                                
                                if isPasswordVisible {
                                    TextField("Password", text: $password)
                                        .focused($focusedField, equals: "password")
                                } else {
                                    SecureField("Password", text: $password)
                                        .focused($focusedField, equals: "password")
                                }
                                
                                Button(action: { isPasswordVisible.toggle() }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(DesignSystem.textSecondary)
                                }
                            }
                            .padding()
                            .background(Color(uiColor: .tertiarySystemFill))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke( password.isEmpty ? Color.gray.opacity(0.2) : DesignSystem.primaryGradient.opacity(0.3), lineWidth: 1))
                            
                            FloatingTextField(title: "Phone", icon: "phone", text: $phoneNumber)
                                .keyboardType(.phonePad)
                                .focused($focusedField, equals: "phone")
                            
                            FloatingTextField(title: "Portfolio (URL)", icon: "link", text: $website)
                                .keyboardType(.URL)
                                .textInputAutocapitalization(.never)
                                .focused($focusedField, equals: "website")
                        }
                        
                        // MARK: 2. Metrics & Numeric
                        VStack(spacing: 20) {
                            SectionLabel(title: "Metrics", icon: "chart.bar.fill")
                            
                            // Stepper
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Years of Experience")
                                        .font(.caption).bold().foregroundColor(DesignSystem.textSecondary)
                                    Text("\(experienceYears) \(experienceYears > 1 ? "Years" : experienceYears == 1 ? "Year" : "")")
                                        .font(.title3).bold().foregroundColor(DesignSystem.textPrimary)
                                }
                                Spacer()
                                Stepper("", value: $experienceYears, in: 0...50)
                                    .labelsHidden()
                            }
                            .padding()
                            .background(Color(uiColor: .tertiarySystemFill))
                            .cornerRadius(15)

                            // Slider
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Age Preference")
                                        .font(.caption).bold().foregroundColor(DesignSystem.textSecondary)
                                    Spacer()
                                    Text("\(Int(age))")
                                        .font(.headline)
                                        .foregroundStyle(DesignSystem.primaryGradient)
                                }
                                Slider(value: $age, in: 18...100, step: 1)
                                    .tint(DesignSystem.primaryGradient)
                            }
                            
                            // Decimal Currency
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Hourly Rate (USD)")
                                    .font(.caption).bold().foregroundColor(DesignSystem.textSecondary)
                                TextField("0.00", value: $budget, format: .currency(code: "USD"))
                                    .keyboardType(.decimalPad)
                                    .font(.system(.title3, design: .monospaced))
                                    .focused($focusedField, equals: "budget")
                                    .padding()
                                    .background(Color(uiColor: .tertiarySystemFill))
                                    .cornerRadius(12)
                            }
                        }
                        
                        // MARK: 3. Logic & Bools
                        VStack(spacing: 15) {
                            SectionLabel(title: "Preferences", icon: "gearshape.fill")
                            
                            Toggle(isOn: $notificationsEnabled) {
                                HStack {
                                    Image(systemName: "bell.badge.fill")
                                        .foregroundStyle(.purple.opacity(0.5), .pink.opacity(0.5))
                                    Text("Push Notifications")
                                        .fontWeight(.medium)
                                        .foregroundColor(DesignSystem.textPrimary)
                                }
                            }
                            .tint(DesignSystem.primaryGradient)
                            
                            Divider()
                            
                            Toggle(isOn: $marketingEmails) {
                                HStack {
                                    Image(systemName: "envelope.badge.fill")
                                        .foregroundStyle(.blue.opacity(0.7))
                                    Text("Subscribe to Newsletter")
                                        .fontWeight(.medium)
                                        .foregroundColor(DesignSystem.textPrimary)
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: DesignSystem.primaryGradient))
                        }
                        .padding(20)
                        
                        // MARK: 4. Selectors & Pickers
                        VStack(spacing: 20) {
                            SectionLabel(title: "Selection", icon: "list.bullet.rectangle.portrait.fill")
                            
                            // Custom Dropdown
                            Menu {
                                ForEach(categories, id: \.self) { cat in
                                    Button(action: { selectedCategory = cat }) {
                                        Label(cat, systemImage: "tag")
                                    }
                                }
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Category")
                                            .font(.caption).foregroundColor(DesignSystem.textSecondary)
                                        Text(selectedCategory)
                                            .font(.headline).foregroundColor(DesignSystem.textPrimary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(DesignSystem.textSecondary)
                                }
                                .padding()
                                .background(Color(uiColor: .tertiarySystemFill))
                                .cornerRadius(12)
                            }
                            
                            // Country Picker Button
                            Button(action: { showCountrySheet = true }) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Country")
                                            .font(.caption).foregroundColor(DesignSystem.textSecondary)
                                        Text(selectedCountry)
                                            .font(.headline).foregroundColor(DesignSystem.textPrimary)
                                    }
                                    Spacer()
                                    Image(systemName: "globe.americas.fill")
                                        .font(.title2)
                                        .foregroundStyle(DesignSystem.primaryGradient)
                                }
                                .padding()
                                .background(DesignSystem.cardBackground)
                                .cornerRadius(12)
                                .shadow(color: DesignSystem.shadow(), radius: 5)
                                // Add border for dark mode visibility since shadow disappears
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            }
                        }
                        
                        // MARK: 5. Date & Time
                        VStack(spacing: 0) {
                            SectionLabel(title: "Schedule", icon: "calendar")
                                .padding(.bottom, 15)
                            
                            DatePicker("Start Date", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .tint(DesignSystem.primaryGradient)
                            
                            Divider()
                            
                            DatePicker("", selection: $selectedTime, in: ...Date())
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                        }
                        
                        // MARK: 6. Media
                        VStack(alignment: .leading, spacing: 15) {
                            SectionLabel(title: "Media", icon: "photo.on.rectangle.fill")
                            
                            // Single Image
                            HStack {
                                PhotosPicker(selection: $singlePhotoItem, matching: .images) {
                                    ZStack {
                                        if let image = singlePhoto {
                                            image.resizable().scaledToFill()
                                        } else {
                                            VStack {
                                                Image(systemName: "person.crop.circle.badge.plus")
                                                    .font(.largeTitle)
                                                Text("Profile")
                                                    .font(.caption)
                                            }
                                            .foregroundColor(DesignSystem.primaryGradient)
                                        }
                                    }
                                    .frame(width: 80, height: 80)
                                    .background(Color(uiColor: .tertiarySystemFill))
                                    .clipShape(Circle())
                                }
                                .onChange(of: singlePhotoItem) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                                            singlePhoto = Image(uiImage: uiImage)
                                        }
                                    }
                                }
                                
                                Text("Tap to upload profile picture")
                                    .font(.caption)
                                    .foregroundColor(DesignSystem.textSecondary)
                            }
                            
                            Divider()
                            
                            // Multiple Images
                            Text("Gallery Upload (Select Multiple)")
                                .font(.caption).bold().foregroundColor(DesignSystem.textSecondary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0..<multiplePhotos.count, id: \.self) { index in
                                        multiplePhotos[index]
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(8)
                                    }
                                    
                                    PhotosPicker(selection: $multiplePhotoItems, maxSelectionCount: 10, matching: .images) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5])).foregroundColor(DesignSystem.primaryGradient)
                                            .frame(width: 70, height: 70)
                                            .overlay(Image(systemName: "plus").foregroundColor(DesignSystem.primaryGradient))
                                    }
                                }
                            }
                            .onChange(of: multiplePhotoItems) { newItems in
                                Task {
                                    multiplePhotos = []
                                    for item in newItems {
                                        if let data = try? await item.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                                            multiplePhotos.append(Image(uiImage: uiImage))
                                        }
                                    }
                                }
                            }
                        }
                        
                        // MARK: 7. Files
                        VStack(alignment: .leading, spacing: 15) {
                            SectionLabel(title: "Documents", icon: "folder.fill")
                            
                            Button(action: { showFileImporter = true }) {
                                HStack {
                                    Image(systemName: "doc.fill")
                                    Text("Upload Files (PDF, Doc)")
                                    Spacer()
                                    Image(systemName: "arrow.up.doc")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(DesignSystem.primaryGradient)
                                .cornerRadius(12)
                            }
                            .fileImporter(
                                isPresented: $showFileImporter,
                                allowedContentTypes: [.pdf, .text, .image],
                                allowsMultipleSelection: true
                            ) { result in
                                switch result {
                                case .success(let urls):
                                    selectedFiles.append(contentsOf: urls)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                            
                            if !selectedFiles.isEmpty {
                                ForEach(selectedFiles, id: \.self) { file in
                                    HStack {
                                        Image(systemName: "doc.text")
                                            .foregroundColor(brandColor)
                                        Text(file.lastPathComponent)
                                            .font(.caption)
                                            .lineLimit(1)
                                            .foregroundColor(DesignSystem.textPrimary)
                                        Spacer()
                                        Button(action: {
                                            if let index = selectedFiles.firstIndex(of: file) {
                                                selectedFiles.remove(at: index)
                                            }
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(8)
                                    .background(Color(uiColor: .tertiarySystemFill))
                                    .cornerRadius(8)
                                }
                            }
                        }

                        // MARK: 8. Visual Styles
                        VStack(spacing: 15) {
                            SectionLabel(title: "Appearance", icon: "paintpalette.fill")
                            ColorPicker("Accent Color", selection: $brandColor)
                                .padding()
                                .background(Color(uiColor: .tertiarySystemFill))
                                .cornerRadius(12)
                        }
                        
                        // MARK: Submit Button
                        Button(action: {
                            print("Submitting Form...")
                        }) {
                            Text("Complete Registration")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(DesignSystem.primaryGradient)
                                .cornerRadius(15)
                                .shadow(color: DesignSystem.primaryGradient.opacity(0.1), radius: 10, x: 0, y: 10)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal)
                }
                
                // Toolbar with DONE button
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            UIApplication.shared.endEditing()
                        }
                        .fontWeight(.bold)
                        .tint(DesignSystem.primaryGradient)
                    }
                }
            }
            .navigationTitle("")
            .sheet(isPresented: $showCountrySheet) {
                CountrySelectionSheet(selectedCountry: $selectedCountry, countries: countries)
                    .presentationDetents([.medium, .large])
            }
        }
    }
}


#Preview {
    FormsLogic7()
        .preferredColorScheme(.dark)
}
