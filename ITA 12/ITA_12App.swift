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
			#if os(macOS)
				.frame(minWidth: minWidth,idealWidth: idealWidth,maxWidth: .infinity,minHeight: minHeight,idealHeight: idealHeight,maxHeight: .infinity).background(.ultraThinMaterial).background(BlurView())
			#elseif os(iOS)
				.background(
					.ultraThinMaterial
				)
				.background(
					Color.black
				)
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

