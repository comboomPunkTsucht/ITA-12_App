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
		print("Hello v")
		statusITem = NSStatusBar.system.statusItem(withLength: 64)
		guard /*let contentView = self.menubarIconView,*/
			  let menuButton = statusITem.button
		else { return }
		/*
		let hostingView = NSHostingView(rootView: MenubarIconView())
		
		hostingView.translatesAutoresizingMaskIntoConstraints = false
		
		menubarIconView?.addSubview(hostingView)
		
		NSLayoutConstraint.activate([
			hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
			hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
		])
		*/
		menuButton.title = "ITA 12"
		menuButton.action = #selector(menubarItemClicked)
	}
	
	@objc func menubarItemClicked(){
		if popover.isShown {
			popover.performClose(nil)
			return
		}
		guard let menuButton = statusITem.button else { return }
		popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
		popover.contentViewController?.view.window?.makeKey()
	}
}
extension AppDeligate {
	func setupPopover(){
		popover.behavior = .transient
		popover.animates = true
		popover.contentSize = .init(width: 1280, height: 720)
		popover.contentViewController = NSViewController()
		popover.contentViewController?.view = NSHostingView(rootView: PopouverHelpView().frame(minWidth: 1280,idealWidth: 1920, maxWidth: 7680, minHeight: 720, idealHeight: 1080, maxHeight: 4320).padding())
	}
}

#endif
