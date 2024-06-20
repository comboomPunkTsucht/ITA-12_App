	//
	//  ITA_12App.swift
	//  ITA 12
	//
	//  Created by mcpeaps_HD on 08/08/2023.
	//

import SwiftUI
import SwiftData
import CryptoKit
#if os(macOS)
import LaunchAtLogin
#endif

@main
struct ITA_12App: App {
	
	@Environment(\.scenePhase) private var scenePhase
		//let persistenceController = PersistenceController.shared
#if os(macOS)
	//@NSApplicationDelegateAdaptor(AppDeligate.self) private var appDeligate
	var appState: AppState = AppState()
	@State private var screenWidth: CGFloat
	@State private var screenHeight: CGFloat
	
	@State private var minWidth: CGFloat = 0.0
	@State private var minHeight: CGFloat = 0.0
	@State private var idealWidth: CGFloat = 0.0
	@State private var idealHeight: CGFloat = 0.0
	
	init() {
			// Calculate initial screen width and height
		let initialScreenWidth = NSScreen.main?.frame.size.width ?? 1280
		let initialScreenHeight = NSScreen.main?.frame.size.height ?? 720
		
			// Initialize the state properties
		_screenWidth = State(initialValue: initialScreenWidth)
		_screenHeight = State(initialValue: initialScreenHeight)
		
			// Initialize minWidth and minHeight using the calculated values
		
		minWidth = screenWidth * appState.minFactor
		minHeight = screenHeight * appState.minFactor
		idealWidth = screenWidth * appState.idealFactor
		idealHeight = screenHeight * appState.idealFactor
		
		
	}
	
#endif
	
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				//.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
				.modelContainer(for: [Homework.self])
#if os(macOS)
				.frame(
					minWidth: minWidth,
					idealWidth: idealWidth,
					maxWidth: .infinity,
					minHeight: minHeight,
					idealHeight: idealHeight,
					maxHeight: .infinity
				)
				.background(.ultraThinMaterial)
				.background(BlurView())
#endif
		}
		/*.onChange(of: scenePhase) { newScenePhase in
		 if newScenePhase == .inactive {
		 persistenceController.save()
		 }
		 }*/
#if os(macOS)
		.commands {
			CommandGroup(after:.appInfo) {
				Divider()
				LaunchAtLogin.Toggle {
					Text("Launch at login")
				}
				Divider()
			}
			
			
		}
		
		
		
#endif
	}
}


class AppState: ObservableObject, Codable {
	public var minFactor: CGFloat
	public var idealFactor: CGFloat
	
	init() {
		minFactor = 0.5
		idealFactor = 0.75
	}
}
struct SettingsView: View {
	
	@Environment(\.modelContext) var context
	
	@AppStorage("ITA 12_searchEngine") var searchEngine: String?
	
	let searchEngines = ["Google", "Bing", "DuckDuckGo", "Yahoo", "Other"]
	let ac = ["Blau", "Lila", "Rosa", "Rot", "Orange", "Gelb", "Grün", "Graphit"]
	
	@AppStorage("ITA 12_selectedSEIndex") var selectedSEIndex: Int = 2  // Default to "DuckDuckGo" (index 2)
	@AppStorage("ITA 12_cSE") var cSE: String?
	@AppStorage("ITA 12_cSEisSet") var cSEisSet: Bool?
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorIndex") var colorIndex: Int = 0
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
	@AppStorage("ITA 12_devtools") var devtools: Bool = false
	
	init() {
		if cSEisSet ?? false {
			cSE = searchEngine
		}
	}
	
	func formatSearchEngineString(for unformatted: String) -> String {
		let delimiter = "%s"
		let output = unformatted.lowercased().components(separatedBy: delimiter)
		return output[0]
	}
	
	func safeSE() {
		switch selectedSEIndex {
			case 0:
				searchEngine = "https://www.google.com/search?q="
			case 1:
				searchEngine = "https://www.bing.com/search?q="
			case 3:
				searchEngine = "https://search.yahoo.com/search?p="
			case 4:
				cSEisSet = true
				searchEngine = formatSearchEngineString(for: cSE!)
			default:
				searchEngine = "https://duckduckgo.com/?q="
		}
	}
	
	func safeAC() {
		switch colorIndex {
			case 1:
				colorString = ac[1]
				colorisSet = true
			case 2:
				colorString = ac[2]
				colorisSet = true
			case 3:
				colorString = ac[3]
				colorisSet = true
			case 4:
				colorString = "Orange_me"
				colorisSet = true
			case 5:
				colorString = ac[5]
				colorisSet = true
			case 6:
				colorString = ac[6]
				colorisSet = true
			case 7:
				colorString = ac[7]
				colorisSet = true
			default:
				colorString = ac[0]
				colorisSet = true
		}
	}
	
	
	
