//
//  ContentView.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 08/08/2023.
//

import WebKit
import SwiftUI
import Foundation
#if os(macOS)
import Cocoa
#endif

var sideBarVisibility_Global: NavigationSplitViewVisibility = .doubleColumn
var selectedSideBarItem_Global: SideBarItem = .ClassSide
@available(macOS 14.0, *)
@available(iOS 17.0, *)
struct ContentView: View {
	#if os(macOS)
	
	@State var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
	@State var selectedSideBarItem: SideBarItem = .ClassSide
	// views
	@State var classSideView = AnyView(ClassSideView().padding(10).background(.ultraThinMaterial).background(BlurView()))
	/*@State var moodleView = AnyView(MoodleView().padding(10).background(.ultraThinMaterial).background(BlurView()))
	@State var timeTableView = AnyView( TimeTableView().padding(10).background(.ultraThinMaterial).background(BlurView()))
	@State var webUntisView = AnyView( WebUntisView().padding(10).background(.ultraThinMaterial).background(BlurView()))
	@State var oszimtView = AnyView( OSZimtView().padding(10).background(.ultraThinMaterial).background(BlurView()))*/
	@State var chatGPTView = AnyView( ChatGPTView().padding(10).background(.ultraThinMaterial).background(BlurView()))
	@State var discordView = AnyView(  DiscordView().padding(10).background(.ultraThinMaterial).background(BlurView()))
	@State var wwwView = AnyView( WWWView().padding(10).background(.ultraThinMaterial).background(BlurView()))
	@State var settingsView = AnyView(SettingsView().frame(maxWidth: .infinity,maxHeight: .infinity).padding(10).background(.ultraThinMaterial).background(BlurView()))
	
#endif
	#if os(iOS)
		// views
	@State var classSideView = AnyView(ClassSideView().padding(10).background(.ultraThinMaterial))
	/*@State var moodleView = AnyView(MoodleView().padding(10).background(.ultraThinMaterial))
	@State var timeTableView = AnyView( TimeTableView().padding(10).background(.ultraThinMaterial))
	@State var webUntisView = AnyView( WebUntisView().padding(10).background(.ultraThinMaterial))
	@State var oszimtView = AnyView( OSZimtView().padding(10).background(.ultraThinMaterial))*/
	@State var discordView = AnyView(  DiscordView().padding(10).background(.ultraThinMaterial))
	@State var wwwView = AnyView( WWWView().padding(10).background(.ultraThinMaterial))
	@State var settingsView = AnyView(SettingsView().padding(10).background(.ultraThinMaterial))
	#endif
	
