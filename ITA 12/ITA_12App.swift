	//
	//  ITA_12App.swift
	//  ITA 12
	//
	//  Created by mcpeaps_HD on 08/08/2023.
	//

import SwiftUI
import SwiftData
#if os(macOS)
import LaunchAtLogin
#endif

@main
struct ITA_12App: App {
	
	@Environment(\.scenePhase) private var scenePhase
		//let persistenceController = PersistenceController.shared
#if os(macOS)
	@NSApplicationDelegateAdaptor(AppDeligate.self) private var appDeligate
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
	
	
	func goBack() {
		switch selectedSideBarItem_Global {
			case .Moodle:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .Moodle_goBack
			case .TimeTable:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .TimeTable_goBack
			case .WebUntis:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .WebUntis_goBack
			case .OSZimt:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .OSZimt_goBack
			case .ChatGPT:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .ChatGPT_goBack
			case .Discord:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .Discord_goBack
			case .WWW:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .WWW_goBack
			default:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .ClassSide_goBack
				
		}
	}
	func goForward() {
			// Implement go forward logic
		switch selectedSideBarItem_Global {
			case .Moodle:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .Moodle_goForword
			case .TimeTable:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .TimeTable_goForword
			case .WebUntis:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .WebUntis_goForword
			case .OSZimt:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .OSZimt_goForword
			case .ChatGPT:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .ChatGPT_goForword
			case .Discord:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .Discord_goForword
			case .WWW:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .WWW_goForword
			default:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .ClassSide_goForword
		}
	}
	
	func goHome() {
			// Implement go home logic
		switch selectedSideBarItem_Global {
			case .Moodle:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .Moodle_goHome
			case .TimeTable:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .TimeTable_goHome
			case .WebUntis:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .WebUntis_goHome
			case .OSZimt:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .OSZimt_goHome
			case .ChatGPT:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .ChatGPT_goHome
			case .Discord:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .Discord_goHome
			case .WWW:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .WWW_goHome
			default:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .ClassSide_goHome
		}
	}
	
	func reload() {
			// Implement reload logic
		switch selectedSideBarItem_Global {
			case .Moodle:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .Moodle_reload
			case .TimeTable:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .TimeTable_reload
				print(selectedSideBarItem_Global.title)
			case .WebUntis:
				menubarAktions = .WebUntis_reload
				print(selectedSideBarItem_Global.title)
			case .OSZimt:
				menubarAktions = .OSZimt_reload
				print(selectedSideBarItem_Global.title)
			case .ChatGPT:
				menubarAktions = .ChatGPT_reload
				print(selectedSideBarItem_Global.title)
			case .Discord:
				menubarAktions = .Discord_reload
				print(selectedSideBarItem_Global.title)
			case .WWW:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .WWW_reload
			default:
				print(selectedSideBarItem_Global.title)
				menubarAktions = .ClassSide_reload
		}
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
		Settings{
			SettingsView().frame(minWidth: 300,idealWidth: 450,maxWidth: .infinity,minHeight: 100,idealHeight: 100,maxHeight: .infinity).background(.ultraThinMaterial)
				.background(BlurView())
		}.modelContainer(for: [Homework.self])
		.commands {
			CommandGroup(after:.appInfo) {
				Divider()
				LaunchAtLogin.Toggle {
					Text("Launch at login")
				}
			}
			CommandGroup(before: .toolbar) {
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
					Text("Go Back")
				}
				.keyboardShortcut("<", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
					Text("Go Forward")
				}
				.keyboardShortcut(">", modifiers: .command)
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
					Text("Go Home")
				}
				.keyboardShortcut(".", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
					Text("Reload")
				}
				.buttonRepeatBehavior(.enabled)
				.keyboardShortcut("r", modifiers: .command)
				Divider()
			}
			
			
		}
		
		
		
#endif
	}
}

