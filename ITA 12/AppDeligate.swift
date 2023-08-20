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
	var statusITem:NSStatusItem!
	let popover = NSPopover()
	var statusMenu: NSMenu!
	private let appName: String = "ITA 12"
	@State private var appState: AppState = AppState()
	@State var contentView = AnyView(ContentView())
	//@State private var launchAtLogin = LaunchAtLogin.isEnabled
	

	
	
	
	@NSApplicationDelegateAdaptor private var appDelegate: AppDeligate
	@State private var screenWidth: CGFloat = 0.0
	@State private var screenHeight: CGFloat = 0.0
	
	private var popupWidth: CGFloat = 0.0
	private var popupHeight: CGFloat = 0.0
	
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
		popupWidth = screenWidth * appState.idealFactor
		popupHeight = screenHeight * appState.idealFactor

		setupMenuBar()
		setupPopover()
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
		//print("Hello v")
		statusITem = NSStatusBar.system.statusItem(withLength: 40)
		guard let menuButton = statusITem.button
		else { return }
		menuButton.title = "ITA 12"
		menuButton.action = #selector(menubarItemClicked)
	}
	
	@objc func menubarItemClicked(){
		if popover.isShown {
			popover.performClose(nil)
			return
		}
		guard let menuButton = statusITem.button else { return }
		let positionView = NSView(frame: menuButton.bounds)
		positionView.identifier = NSUserInterfaceItemIdentifier("positionView")
		menuButton.addSubview(positionView)
		popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
		menuButton.bounds = menuButton.bounds.offsetBy(dx: 0, dy: menuButton.bounds.height)
		popover.contentViewController?.view.window?.makeKey()
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
	}
	func popoverDidClose(_ notification: Notification) {
		let positionView = statusITem.button?.subviews.first {
			$0.identifier == NSUserInterfaceItemIdentifier("positionView")
		}
		positionView?.removeFromSuperview()
	}
}

#endif
