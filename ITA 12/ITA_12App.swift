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
	
	
	func getCurrentView(for item: SideBarItem) -> URL {
		switch item {
			/*case .Moodle:
				return URL(string: "https://moodle.oszimt.de/my/")!
			case .TimeTable:
				return URL(string: "https://mese.webuntis.com/WebUntis/monitor?school=OSZ%20IMT&simple=2&type=1&monitorType=tt&name=ITA%2012")!
			case .WebUntis:
				return URL(string: "https://mese.webuntis.com/WebUntis/?school=OSZ+IMT#/basic/login")!
			case .OSZimt:
				return URL(string: "https://chat.openai.com/")!*/
			case .ChatGPT:
				return URL(string: "https://www.oszimt.de/")!
			case .Discord:
				return URL(string: "https://ptb.discord.com/login")!
			default:
				return URL(string: "https://ita12docoszimt.serveblog.net/")!
		}
	}
	
	func goBack() {
		webView.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webView.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webView.load(URLRequest(url: getCurrentView(for: selectedSideBarItem_Global)))
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webView.load(URLRequest(url: rickrollURL))
	}
	
	func reload() {
			// Implement reload logic
		webView.reload()
	}
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
#endif

	
	var body: some Scene {
		WindowGroup {

			ContentView()

#if os(macOS)
				.frame(minWidth: minWidth,idealWidth: idealWidth,maxWidth: .infinity,minHeight: minHeight,idealHeight: idealHeight,maxHeight: .infinity).background(.ultraThinMaterial).background(BlurView())
			
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
			CommandGroup(replacing:.undoRedo) {
				Button("Go Back", action: goBack)
				.keyboardShortcut("ö", modifiers: .command)
				
				Button("Go Forword", action: goForward)
				.keyboardShortcut("ä", modifiers: .command)
				
				Button("Go Home", action: goHome)
				.keyboardShortcut("ü", modifiers: .command)
				
				Button("Reload", action: reload)
				.keyboardShortcut("r", modifiers: .command)
			}
					
				
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