var menubarAktions: MenubarAktions = .nothing
enum MenubarAktions: String, Identifiable, CaseIterable {
	var id: String {
		rawValue
	}
	case ClassSide_goBack
	case ClassSide_goForword
	case ClassSide_goHome
	case ClassSide_reload
	case Moodle_goBack
	case Moodle_goForword
	case Moodle_goHome
	case Moodle_reload
	case TimeTable_goBack
	case TimeTable_goForword
	case TimeTable_goHome
	case TimeTable_reload
	case WebUntis_goBack
	case WebUntis_goForword
	case WebUntis_goHome
	case WebUntis_reload
	case OSZimt_goBack
	case OSZimt_goForword
	case OSZimt_goHome
	case OSZimt_reload
	case ChatGPT_goBack
	case ChatGPT_goForword
	case ChatGPT_goHome
	case ChatGPT_reload
	case Discord_goBack
	case Discord_goForword
	case Discord_goHome
	case Discord_reload
	case WWW_goBack
	case WWW_goForword
	case WWW_goHome
	case WWW_reload
	case nothing
	
	
	
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
	//@Environment(\.modelContext) var context
	@AppStorage("ITA 12_searchEngine") var searchEngine: String?
	
	let searchEngines = ["Google", "Bing", "DuckDuckGo", "Yahoo", "Other"]
	let ac = ["Blau", "Lila", "Rosa", "Rot", "Orange", "Gelb", "Grün", "Graphit"]
	
	@AppStorage("ITA 12_selectedSEIndex") var selectedSEIndex: Int = 2  // Default to "DuckDuckGo" (index 2)
	@AppStorage("ITA 12_cSE") var cSE: String?
	@AppStorage("ITA 12_cSEisSet") var cSEisSet: Bool?
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorIndex") var colorIndex: Int = 0
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
	
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
	
	/*func generateRandomHomework() -> Homework {
		let subjects = ["Mathematik", "Deutsch", "Englisch", "Anwendungssysteme", "IT-Systeme"]
		let selectedSubject = subjects.randomElement()!
		let task = "Hausaufgabe für \(selectedSubject)"
		let randomDueDate = Date().addingTimeInterval(Double.random(in: 1...30) * 24 * 60 * 60) // Fälligkeitsdatum zwischen 1 und 30 Tagen ab heute
		let randomCreationDate = Date().addingTimeInterval(-Double.random(in: 1...7) * 24 * 60 * 60) // Erstellungsdatum zwischen 1 und 7 Tagen vor heute
		let notes = "Dummy Notizen für die Hausaufgabe"
		
		return Homework(task: task, dueDate: randomDueDate, creationDate: randomCreationDate, selectedSubjects: selectedSubject, notes: notes)
	}
	
	@State var randomHomeworks: [Homework] = []*/

	
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
#if os(iOS) || os(xrOS)
							.autocapitalization(.none)
							.disableAutocorrection(true)
#endif
					}
					
					Button("Save Search Engine", action: {
						safeSE()
					}).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
				}
#if os(iOS) || os(xrOS)
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
					.onChange(of: colorIndex) { _ in
						safeAC()
					}
					
					VStack(alignment: .leading, spacing: 10) { // Use LazyVStack for vertical alignment
						Section {
							HStack{
								Circle()
									.fill(colorisSet ?? false ? Color(colorString!): .accentColor)
									.frame(width: 20, height: 20)
									.padding(5)
								Text("Current").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
							}
						}
						Divider()
						ForEach(0..<ac.count, id: \.self) { index in
							Section {
								HStack {
									Circle()
										.fill(Color(ac[index] == "Orange" ? "Orange_me" : ac[index]))
										.frame(width: 20, height: 20)
										.padding(5)
										.onTapGesture {
											colorIndex = index
										}
									Text(ac[index]).foregroundStyle(Color(ac[index] == "Orange" ? "Orange_me" : ac[index]))
										.onTapGesture {
											colorIndex = index
										}
								}
							}
							if (index + 1) < ac.count {
								Divider()
							}
						}
					}
				}