	var body: some View {
		
#if os(iOS)
		TabView {
			self.classSideView
				.tabItem {
					Text("Klassen Webseite")
					Image(systemName: "doc.richtext")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20.0)
				}
				.navigationBarTitle("Klassen Webseite")
			
			/*self.moodleView
				.tabItem {
					Text("Moodle")
					Image(systemName: "studentdesk")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20.0)
				}
				.navigationBarTitle("Moodle")
			
			self.timeTableView
				.tabItem {
					Text("Stundenplan")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("Stundenplan")
			
			self.webUntisView
				.tabItem {
					Text("WebUntis")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("WebUntis")
			
			self.oszimtView
				.tabItem {
					Text("OSZ IMT Website")
					Image(systemName: "graduationcap.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("OSZ IMT Webseite")*/
			
			self.discordView
				.tabItem {
					Text("Discord")
					Image(systemName: "message.badge.circle.rtl")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("Discord")
			
			self.wwwView//.environment(\.managedObjectContext, viewContext)
				.tabItem {
					Text("Browse Web")
					Image(systemName: "globe")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("Web")
			self.settingsView
				.tabItem {
					Text("Settings")
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("Settings")

		}.onAppear{
			if let data = UserDefaults.standard.data(forKey: "Settings") {
				do {
					appState = try JSONDecoder().decode(AppState.self, from: data)
				} catch {
					print("Error decoding custom data: \(error)")
				}
			}
		}
		.edgesIgnoringSafeArea(.all)

		
#elseif os(macOS)
		
		NavigationSplitView(columnVisibility: $sideBarVisibility) {
			List(SideBarItem.allCases, selection: $selectedSideBarItem) { item in
				NavigationLink(destination: destinationView(for: item)) {
					Label(item.title, systemImage: item.systemImage)
				}
				
			}
			.frame(width: 190)
			.padding(.top,10)
			.padding(.bottom,10)
			.padding(.leading,10)
			.padding(.trailing,0)
			.background(.ultraThinMaterial)
			.listStyle(SidebarListStyle())
			.background(BlurView())
		} detail: {
			destinationView(for: selectedSideBarItem)
		}
		.background(.ultraThinMaterial)
		.background(BlurView())
		.onAppear {
			if selectedSideBarItem != .ClassSide {
				selectedSideBarItem = SideBarItem.allCases.first ?? .ClassSide
				
			}
			if let data = UserDefaults.standard.data(forKey: "Settings") {
				do {
					appState = try JSONDecoder().decode(AppState.self, from: data)
				} catch {
					print("Error decoding custom data: \(error)")
				}
		}
		}.navigationSplitViewStyle(.prominentDetail)
		
		/*	.commands {
				CommandMenu("CommandMenu") {
					Button("Go Back") {
						destinationView(for: selectedSideBarItem).actionHandler.goBackb(for:destinationView(for: selectedSideBarItem).webView)
					}
					.keyboardShortcut("ö", modifiers: .command)
					
					Button("Go Forword") {
						destinationView(for: selectedSideBarItem).actionHandler.goForwardb(for: destinationView(for: selectedSideBarItem).webView)
					}
					.keyboardShortcut("ä", modifiers: .command)
					
					Button("Go Home") {
						destinationView(for: selectedSideBarItem).actionHandler.goHomeb(for: destinationView(for: selectedSideBarItem).webView,startURL: destinationView(for: selectedSideBarItem).startURL)
					}
					.keyboardShortcut("ü", modifiers: .command)
					
					Button("Reload"){
						destinationView(for: selectedSideBarItem).actionHandler.reloadb(for: destinationView(for: selectedSideBarItem).webView)
					}
					.keyboardShortcut("r", modifiers: .command)
				}
			}*/
#endif
		
	}
	
	#if os(macOS)
		
	
	func destinationView(for item: SideBarItem) -> AnyView {
		switch item {
			case .ClassSide:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return classSideView
		/*	case .Moodle:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return moodleView
			case .TimeTable:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return timeTableView
			case .WebUntis:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return webUntisView
			case .OSZimt:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return oszimtView */
			case .ChatGPT:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return chatGPTView
			case .Discord:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return discordView
			case .WWW:
				sideBarVisibility_Global = sideBarVisibility
				selectedSideBarItem_Global = selectedSideBarItem
				return AnyView(wwwView)
				}
	}

	
	#endif
}



enum SideBarItem: String, Identifiable, CaseIterable {
	var id: String { rawValue }
	
	case ClassSide
/*	case Moodle
	case TimeTable
	case WebUntis
	case OSZimt */
	case ChatGPT
	case Discord
	case WWW
	
	var title: String {
		switch self {
			case .ClassSide: return "Klassen Webseite"
		/*	case .Moodle: return "Moodle"
			case .TimeTable: return "Stundenplan"
			case .WebUntis: return "WebUntis"
			case .OSZimt: return "OSZ IMT Webseite" */
			case .ChatGPT: return "ChatGPT"
			case .Discord: return "Discord"
			case .WWW: return "Browse Web"
		}
	}
	
	var systemImage: String {
		switch self {
			case .ClassSide: return "doc.richtext"
		/*	case .Moodle: return "studentdesk"
			case .TimeTable: return "info.circle"
			case .WebUntis: return "info.circle"
			case .OSZimt: return "graduationcap.circle"*/
			case .ChatGPT: return "message.circle"
			case .Discord: return "message.badge.circle.rtl"
			case .WWW: return "globe"
		}
	}
}
#if os(macOS)
struct BlurView: NSViewRepresentable {
	func makeNSView(context: Context) -> NSVisualEffectView {
		let view = NSVisualEffectView()
		view.blendingMode = .behindWindow
		
		return view
	}
	func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
		
	}
}

#endif

#if os(iOS)
struct CustomWebView: UIViewRepresentable {
	var webView: WKWebView
	let request: URLRequest
	@Binding var searchText: String
	let webViewConfiguration = WKWebViewConfiguration()
	
	
	class Coordinator: NSObject, WKNavigationDelegate {
		let parent: CustomWebView
		
