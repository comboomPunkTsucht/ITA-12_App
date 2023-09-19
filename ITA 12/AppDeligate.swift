//
//  AppDeligate.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 15/08/2023.
//
#if os(macOS)
import Cocoa
import SwiftUI
//import Combine
//import LaunchAtLogin

class AppDeligate: NSObject, NSApplicationDelegate {
	var appState: AppState = AppState()
	var statusITem:NSStatusItem!
	let popover = NSPopover()
	var statusMenu: NSMenu!
	private let appName: String = "ITA 12"
	@State var contentView = AnyView(ContentView())
	//@State private var launchAtLogin = LaunchAtLogin.isEnabled
	

	
	
	
	@NSApplicationDelegateAdaptor private var appDelegate: AppDeligate
	@State private var screenWidth: CGFloat = 0.0
	@State private var screenHeight: CGFloat = 0.0
	
	@State private var popupWidth: CGFloat = 0.0
	@State private var popupHeight: CGFloat = 0.0
	
	private lazy var menubarIconView: NSView? = {
		let view = (statusITem.value(forKey: "window") as? NSWindow)?.contentView
		return view
	}()
	
	func applicationDidFinishLaunching(_ notification: Notification) {
		
		
			// Calculate initial screen width and height
		let initialScreenWidth = NSScreen.main?.frame.size.width ?? 1280
		let initialScreenHeight = NSScreen.main?.frame.size.height ?? 720
		
			// Initialize the state properties
		_screenWidth = State(initialValue: initialScreenWidth)
		_screenHeight = State(initialValue: initialScreenHeight)
		
			// Initialize minWidth and minHeight using the calculated values/
		_popupWidth = State(initialValue: (screenWidth * appState.idealFactor))
		_popupHeight = State(initialValue: (screenHeight * appState.idealFactor))
		
		setupMenuBar()
		setupPopover()
		startTimer()
		NotificationCenter.default.addObserver(self, selector: #selector(screenChanged), name: NSApplication.didChangeScreenParametersNotification, object: nil)

		/*
		 statusMenu = NSMenu(title: appName)
		 if let mainMenu = NSApp.mainMenu, mainMenu.items.count > 0 {
		 let firstItem = mainMenu.items[0]
		 mainMenu.setSubmenu(statusMenu, for: firstItem)
		 }
		 
		 let customMenuItem = NSMenuItem(title: "Toggle Launch at Login", action: #selector(toggleLaunchAtLogin), keyEquivalent: "")
		 statusMenu.addItem(customMenuItem)
		 
		 let separator = NSMenuItem.separator()
		 statusMenu.addItem(separator)
		 
		 let quitMenuItem = NSMenuItem(title: "Quit \(appName)", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
		 statusMenu.addItem(quitMenuItem)
		 NSApp.mainMenu!.addItem(NSMenuItem())*/
	}
}
extension AppDeligate {
	func setupMenuBar(){
		startTimer()
		//print("Hello v")
		statusITem = NSStatusBar.system.statusItem(withLength: 40)
		guard let menuButton = statusITem.button
		else { return }
		menuButton.title = "ITA 12"
		menuButton.action = #selector(menubarItemClicked)
	}
	
	@objc func menubarItemClicked() {
			// Call startTimer to update popup size
		startTimer()
		
		if popover.isShown {
			popover.performClose(nil)
			return
		}
		guard let menuButton = statusITem.button else { return }
		let positionView = NSView(frame: menuButton.bounds)
		positionView.identifier = NSUserInterfaceItemIdentifier("positionView")
		menuButton.addSubview(positionView)
		popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge(rawValue: UInt(NSStatusBar.system.thickness))!)
		menuButton.bounds = menuButton.bounds.offsetBy(dx: 0, dy: menuButton.bounds.height)
		popover.contentViewController?.view.window?.makeKey()
	}
	
	@objc func closeApp() {
		NSApplication.shared.terminate(self)
	}
	/*@objc func toggleLaunchAtLogin(){
		launchAtLogin.toggle()
	}*/
}
extension AppDeligate:NSPopoverDelegate {
	func setupPopover(){
		popover.behavior = .transient
		popover.animates = true
		popover.contentSize = .init(width: popupWidth, height: popupHeight)
		popover.contentViewController = NSViewController()
		popover.contentViewController?.view = NSHostingView(rootView: contentView.frame(width: popupWidth, height: popupHeight).background(.ultraThinMaterial).background(BlurView()))
		popover.delegate = self
		popover.hasFullSizeContent = true
	}
	func popoverDidClose(_ notification: Notification) {
		let positionView = statusITem.button?.subviews.first {
			$0.identifier == NSUserInterfaceItemIdentifier("positionView")
		}
		positionView?.removeFromSuperview()
	}
	@objc func screenChanged() {
			// Call startTimer to update popup size
		startTimer()
	}
	func startTimer() {
		Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
			let currentScreenWidth = NSScreen.main?.frame.size.width ?? 1280
			let currentScreenHeight = NSScreen.main?.frame.size.height ?? 720
			
				// Calculate popup dimensions based on factor
			let newPopupWidth = currentScreenWidth * self.appState.idealFactor
			let newPopupHeight = currentScreenHeight * self.appState.idealFactor
			
				// Update popup dimensions
			self._popupWidth = State(initialValue: newPopupWidth)
			self._popupHeight = State(initialValue: newPopupHeight)
		}
	}

}

#endif