	func generateRandomHomework() -> Homework {
		let subjects = ["Mathematik", "Deutsch", "Englisch", "Anwendungssysteme", "IT-Systeme"]
		let selectedSubject = subjects.randomElement()!
		let task = "Hausaufgabe für \(selectedSubject)"
		let randomDueDate = Date().addingTimeInterval(Double.random(in: 1...30) * 24 * 60 * 60) // Fälligkeitsdatum zwischen 1 und 30 Tagen ab heute
		let randomCreationDate = Date().addingTimeInterval(-Double.random(in: 1...7) * 24 * 60 * 60) // Erstellungsdatum zwischen 1 und 7 Tagen vor heute
		let notes = "Dummy Notizen für die Hausaufgabe"
		
		return Homework(task: task, dueDate: randomDueDate, creationDate: randomCreationDate, selectedSubjects: selectedSubject, notes: notes)
	}
	
	@State var randomHomeworks: [Homework] = []
	

	
	var body: some View {
		VStack {
			Form {
				Section(header: Text("Search Engine")) {
					Picker("Select Search Engine", selection: $selectedSEIndex) {
						ForEach(0..<searchEngines.count, id: \.self) { index in
							Text(searchEngines[index])
						}
					}
					
					if searchEngines[selectedSEIndex] == "Other" {
						let localCSEBinding = Binding<String>(
							get: { cSE ?? "" },
							set: { newValue in cSE = newValue }
						)
						
						TextField("Custom search URL ending with ?q=%s", text: localCSEBinding, onCommit: safeSE)
							.textFieldStyle(PlainTextFieldStyle())
							.padding(.vertical, 8)
							.padding(.horizontal)
							.clipShape(Capsule())
							.background(Capsule().strokeBorder(colorisSet ?? false ? Color(colorString!): .accentColor))
#if os(iOS) || os(visionOS)
							.autocapitalization(.none)
							.disableAutocorrection(true)
#endif
					}
					
					Button("Save Search Engine", action: {
						safeSE()
					}).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
				}
#if os(iOS) || os(visionOS)
				Section(header: Text("Accent Color")) {
					Picker("Select Accent Color", selection: $colorIndex) {
						ForEach(0..<ac.count, id: \.self) { index in
							HStack {
								Circle()
									.fill(Color(ac[index]))
									.frame(width: 20, height: 20)
									.padding(5)
								Text(ac[index]).foregroundStyle(Color(ac[index]))
							}
						}
					}.onDisappear {
						safeAC()
					}
					.onChange(of: colorIndex) {
						safeAC()
					}
					
							HStack{
								Circle()
									.fill(colorisSet ?? false ? Color(colorString!): .accentColor)
									.frame(width: 20, height: 20)
									.padding(5)
								Text("Current").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
							}
						
						ForEach(0..<ac.count, id: \.self) { index in
							
							Button(action: {
								colorIndex = index
							}) {
									HStack {
										Circle()
											.fill(Color(ac[index] == "Orange" ? "Orange_me" : ac[index]))
											.frame(width: 20, height: 20)
											.padding(5)
										Text(ac[index])
											.foregroundStyle(Color(ac[index] == "Orange" ? "Orange_me" : ac[index]))
										Spacer()
									}
									.contentShape(Rectangle()) // Ensure whole HStack is tappable
									.onTapGesture {
										colorIndex = index
									}
							}
						}
					}
#endif
				

				Section(header: Text("Entwikler Tools")) {
						HStack {
							Text("Entwikler Tools")
							Spacer()
							Toggle("", isOn: $devtools).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						}
						if (devtools) {
							Button("Add Test Entries", action: {
									for _ in 0...19 {
										let randomHomework = generateRandomHomework()
										self.randomHomeworks.append(randomHomework)
										context.insert(randomHomework) // Assuming context is a managed object context for Core Data
									}
								}).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
							
						}
					}
				

				Section(header: Text("Informationen")) {
						HStack {
							let buildString = ((Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "") + " " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""))
							let hashValueString = String(hashAndTruncate(buildString) ?? "")
							let capitalizedBuildString = hashValueString.capitalized
							Text("App Version:") // Beschreibung Linke kante
							Spacer()
							Text("Version " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "") + " (Build " + capitalizedBuildString + ")").foregroundStyle(Color("Graphit")).onTapGesture(perform: {print(capitalizedBuildString)}) // content Rechte kante
						}
						HStack {
							Text("OS Version:") // Beschreibung Linke kante
							Spacer()
							Text(ProcessInfo.processInfo.operatingSystemVersionString).foregroundStyle(Color("Graphit")) // content Rechte kante
						}

				}
				
			}
		}
	}
}