		init(_ parent: CustomWebView) {
			self.parent = parent
		}
		
		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
				// Aktualisieren Sie hier das Textfeld mit der tatsächlich geladenen URL
			if let url = webView.url {
				if url.absoluteString.hasPrefix("https://ita12docoszimt.serveblog.net/") {
					parent.searchText = ""
				} else {
					parent.searchText = url.absoluteString
				}
			}
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	
	func makeUIView(context: Context) -> WKWebView {
			// Importieren von Cookies aus Safari
		WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
			for cookie in cookies {
				webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
			}
		}
		
		webView.navigationDelegate = context.coordinator
		webView.load(request)
		return webView
	}
	
	func updateUIView(_ uiView: WKWebView, context: Context) {}
}
#elseif os(macOS)
struct CustomWebView: NSViewRepresentable {
	
	var webView: WKWebView
	let request: URLRequest
	@Binding var searchText: String
	let webViewConfiguration = WKWebViewConfiguration()
	
	class Coordinator: NSObject, WKNavigationDelegate {
		let parent: CustomWebView
		
		init(_ parent: CustomWebView) {
			self.parent = parent
		}
		
		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
				// Update the text field with the actually loaded URL here
			if let url = webView.url {
				if url.absoluteString.hasPrefix("https://ita12docoszimt.serveblog.net/") {
					parent.searchText = ""
				} else if url.absoluteString.hasPrefix("https://www.youtube.com/watch?v=o-YBDTqX_ZU") {
					parent.searchText = ""

				} else {
					parent.searchText = url.absoluteString
				}
			}
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeNSView(context: Context) -> WKWebView {
			// Import cookies from Safari
		WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
			for cookie in cookies {
				webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
			}
		}
		
		webView.navigationDelegate = context.coordinator
		webView.load(request)
		return webView
	}
	
	func updateNSView(_ nsView: WKWebView, context: Context) {}
}
#endif
// Webview definition
 let webViewConfiguration: WKWebViewConfiguration = {
	let configuration = WKWebViewConfiguration()
#if os(iOS)
	 configuration.allowsInlineMediaPlayback = true
	 configuration.allowsPictureInPictureMediaPlayback = true
#endif
	return configuration
}()

#if os(macOS)
var webView = WKWebView(frame: .zero, configuration:webViewConfiguration)

#endif
//--------


struct ClassSideView: View {
		// Konfigurieren der WKWebViewConfiguration-Instanz
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
	let startURL = URL(string: "https://ita12docoszimt.serveblog.net/")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText);
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
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
		webView.load(URLRequest(url: startURL))
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
}
struct MoodleView: View {
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
		// Konfigurieren der WKWebViewConfiguration-Instanz
	let startURL = URL(string: "https://moodle.oszimt.de/my/")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
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
		webView.load(URLRequest(url: startURL))
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
}

struct TimeTableView: View {
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
		// Konfigurieren der WKWebViewConfiguration-Instanz
	let startURL = URL(string: "https://mese.webuntis.com/WebUntis/monitor?school=OSZ%20IMT&simple=2&type=1&monitorType=tt&name=ITA%2012")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
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
		webView.load(URLRequest(url: startURL))
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
}

