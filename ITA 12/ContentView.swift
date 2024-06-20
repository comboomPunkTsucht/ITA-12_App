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

#if os(macOS)
let sideBarVisibility_Global: NavigationSplitViewVisibility = .doubleColumn
#elseif os(iOS)
let sideBarVisibility_Global: NavigationSplitViewVisibility = .doubleColumn
#endif

struct ContentView: View {
#if os(macOS)
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		//@Environment(\.managedObjectContext) private var viewContext
		// views
	@State var classSideView = AnyView(
		ClassSideView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var moodleView = AnyView(
		MoodleView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var timeTableView = AnyView(
		TimeTableView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var webUntisView = AnyView(
		WebUntisView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var oszimtView = AnyView(
		OSZimtView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var chatGPTView = AnyView(
		ChatGPTView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var discordView = AnyView(
		DiscordView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var wwwView = AnyView(
		WWWView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	@State var settingsView = AnyView(
		SettingsView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
		
	)
	
	@State var homeWorkView = AnyView(
		HomeworkView().padding(
			10
		).background(
			.ultraThinMaterial
		).background(
			BlurView()
		)
	)
	
	
	
#elseif os(iOS)
	
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		//@Environment(\.managedObjectContext) private var viewContext
		// views
	@State var classSideView = AnyView(
		ClassSideView().background(
			Color.black).navigationTitle("Klassen Webseite")
		
	)
	@State var moodleView = AnyView(
		MoodleView()
			.background(
				Color.black)
			.background(
				.ultraThinMaterial).navigationTitle("Moodle")
		
	)
	@State var timeTableView = AnyView(
		TimeTableView().background(
			Color.black).navigationTitle("Stundenplan")
		
	)
	@State var webUntisView = AnyView(
		WebUntisView().background(
			Color.black).navigationTitle("WebUntis")
		
	)
	@State var oszimtView = AnyView(
		OSZimtView().background(
			Color.black).navigationTitle("OSZ IMT Webseite")
		
	)
	@State var discordView = AnyView(
		DiscordView().background(
			Color.black).navigationTitle("Discord")
		
	)
	@State var wwwView = AnyView(
		WWWView().background(
			Color.black).navigationTitle("Web")
		
	)
	@State var settingsView = AnyView(
		SettingsView().background(
			Color.black).navigationTitle("Settings")
		
	)
	@State var homeWorkView = AnyView(
		HomeworkView().background(
			Color.black).navigationTitle(
				"All Homework"
			)
		)
	
	
#elseif os(visionOS)
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		//@Environment(\.managedObjectContext) private var viewContext
	@State var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
	
		// views
	@State var classSideView = AnyView(
		ClassSideView().background(
			.ultraThinMaterial
		).navigationTitle("Klassen Webseite")
		
	)
	@State var moodleView = AnyView(
		MoodleView()
			.background(
				.ultraThinMaterial
			).navigationTitle("Moodle")
		
	)
	@State var timeTableView = AnyView(
		TimeTableView().background(
			.ultraThinMaterial
		).navigationTitle("Stundenplan")
		
	)
	@State var webUntisView = AnyView(
		WebUntisView().background(
			.ultraThinMaterial
		).navigationTitle("WebUntis")
		
	)
	@State var oszimtView = AnyView(
		OSZimtView().background(
			.ultraThinMaterial
		).navigationTitle("OSZ IMT Webseite")
		
	)
	@State var discordView = AnyView(
		DiscordView().background(
			.ultraThinMaterial
		).navigationTitle("Discord")
		
	)
	@State var wwwView = AnyView(
		WWWView().background(
			.ultraThinMaterial
		).navigationTitle("Web")
		
	)
	@State var settingsView = AnyView(
		SettingsView().background(
			.ultraThinMaterial
		).navigationTitle("Settings")
		
	)
	
	@State var homeWorkView = AnyView(
		HomeworkView().background(
			.ultraThinMaterial
		).navigationTitle("All Homework")
	)
	
#endif
	
	var body: some View {
		TabView {
			self.classSideView
				.tabItem {
					Text(
						"Klassen Webseite"
					)
					Image(
						systemName: "doc.richtext"
					)
					.resizable()
					.aspectRatio(
						contentMode: .fit
					)
					.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
					.frame(
						width: 20.0
					)
				}
			#if !os(macOS)
				.navigationBarTitle(
					"Klassen Webseite"
				)
			#endif
			
			self.moodleView
				.tabItem {
					Text("Moodle")
					Image(systemName: "studentdesk")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20.0)
				}
			#if !os(macOS)
				.navigationBarTitle("Moodle")
			#endif
			self.timeTableView
				.tabItem {
					Text("Stundenplan")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
			#if !os(macOS)
				.navigationBarTitle("Stundenplan")
			#endif
			self.webUntisView
				.tabItem {
					Text("WebUntis")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
			#if !os(macOS)
				.navigationBarTitle("WebUntis")
			#endif
			self.oszimtView
				.tabItem {
					Text("OSZ IMT Webseite")
					Image(systemName: "graduationcap.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
			#if !os(macOS)
				.navigationBarTitle("OSZ IMT Webseite")
			#endif
			#if os(macOS)
			self.chatGPTView
				.tabItem {
					Text("ChatGPT")
					Image(systemName: "message.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
			#endif
			self.discordView
				.tabItem {
					Text(
						"Discord"
					)
					Image(
						systemName: "message.badge.circle.rtl"
					)
					.resizable()
					.aspectRatio(
						contentMode: .fit
					)
					.foregroundColor(
						Color.accentColor
					)
					.frame(
						width: 20
					)
				}
			#if !os(macOS)
				.navigationBarTitle(
					"Discord"
				)
			#endif
			
			self.wwwView
				.tabItem {
					Text(
						"Browse Web"
					)
					Image(
						systemName: "globe"
					)
					.resizable()
					.aspectRatio(
						contentMode: .fit
					)
					.foregroundColor(
						Color.accentColor
					)
					.frame(
						width: 20
					)
				}
			#if !os(macOS)
				.navigationBarTitle(
					"Web"
				)
			#endif

			self.settingsView
#if os(macOS)
				.frame(width:(NSScreen.main?.visibleFrame.width ?? 1280)/2, height:.infinity, alignment: .center)
#endif
				.tabItem {
					Text(
						"Settings"
					)
					Image(
						systemName: "gear"
					)
					.resizable()
					.aspectRatio(
						contentMode: .fit
					)
					.foregroundColor(
						Color.accentColor
					)
					.frame(
						width: 20
					)
				}
#if !os(macOS)
				.navigationBarTitle(
					"Settings"
				)
#endif

			self.homeWorkView
				.tabItem {
					Text(
						"All Homework"
					)
					Image(
						systemName: "doc.text.image"
					)
					.resizable()
					.aspectRatio(
						contentMode: .fit
					)
					.foregroundColor(
						Color.accentColor
					)
					.frame(
						width: 20
					)
				}
#if !os(macOS)
				.navigationBarTitle(
					"All Homework"
				)
			#endif
		}.tabViewStyle(.sidebarAdaptable)
#if os(macOS)
			.background(.ultraThinMaterial)
			.background(BlurView())
			.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
			.toolbar(removing: .title)
		#elseif os(visionOS)
			.background(.ultraThinMaterial)
		#endif
}
}


#if os(macOS)
struct BlurView: NSViewRepresentable {
	func makeNSView(
		context: Context
	) -> NSVisualEffectView {
		let view = NSVisualEffectView()
		view.blendingMode = .behindWindow
		
		return view
	}
	func updateNSView(
		_ nsView: NSVisualEffectView,
		context: Context
	) {
		
	}
}

#endif




#if os(iOS) || os(visionOS)

protocol CustomWebViewParent: AnyObject {
	var searchText: String { get set }
}
class CustomWebViewState: CustomWebViewParent {
	@Published var searchText: String
	
	init(searchText: String) {
		self.searchText = searchText
	}
}

struct CustomWebView: UIViewRepresentable {
	var webView: WKWebView
	let request: URLRequest
	@Binding var searchText: String
	let webViewConfiguration = WKWebViewConfiguration()
	var state: CustomWebViewState
	
	class Coordinator: NSObject, WKNavigationDelegate, @unchecked Sendable {
		unowned let parent: CustomWebViewParent
		
		init(_ parent: CustomWebViewParent) {
			self.parent = parent
		}
		
		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
				// Ensure URL and searchText are updated on the main actor
			Task { @MainActor in
				if let url = webView.url {
					if url.absoluteString.hasPrefix("https://ita12.comboompunksucht.app/") {
						parent.searchText = ""
					} else if url.absoluteString.hasPrefix("https://www.youtube.com/watch?v=o-YBDTqX_ZU") {
						parent.searchText = ""
					} else {
						parent.searchText = url.absoluteString
					}
				}
			}
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(
			
			self.state
		)
	}
	
	
	func makeUIView(
		context: Context
	) -> WKWebView {
			// Importieren von Cookies aus Safari
		WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
			for cookie in cookies {
				webView.configuration.websiteDataStore.httpCookieStore.setCookie(
					cookie
				)
			}
		}
		
		webView.navigationDelegate = context.coordinator
		webView.load(
			request
		)
		return webView
	}
	
	func updateUIView(
		_ uiView: WKWebView,
		context: Context
	) {
	}
}
#elseif os(macOS)

protocol CustomWebViewParent: AnyObject {
	var searchText: String { get set }
}
class CustomWebViewState: CustomWebViewParent {
	@Published var searchText: String
	
	init(searchText: String) {
		self.searchText = searchText
	}
}

struct CustomWebView: NSViewRepresentable {
	
	var webView: WKWebView
	let request: URLRequest
	@Binding var searchText: String
	let webViewConfiguration = WKWebViewConfiguration()
	var state: CustomWebViewState
	
	class Coordinator: NSObject, WKNavigationDelegate, @unchecked Sendable {
		unowned let parent: CustomWebViewParent
		
		init(_ parent: CustomWebViewParent) {
			self.parent = parent
		}
		
		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
				// Ensure URL and searchText are updated on the main actor
			Task { @MainActor in
				if let url = webView.url {
					if url.absoluteString.hasPrefix("https://ita12.comboompunksucht.app/") {
						parent.searchText = ""
					} else if url.absoluteString.hasPrefix("https://www.youtube.com/watch?v=o-YBDTqX_ZU") {
						parent.searchText = ""
					} else {
						parent.searchText = url.absoluteString
					}
				}
			}
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(
			
			self.state
		)
	}

	
	func makeNSView(
		context: Context
	) -> WKWebView {
			// Import cookies from Safari
		WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
			for cookie in cookies {
				webView.configuration.websiteDataStore.httpCookieStore.setCookie(
					cookie
				)
			}
		}
		
		webView.navigationDelegate = context.coordinator
		webView.load(
			request
		)
		return webView
	}
	
	func updateNSView(
		_ nsView: WKWebView,
		context: Context
	) {
	}
}
#endif

struct ClassSideView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://ita12.comboompunksucht.app")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText));
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("ö", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("ä", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("ü", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
}
struct MoodleView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://moodle.oszimt.de/")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText))
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("<", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(">", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(".", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
}

struct TimeTableView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://mese.webuntis.com/WebUntis/monitor?school=OSZ%20IMT&simple=2&type=1&monitorType=tt&name=ITA%2012")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText))
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("<", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(">", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(".", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
}

struct OSZimtView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://oszimt.de")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText))
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("<", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(">", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(".", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
}

struct ChatGPTView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
	
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://chat.openai.com/")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText))
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("<", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(">", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(".", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	
	
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
}

class WebViewManager: ObservableObject {
	@Published var webView: WKWebView
	@AppStorage("ITA 12_searchEngine") var searchEngine: String?
	
	@MainActor init(for configuration: WKWebViewConfiguration) {
		self.webView = WKWebView(frame: .zero, configuration: configuration)
	}
	
	@MainActor func search(for searchText: String) {
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
				if let urlWithProtocol = addProtocolToURL(searchText),
				   urlWithProtocol.absoluteString.lowercased().hasPrefix("http://") || urlWithProtocol.absoluteString.lowercased().hasPrefix("https://") {
						// If the search text matches a URL, add the protocol and load the URL
					webView.load(URLRequest(url: urlWithProtocol))
				} else {
						// Perform a search using the specified search engine or DuckDuckGo as a fallback
					if let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
						let searchURLString = "\(searchEngine ?? "https://duckduckgo.com/?q=")\(encodedSearchText)"
						if let url = URL(string: searchURLString) {
							webView.load(URLRequest(url: url))
						}
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
	
	@MainActor func goBack() {
		webView.goBack()
	}
	@MainActor func goForward() {
			// Implement go forward logic
		webView.goForward()
	}
	
	@MainActor func goHome(for startURL: URL) {
			// Implement go home logic
		webView.load(URLRequest(url: startURL))
	}
	@MainActor func rickrol(for rickrollURL: URL) {
		print("rickrol")
			// Implement go home logic
		webView.load(URLRequest(url: rickrollURL))
	}
	
	@MainActor func reload() {
			// Implement reload logic
		webView.reload()
	}
	
		// Add functions and properties related to WKWebView functionality
		// For example: loading URLs, going back/forward, reloading, etc.
}

struct WWWView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
	
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://ita12.comboompunksucht.app")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	private var isSearchEmpty: Bool {
		searchText.isEmpty
	}
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText))
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				
				HStack{
					TextField("Suche", text: $searchText, onCommit: search)
						.textFieldStyle(PlainTextFieldStyle())
#if os(iOS) || os(visionOS)
						.autocapitalization(.none)
						.disableAutocorrection(true)
						.keyboardType(.webSearch)
#endif
					Button(action: search) {
						Image(systemName: "magnifyingglass")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
							.frame(width: 20)
					}
					.buttonStyle(PlainButtonStyle())
					.disabled(isSearchEmpty)
					.keyboardShortcut(.defaultAction)
					
				}
				.frame(height: 14)
				.padding(.vertical, 8)
				.padding(.horizontal)
				.clipShape(Capsule())
				.background(Capsule().strokeBorder(colorisSet ?? false ? Color(colorString!): .accentColor))
				
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("<", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(">", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(".", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}

	func search() {
		webViewManager.search(for: searchText)
	}
	
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
	
}

struct WebUntisView: View {
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://mese.webuntis.com/WebUntis/?school=OSZ+IMT#/basic/login")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText))
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("<", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(">", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(".", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
}

struct DiscordView: View {
	
	@AppStorage("ITA 12_colorString") var colorString: String?
	@AppStorage("ITA 12_colorisSet") var colorisSet: Bool?
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	
	@State var webViewManager = WebViewManager(for: Self.webViewConfiguration)
	let startURL = URL(string: "https://ptb.discord.com/login")!
	let rickrollURL = URL(string: "https://www.youtube.com/watch?v=o-YBDTqX_ZU")!
	@State private var searchText = ""
	
	var body: some View {
		VStack{
			CustomWebView(webView: webViewManager.webView, request: URLRequest(url: startURL), searchText: $searchText, state: CustomWebViewState(searchText: searchText))
			HStack {
				Button(action: rickrol) {
					Image(systemName: "")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor.opacity(0.0))
						.frame(width: 0)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("f", modifiers: [.command, .shift])
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut("<", modifiers: .command)
#endif
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(">", modifiers: .command)
#endif
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
#if os(iOS)
				.keyboardShortcut(".", modifiers: .command)
#endif
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(colorisSet ?? false ? Color(colorString!): .accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.buttonRepeatBehavior(.enabled)
#if os(iOS)
				.keyboardShortcut("r", modifiers: .command)
#endif
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	func goBack() {
		webViewManager.goBack()
	}
	func goForward() {
			// Implement go forward logic
		webViewManager.goForward()
	}
	
	func goHome() {
			// Implement go home logic
		webViewManager.goHome(for: startURL)
	}
	func rickrol() {
		print("rickrol")
			// Implement go home logic
		webViewManager.rickrol(for: rickrollURL)
	}
	
	func reload() {
			// Implement reload logic
		webViewManager.reload()
	}
}



#Preview {
	ContentView()
}