struct HomeworkView: View {
	@Environment(\.modelContext) private var context
	@Query(sort: \Homework.dueDate) var homeworkEntries: [Homework]
	@AppStorage("ITA_12_colorString") var colorString: String?
	@AppStorage("ITA_12_colorisSet") var colorisSet: Bool?
	@State private var showAddView = false
	@State private var showDetailView = false
	@State private var selectedHomeworkEntry: Homework?
	@State var searchText = ""
	@State private var selectedIndices = IndexSet()
	@State private var isBatchDeleteActive = false
	
	var filteredHomeworkEntries: [Homework] {
		if searchText.isEmpty {
			return homeworkEntries
		} else {
			return homeworkEntries.filter { entry in
				entry.task.localizedCaseInsensitiveContains(searchText) ||
				entry.selectedSubjects.localizedCaseInsensitiveContains(searchText) ||
				entry.notes.localizedCaseInsensitiveContains(searchText)
			}
		}
	}
	
	func deleteSelectedEntries(at indices: IndexSet) {
		for index in indices {
			context.delete(filteredHomeworkEntries[index])
			selectedIndices.remove(index)
			selectedHomeworkEntry = nil
		}
		
		do {
			try context.save()
		} catch {
			print("Error saving context: \(error)")
		}
	}
	
	func deleteAllEntries() {
		for entry in homeworkEntries {
			context.delete(entry)
			
		}
		selectedHomeworkEntry = nil
		
		do {
			try context.save()
		} catch {
			print("Error saving context: \(error)")
		}
	}
	
	var body: some View {
		NavigationView {
			List {
				if filteredHomeworkEntries.isEmpty {
					VStack(alignment: .center) {
						ContentUnavailableView("No Homework Found", systemImage: "doc.text.image", description: Text("Create a Homework Task with the Plus at the Right in the Toolbar or clear the Searchbox")).padding()
					}
				} else {
					ForEach(filteredHomeworkEntries, id: \.self) { entry in
						if let index = filteredHomeworkEntries.firstIndex(of: entry) {
							let isSelected = Binding(
								get: {
									selectedIndices.contains(index)
								},
								set: {
									if $0 {
										selectedIndices.insert(index)
									} else {
										selectedIndices.remove(index)
									}
								}
							)
#if os(iOS)
							NavigationLink(destination: HomeworkDetail(entry: entry)) {
								HomeworkListEntry(entry: entry, isSelected: isSelected, isBatchDeleteActive: $isBatchDeleteActive)
							}
#else
							Button(action: {
								self.selectedHomeworkEntry = entry
								self.showDetailView.toggle()
							}) {
								HomeworkListEntry(entry: entry, isSelected: isSelected, isBatchDeleteActive: $isBatchDeleteActive)
							}
							#endif
						}
					}
					.onDelete(perform: deleteSelectedEntries)
				}
			}
			.listStyle(SidebarListStyle())
			.searchable(text: $searchText)
			.navigationTitle("Homework")
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button(action: {
						showAddView.toggle()
					}) {
						Image(systemName: "plus.circle").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
					}
				}
				ToolbarItem(placement: .destructiveAction) {
					Button(action: {
						isBatchDeleteActive.toggle()
					}) {
						Text("DELETE").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
					}
				}
				if isBatchDeleteActive {
					ToolbarItem(placement: .cancellationAction) {
						Button(action: {
							isBatchDeleteActive.toggle()
						}) {
							Text("CANCEL").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						}
					}
					ToolbarItem(placement: .confirmationAction) {
						Button(action: {
							deleteSelectedEntries(at: selectedIndices)
							isBatchDeleteActive.toggle()
						}) {
							Text("DONE").foregroundStyle(selectedIndices.isEmpty ? .secondary : (colorisSet ?? false ? Color(colorString!): .accentColor))
						}
						.disabled(selectedIndices.isEmpty)
					}
					ToolbarItem(placement: .destructiveAction) {
						Button(action: {
							deleteAllEntries()
							isBatchDeleteActive.toggle()
						}) {
							Text("DELETE ALL").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						}
					}
				}
			}
			.sheet(isPresented: $showAddView) {
				AddHomeworkView(isShown: $showAddView).padding()
			}
			if let entry = selectedHomeworkEntry {
				HomeworkDetail(entry: entry).padding().frame(alignment: .center)
			} else {
				ContentUnavailableView("No Homework Selected", systemImage: "doc.text.image", description: Text("Select a Homework to View it's Details")).padding().frame(alignment: .center)
			}
			
		}
	}
}

