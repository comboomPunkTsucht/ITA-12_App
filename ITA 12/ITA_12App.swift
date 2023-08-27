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

@main
struct ITA_12App: App {
	
	#if os(macOS)
	@NSApplicationDelegateAdaptor(AppDeligate.self) private var appDeligate
	var appState: AppState = AppState()
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
#elseif os(iOS)
				.background(
					Color.black
				)
#endif
		}

		#if os(macOS)
		Settings{
			SettingsView().frame(minWidth: 300,idealWidth: 450,maxWidth: 600,minHeight: 100,idealHeight: 100,maxHeight: 150).background(.ultraThinMaterial)
				.background(BlurView())
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
	public var minFactor: CGFloat
	public var idealFactor: CGFloat
	
	init() {
		minFactor = 0.5
		idealFactor = 0.75
	}
}
struct SettingsView: View {
	@AppStorage("ITA 12_searchEngine") var searchEngine: String?
	
	let searchEngines = ["Google", "Bing", "DuckDuckGo", "Yahoo", "Other"]
	
	@AppStorage("ITA 12_selectedSE") var selectedSEIndex: Int = 2  // Default to "DuckDuckGo" (index 2)
	@AppStorage("ITA 12_cSE") var cSE: String?
	@AppStorage("ITA 12_cSEisSet") var cSEisSet: Bool?
	
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
							.background(Capsule().strokeBorder(Color.accentColor))
#if os(iOS)
							.autocapitalization(.none)
							.disableAutocorrection(true)
#endif
					}
					
					Button("Save Search Engine", action: {
						safeSE()
					})
				}
			}
			
#if os(iOS)
			.navigationBarTitle("Search Engine Settings")
#endif
		}
	}
}


