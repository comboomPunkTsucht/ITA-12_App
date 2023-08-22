//
//  ITA_12App.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 08/08/2023.
//

import SwiftUI
import CoreData
#if os(macOS)
import LaunchAtLogin
#endif

@main
struct ITA_12App: App {
	
	//let persistenceController = PersistenceController.shared
	
	#if os(macOS)
	@State private var appState: AppState = AppState()
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
#endif

	
	var body: some Scene {
		WindowGroup {

			ContentView()
				//.environment(\.managedObjectContext, persistenceController.container.viewContext)

#if os(macOS)
				.frame(minWidth: minWidth,idealWidth: idealWidth,maxWidth: .infinity,minHeight: minHeight,idealHeight: idealHeight,maxHeight: .infinity).background(.ultraThinMaterial).background(BlurView())
			
			#endif
		}
		#if os(macOS)
		.commands {
			CommandGroup(after:.appInfo) {
				Divider()
				LaunchAtLogin.Toggle {
					Text("Launch at login")
				}
			}
				
					
				
			}
		
		
		#endif
	}
}


#if os(macOS)
class AppState: ObservableObject {
	public var minFactor: CGFloat = 0.5
	public var idealFactor: CGFloat = 0.75
	
}

/*

struct SettingsView: View {
	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \SearchEngineSettings.selectedSearchEngine, ascending: true)],
		animation: .default)
	private var searchEngineSettings: FetchedResults<SearchEngineSettings>
	@State private var selectedEngines: Set<String> = []
	@State private var customEngine: String = ""
	
	let availableEngines: [String: String] = [
		"Google": "https://www.google.com/search?q=%s",
		"Bing": "https://www.bing.com/search?q=%s",
		"DuckDuckGo": "https://duckduckgo.com/?q=%s",
		"Other" : ""
	]
	
	var body: some View {
		Form {
			Section(header: Text("Select Search Engines")) {
				ForEach(availableEngines.keys.sorted(), id: \.self) { engineName in
					Toggle(engineName, isOn: Binding(
						get: { selectedEngines.contains(engineName) },
						set: { isSelected in
							if isSelected {
								selectedEngines.insert(engineName)
							} else {
								selectedEngines.remove(engineName)
							}
						}
					))
				}
			}
			
			Section(header: Text("Custom Search Engine")) {
				TextField("Enter a custom search engine", text: $customEngine)
			}
			
			Section {
				Button("Select") {
					if let selectedEngine = selectedEngines.first {
						let searchEngineSettings = SearchEngineSettings(context: viewContext)
						searchEngineSettings.selectedSearchEngine = formatSearchEngineString(for: selectedEngine)
						
							// Save the custom search engine as well
						if let  selectedEngineC = selectedEngine.last {
							searchEngineSettings.selectedSearchEngine = customEngine
						}
						
						do {
							try viewContext.save()
						} catch {
							let nsError = error as NSError
							fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
						}
					}
				}
			}
		}
#if os(iOS)
		.navigationBarTitle("Search Engine Selection")
#endif
	}
	
	func formatSearchEngineString(for unformatted: String) -> String {
		let delimiter = "%s"
		let output = unformatted.lowercased().components(separatedBy: delimiter)
		return output[0]
	}
 
}*/#endif
