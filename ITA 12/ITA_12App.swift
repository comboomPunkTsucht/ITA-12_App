//
//  ITA_12App.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 08/08/2023.
//

import SwiftUI

@main
struct ITA_12App: App {
	
	#if os(macOS)
	@NSApplicationDelegateAdaptor(AppDeligate.self) private var appDeligate
	#endif
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
