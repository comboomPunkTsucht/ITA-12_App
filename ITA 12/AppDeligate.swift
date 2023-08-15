//
//  AppDeligate.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 15/08/2023.
//
#if os(macOS)
import Cocoa
import SwiftUI

class AppDeligate: NSObject, NSApplicationDelegate {
	var statusITem:NSStatusItem!
	let popover = NSPopover()
	
	private lazy var menubarIconView: NSView? = {
		let view = (statusITem.value(forKey: "window") as? NSWindow)?.contentView
		return view
	}()
	
	func applicationDidFinishLaunching(_ notification: Notification) {
		setupMenuBar()
		setupPopover()
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
}
extension AppDeligate:NSPopoverDelegate {
	func setupPopover(){
		popover.behavior = .transient
		popover.animates = true
		popover.contentSize = .init(width: 1280, height: 720)
		popover.contentViewController = NSViewController()
		popover.contentViewController?.view = NSHostingView(rootView: ContentView().padding())
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
