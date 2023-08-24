//
//  ITA_12App.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 08/08/2023.
//

import SwiftUI
#if os(macOS)
import LaunchAtLogin
#endif
var appState: AppState = AppState()
@main
struct ITA_12App: App {
	
	#if os(macOS)
	@NSApplicationDelegateAdaptor(AppDeligate.self) private var appDeligate
	
	@State private var screenWidth: CGFloat
	@State private var screenHeight: CGFloat
	
	private var minWidth: CGFloat = 0.0
	private var minHeight: CGFloat = 0.0
	private var idealWidth: CGFloat = 0.0
	private var idealHeight: CGFloat = 0.0
	let classSideView = ClassSideView()
	let moodleView = MoodleView()
	let timetableView = TimeTableView()
	let webUntisView = WebUntisView()
	let oszimtView = OSZimtView()
	let chatGPTView = ChatGPTView()
	let discodView = DiscordView()
	let wwwView = WWWView()
	
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
	/*
	
	func goBack() {
		switch selectedSideBarItem_Global {
			case .ClassSide:
				print(selectedSideBarItem_Global.title)
				classSideView.goBack()
			case .Moodle:
				print(selectedSideBarItem_Global.title)
				moodleView.goBack()
			case .TimeTable:
				print(selectedSideBarItem_Global.title)
				timetableView.goBack()
			case .WebUntis:
				print(selectedSideBarItem_Global.title)
				webUntisView.goBack()
			case .OSZimt:
				print(selectedSideBarItem_Global.title)
				oszimtView.goBack()
			case .ChatGPT:
				print(selectedSideBarItem_Global.title)
				chatGPTView.goBack()
			case .Discord:
				print(selectedSideBarItem_Global.title)
				discodView.goBack()
			case .WWW:
				print(selectedSideBarItem_Global.title)
				wwwView.goBack()
				
		}
	}
	func goForward() {
			// Implement go forward logic
		switch selectedSideBarItem_Global {
			case .ClassSide:
				print(selectedSideBarItem_Global.title)
				classSideView.goForward()
			case .Moodle:
				print(selectedSideBarItem_Global.title)
				moodleView.goForward()
			case .TimeTable:
				print(selectedSideBarItem_Global.title)
				timetableView.goForward()
			case .WebUntis:
				print(selectedSideBarItem_Global.title)
				webUntisView.goForward()
			case .OSZimt:
				print(selectedSideBarItem_Global.title)
				oszimtView.goForward()
			case .ChatGPT:
				print(selectedSideBarItem_Global.title)
				chatGPTView.goForward()
			case .Discord:
				print(selectedSideBarItem_Global.title)
				discodView.goForward()
			case .WWW:
				print(selectedSideBarItem_Global.title)
				wwwView.goForward()
		}
	}
	
		func goHome() {
				// Implement go home logic
			switch selectedSideBarItem_Global {
				case .ClassSide:
					print(selectedSideBarItem_Global.title)
					classSideView.goHome()
				case .Moodle:
					print(selectedSideBarItem_Global.title)
					moodleView.goHome()
				case .TimeTable:
					print(selectedSideBarItem_Global.title)
					timetableView.goHome()
				case .WebUntis:
					print(selectedSideBarItem_Global.title)
					webUntisView.goHome()
				case .OSZimt:
					print(selectedSideBarItem_Global.title)
					oszimtView.goHome()
				case .ChatGPT:
					print(selectedSideBarItem_Global.title)
					chatGPTView.goHome()
				case .Discord:
					print(selectedSideBarItem_Global.title)
					discodView.goHome()
				case .WWW:
					print(selectedSideBarItem_Global.title)
					wwwView.goHome()
			}
		}
	
		func reload() {
				// Implement reload logic
			switch selectedSideBarItem_Global {
				case .ClassSide:
					print(selectedSideBarItem_Global.title)
					classSideView.reload()
				case .Moodle:
					print(selectedSideBarItem_Global.title)
					moodleView.reload()
				case .TimeTable:
					print(selectedSideBarItem_Global.title)
					timetableView.reload()
					print(selectedSideBarItem_Global.title)
				case .WebUntis:
					webUntisView.reload()
					print(selectedSideBarItem_Global.title)
				case .OSZimt:
					oszimtView.reload()
					print(selectedSideBarItem_Global.title)
				case .ChatGPT:
					chatGPTView.reload()
					print(selectedSideBarItem_Global.title)
				case .Discord:
					discodView.reload()
					print(selectedSideBarItem_Global.title)
				case .WWW:
					print(selectedSideBarItem_Global.title)
					wwwView.reload()
			}
		}
	 */
#endif

	
	var body: some Scene {
		WindowGroup {

			ContentView()
			#if os(macOS)
				.frame(minWidth: minWidth,idealWidth: idealWidth,maxWidth: .infinity,minHeight: minHeight,idealHeight: idealHeight,maxHeight: .infinity).background(.ultraThinMaterial).background(BlurView())
			#elseif os(iOS)
				.background(
					.ultraThinMaterial
				)
				.background(Color.black, ignoresSafeAreaEdges: .all)
			#endif
		}
		#if os(macOS)
		Settings{
			SettingsView().frame(minWidth: 300,idealWidth: 450,maxWidth: 600,minHeight: 100,idealHeight: 100,maxHeight: 150).background(.ultraThinMaterial).background(BlurView())
		}
		.commands {
			CommandGroup(after:.appInfo) {
				Divider()
				LaunchAtLogin.Toggle {
					Text("Launch at login")
				}
			}
		/*	CommandGroup(replacing:.undoRedo) {
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
					Text("Go Back")
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
					Text("Go Forward")
				}
				.keyboardShortcut("ä", modifiers: .command)
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
					Text("Go Home")
				}
				.keyboardShortcut("ü", modifiers: .command)
				
					Button(action: reload) {
						Image(systemName: "arrow.clockwise.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
							.frame(width: 20)
						Text("Reload")
					}
				.keyboardShortcut("r", modifiers: .command)
			}*/
					
				
			}
		
		
		
		#endif
	}
}

