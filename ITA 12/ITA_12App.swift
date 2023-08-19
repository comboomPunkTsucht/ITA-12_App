//
//  ITA_12App.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 08/08/2023.
//

import SwiftUI
import SwiftData

@main
struct ITA_12App: App {
	
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
#if os(macOS)
				.frame(minWidth: minWidth,idealWidth: idealWidth,maxWidth: .infinity,minHeight: minHeight,idealHeight: idealHeight,maxHeight: .infinity).background(BlurView())
			
			#endif
		}
	}
}


#if os(macOS)
class AppState: ObservableObject {
	public var minFactor: CGFloat = 0.5
	public var idealFactor: CGFloat = 0.75
	
}
#endif