#endif
/*#if os(iOS)
				Section(header: Text("Teste Homework Liste")) {
					Button("Add Test Entries") {
						for _ in 0...19 {
							let randomHomework = generateRandomHomework()
							self.randomHomeworks.append(randomHomework)
							context.insert(randomHomework) // Assuming context is a managed object context for Core Data
						}
					}.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
				}
				
#endif*/
				
			}
		}
	}
}

#if os(iOS)
struct HomeworkView: View {
	@Environment(\.modelContext) var context
	@Query(sort: \Homework.dueDate) var homeworkEntries: [Homework]
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
	@State private var showAddView = false
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
		}
		
		do {
			try context.save()
		} catch {
			print("Error saving context: \(error)")
		}
	}

	
	var body: some View {
		NavigationSplitView {
			/*HStack {
				Image(systemName: "magnifyingglass").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
				TextField("Search", text: $searchText).textFieldStyle(.plain).foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
			}.padding().clipShape(Capsule()).background(Capsule(style: .continuous).strokeBorder(colorisSet ?? false ? Color(colorString!): .accentColor)).padding()*/
			List{
				if filteredHomeworkEntries.isEmpty {
					VStack(alignment: .center) {
						ContentUnavailableView("No Homwork Found", systemImage: "doc.text.image", description: Text("Create a Homework Task with the Plus at the Right in the Toolbar or clear the Searchbox")).padding()
					}
				}else {
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
							NavigationLink(destination: HomeworkDetail(entry: entry)) {
								HomeworkListEntry(entry: entry, isSelected: isSelected, isBatchDeleteActive: $isBatchDeleteActive)
							}
						}
					}.onDelete(perform: { IndexSet in
						for index in IndexSet {
							context.delete(filteredHomeworkEntries[index])
							try! context.save()
						}
					})
					
				}
			}.listStyle(.sidebar)
				.searchable(text: $searchText)
		} detail: {ContentUnavailableView("No Homwork Found", systemImage: "doc.text.image", description: Text("Create a Homework Task with the Plus at the Right in the Toolbar or clear the Searchbox")).padding()}
			.sheet(isPresented: $showAddView) {
				AddHomeworkView(isShown: $showAddView).padding()
			}
			.toolbar {
				if isBatchDeleteActive == false {
					ToolbarItem(placement: .topBarTrailing) {
						Button(action: {
							showAddView.toggle()
						}) {
							Text("ADD").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						}
					}
					ToolbarItem(placement: .topBarLeading) {
						Button(action: {
							isBatchDeleteActive.toggle()
						}) {
							Text("DELETE").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						}
					}
				} else {
					ToolbarItem(placement: .cancellationAction) {
						Button(action: {
							isBatchDeleteActive.toggle()
						}) {
							Text("CANCEL").foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						}
					}
					ToolbarItem(placement: .confirmationAction) {
						Button(action: {
								// Implement the logic to delete selected entries
							deleteSelectedEntries(at: selectedIndices)
							isBatchDeleteActive.toggle() // Make sure to toggle batch delete mode off
						}) {
							Text("DONE").foregroundStyle(selectedIndices.isEmpty ? .secondary : (colorisSet ?? false ? Color(colorString!): .accentColor))
						}.disabled(selectedIndices.isEmpty)
					}
				}
				
			}.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
	}
}
struct CustomCheckboxStyle: ToggleStyle {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
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
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
	var entry: Homework
	@Binding var isSelected: Bool // Add this binding for selection
	@Binding var isBatchDeleteActive: Bool
	
	var body: some View {
		HStack(alignment: .center) {
			if isBatchDeleteActive {
				Toggle(isOn: $isSelected) {
						// Empty Text to reserve space for the Toggle
					Text("")
				}.toggleStyle(CustomCheckboxStyle())
				.fixedSize() // Fix the size of the Toggle
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
			.layoutPriority(1) // Allow this part to be compressed if needed
		}
	}
}



struct HomeworkDetail: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
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
			}

			.navigationBarTitle("Neue Aufgabe hinzufügen")
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

#endif
 
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