struct CustomCheckboxStyle: ToggleStyle {
	@AppStorage("ITA_12_colorString") var colorString: String?
	@AppStorage("ITA_12_colorisSet") var colorisSet: Bool?
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "checkmark.circle")
				.resizable()
				.frame(width: 20, height: 20)
				.foregroundColor(configuration.isOn ? (colorisSet ?? false ? Color(colorString!): .accentColor) : .secondary)
				.onTapGesture { configuration.isOn.toggle() }
			
			configuration.label
		}
	}
}

struct HomeworkListEntry: View {
	@AppStorage("ITA_12_colorString") var colorString: String?
	@AppStorage("ITA_12_colorisSet") var colorisSet: Bool?
	var entry: Homework
	@Binding var isSelected: Bool
	@Binding var isBatchDeleteActive: Bool
	
	var body: some View {
		HStack(alignment: .center) {
			if isBatchDeleteActive {
				Toggle(isOn: $isSelected) {
					Text("")
				}
				.toggleStyle(CustomCheckboxStyle())
				.fixedSize()
			}
			HStack {
				VStack(alignment: .leading) {
					Text(entry.task)
						.font(.headline)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
					Text(entry.selectedSubjects)
						.font(.subheadline)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
				}
				Spacer()
				Text(entry.dueDate.formatted(date: .abbreviated, time: .omitted))
					.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
			}
			.layoutPriority(1)
		}
	}
}

struct HomeworkDetail: View {
	@AppStorage("ITA_12_colorString") var colorString: String?
	@AppStorage("ITA_12_colorisSet") var colorisSet: Bool?
	var entry: Homework
	
	var body: some View {
		VStack {
			Text("Aufgabe: \(entry.task)")
				.font(.title).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
			Text("Erstelldatum: \(formattedDate(entry.creationDate))").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
			Text("Fälligkeitsdatum: \(formattedDate(entry.dueDate))").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
			Text("Fächer: \(entry.selectedSubjects)").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
			Text("Notizen: \(entry.notes)").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
		}
		.padding()
	}
	
	func formattedDate(_ date: Date?) -> String {
		guard let date = date else {
			return ""
		}
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter.string(from: date)
	}
}

struct AddHomeworkView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
	@Binding var isShown: Bool
	@Environment(\.modelContext) var context
	@State private var task = ""
	@State private var dueDate = Date()
	@State private var selectedSubjects = ""
	@State private var notes = ""
	
	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("Aufgaben Details")) {
					TextField("Aufgabe", text: $task).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
					DatePicker("Fälligkeitsdatum", selection: $dueDate, displayedComponents: .date).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
					TextField("Fäch", text: $selectedSubjects).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
					MultilineTextField(hint:"Notizen" ,text: $notes)// Hintergrundfarbe anpassen
						.foregroundColor(colorisSet ?? false ? Color(colorString!): .accentColor)
				}
				Section {
					Button("Speichern") {
						let newEntry = Homework(task: task, dueDate: dueDate,creationDate: Date(), selectedSubjects: selectedSubjects, notes: notes)
						context.insert(newEntry)
						isShown.toggle()
					}.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
				}
				Button("Abreichen") {
					self.isShown.toggle()
				}
			}
#if !os(macOS)
			.navigationBarTitle("Neue Aufgabe")
			#endif
		}
	}
}
struct MultilineTextField: View {
	var hint: String
	@Binding var text: String
	
	var body: some View {
		LazyVStack(alignment: .leading){
			if text.isEmpty {
				Text(hint).font(.footnote).foregroundStyle(.secondary)
			}
			TextEditor(text: $text)
				.frame(minHeight: 100) // Setzen Sie eine Mindesthöhe für das Textfeld
				.textFieldStyle(RoundedBorderTextFieldStyle()) // Optional, für das Erscheinungsbild
		}
	}
}


 
func hashAndTruncate(_ input: String) -> String? {
	guard let inputData = input.data(using: .utf8) else {
		return nil
	}
	
		// Hash the input string using SHA256
	let hashedData = SHA256.hash(data: inputData)
	
		// Truncate the hash to 6 bytes
	let truncatedHash = hashedData.prefix(3)
	
		// Convert the truncated hash to a hex string
	let hexString = truncatedHash.map { String(format: "%02x", $0) }.joined()
	
	return hexString
}



@Model
class Homework {
	var task: String!
	var creationDate: Date!
	var dueDate: Date!
	var selectedSubjects: String!
	var notes: String!
	
	init(task: String!, dueDate: Date!, creationDate: Date!, selectedSubjects: String!, notes: String!) {
		self.task = task
		self.dueDate = dueDate
		self.creationDate = creationDate
		self.selectedSubjects = selectedSubjects
		self.notes = notes
	}
}