struct OSZimtView: View {
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
		// Konfigurieren der WKWebViewConfiguration-Instanz
	let startURL = URL(string: "https://oszimt.de")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""

	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
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
		webView.load(URLRequest(url: startURL))
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
}

struct ChatGPTView: View {
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
	let startURL = URL(string: "https://chat.openai.com/")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
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
		webView.load(URLRequest(url: startURL))
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
}



struct WWWView: View {
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
	let startURL = URL(string: "https://ita12docoszimt.serveblog.net/")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				
				TextField("Suche", text: $searchText, onCommit: search)
					.textFieldStyle(PlainTextFieldStyle())
					.padding(.vertical, 8)
					.padding(.horizontal)
					.clipShape(Capsule())
					.background(Capsule().strokeBorder(Color.accentColor))
#if os(iOS)
					.autocapitalization(.none)
					.disableAutocorrection(true)
					.keyboardType(.webSearch)
#endif
				Button(action: search) {
					Image(systemName: "magnifyingglass.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut(.defaultAction)
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
		
		
		
	}
	func search() {
			// Check if the search text starts with "!yt:"
		if searchText.hasPrefix("!yt ") {
				// Extract the search query
			let searchQuery = searchText.replacingOccurrences(of: "!yt ", with: "")
				// Check if the search query is a video ID
			if searchQuery.count == 11 && searchQuery.range(of: #"[^0-9a-zA-Z_-]"#, options: .regularExpression) == nil {
					// Create the YouTube video URL
				if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(searchQuery)") {
						// Load the YouTube video URL in the web view
					webView.load(URLRequest(url: youtubeURL))
				}
			} else {
					// Create the YouTube search URL
				if let encodedSearchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
				   let youtubeURL = URL(string: "https://www.youtube.com/results?search_query=\(encodedSearchQuery)") {
						// Load the YouTube search URL in the web view
					webView.load(URLRequest(url: youtubeURL))
				}
			}
		} else {
				// Check if the search bar is empty (including whitespace)
			if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
					// The search bar is empty
					// Perform an action here if the search bar is empty
					// For example:
				print("The search bar is empty")
			} else {
					// Check if the search text has an HTTP/HTTPS protocol
				if let urlWithProtocol = addProtocolToURL(searchText), urlWithProtocol.absoluteString.lowercased().hasPrefix("http://") || urlWithProtocol.absoluteString.lowercased().hasPrefix("https://") {
						// If the search text matches a URL, add the protocol and load the URL
					webView.load(URLRequest(url: urlWithProtocol))
				} else {
						// Perform a Bing search
					if let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
					   let url = URL(string: "\(appState.searchEngine)\(encodedSearchText)") {
						webView.load(URLRequest(url: url))
						
					}
				}
			}
		}
		
	}
	
	
	func addProtocolToURL(_ urlString: String) -> URL? {
		if let url = URL(string: urlString), url.scheme != nil {
			return url
		} else if urlString.range(of: "^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+\\..+$", options: .regularExpression) != nil,
				  let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
				  let urlWithProtocol = URL(string: "https://" + encodedURLString) {
			return urlWithProtocol
		}
		return nil
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
		webView.load(URLRequest(url: startURL))
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
}

struct WebUntisView: View {
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
	let startURL = URL(string: "https://mese.webuntis.com/WebUntis/?school=OSZ+IMT#/basic/login")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
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
		webView.load(URLRequest(url: startURL))
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
}

struct DiscordView: View {
#if os(iOS)
	@State var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
#endif
	let startURL = URL(string: "https://ptb.discord.com/login")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Button(action: rickrol) {
					Image(systemName: "gear")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: [.command,.shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
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
		webView.load(URLRequest(url: startURL))
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
}

#Preview {
	ContentView()
}