class AppState: ObservableObject, Codable {
	public var minFactor: CGFloat = 0.5
	public var idealFactor: CGFloat = 0.75
	public var searchEngine: String = "https://duckduckgo.com/?q="
	public var selectedSE:String = "DuckDuckGo"
	public var cSEisSet: Bool = false
}
struct SettingsView: View {
	
	let searchEngines = ["Google", "Bing", "DuckDuckGo", "Yahoo", "Other"]
	let aColors = ["Blau", "Lila", "Rosa", "Rot", "Orange", "Gelb", "Grün", "Graphit"]
	
	@State private var selectedSE: String = "DuckDuckGo"
	@State private var cSE: String = ""
	
	init(){
		if let data = UserDefaults.standard.data(forKey: "Settings") {
			do {
				appState = try JSONDecoder().decode(AppState.self, from: data)
			} catch {
				print("Error decoding custom data: \(error)")
			}
		}
		
		selectedSE = appState.selectedSE
		if appState.cSEisSet {
			cSE = appState.searchEngine
		}
	}
	
	
	
	func formatSearchEngineString(for unformatted: String) -> String {
		let delimiter = "%s"
		let output = unformatted.lowercased().components(separatedBy: delimiter)
		return output[0]
	}
	
	
	
	func safeSE() {
		switch selectedSE {
			case "Google":
				appState.searchEngine = "https://www.google.com/search?q="
			case "Bing":
				appState.searchEngine = "https://www.bing.com/search?q="
			case "Yahoo":
				appState.searchEngine = "https://search.yahoo.com/search?p="
			case "Other":
				appState.cSEisSet = true
				appState.searchEngine = formatSearchEngineString(for: cSE)
			default:
				appState.searchEngine = "https://duckduckgo.com/?q="
		}
	}
	
	
	
	var body: some View {
		VStack {
			Form{
				
				Section(header: Text("Search Engine")) {
					Picker("Select Search Engine", selection: $selectedSE ) {
						ForEach(searchEngines, id: \.self) { engine in
							Text(engine)
						}
					}
					
					if selectedSE == "Other" {
						TextField("Suchurl mit dem Ende ?q=%s", text: $cSE, onCommit: safeSE)
							.textFieldStyle(PlainTextFieldStyle())
							.padding(.vertical, 8)
							.padding(.horizontal)
							.clipShape(Capsule())
							.background(Capsule().strokeBorder(Color.accentColor))
#if os(iOS)
							.autocapitalization(.none)
							.disableAutocorrection(true)
#endif
					}
					
					Button("Select Search Engine", action: {
						safeSE()
						appState.selectedSE = selectedSE
						do {
								// Encode and save the custom data to UserDefaults
							let data = try JSONEncoder().encode(appState)
							UserDefaults.standard.set(data, forKey: "Settings")
						} catch {
							print("Error encoding custom data: \(error)")
						}
							// Speichern der ausgewählten Suchmaschine
					})// Laden der ausgewählten Suchmaschine
				}
				
			}
#if os(iOS)
			.navigationBarTitle("Search Engine Settings")
#endif
		//
			
		}
	}
}

