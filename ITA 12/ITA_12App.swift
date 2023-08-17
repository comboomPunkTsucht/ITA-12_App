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
	@NSApplicationDelegateAdaptor(AppDeligate.self) private var appDeligate
	private let minWidth: CGFloat = 1920 * 0.88
	private let minHeight: CGFloat = 1080 * 0.88
	
	@State private var screenWidth: CGFloat
	@State private var screenHeight: CGFloat
	
	init() {
		let initialScreenWidth = NSScreen.main?.frame.size.width ?? minWidth
		let initialScreenHeight = NSScreen.main?.frame.size.height ?? minHeight
		
		_screenWidth = State(initialValue: initialScreenWidth)
		_screenHeight = State(initialValue: initialScreenHeight)
	}
	
	private func calculateIdealWidth() -> CGFloat {
		return max(screenWidth / 2, minWidth)
	}
	
	private func calculateIdealHeight() -> CGFloat {
		return max(screenHeight / 2, minHeight)
	}
#endif
	
	var body: some Scene {
		WindowGroup {
			ContentView()
#if os(macOS)
				.frame(
					minWidth: minWidth,
					idealWidth: calculateIdealWidth(),
					maxWidth: .infinity,
					minHeight: minHeight,
					idealHeight: calculateIdealHeight(),
					maxHeight: .infinity
				)
			
				.padding(.bottom)
				.padding(.trailing)
				.padding(.top)
				.background(BlurView())
			#endif
		}
	}
}

																																																																						
																																																																						
																																																																						
																																																																						
