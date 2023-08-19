//
//  ContentView.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 08/08/2023.
//

import WebKit
import SwiftUI
import Foundation

@available(macOS 14.0, *)
@available(iOS 17.0, *)
struct ContentView: View {
	#if os(macOS)
	@State var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
	@State var selectedSideBarItem: SideBarItem = .ClassSide
	
#endif
	// views
	
	@State var classSideView = AnyView(ClassSideView())
	@State var moodleView = AnyView(MoodleView())
	@State var timeTableView = AnyView(TimeTableView())
	@State var webUntisView = AnyView(WebUntisView())
	@State var oszimtView = AnyView(OSZimtView())
	@State var chatGPTView = AnyView(ChatGPTView())
	@State var discordView = AnyView(DiscordView())
	@State var wwwView = AnyView(WWWView())

	
	
	
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
			
			self.moodleView
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
				.navigationBarTitle("OSZ IMT Webseite")
			
			self.chatGPTView
				.tabItem {
					Text("ChatGPT")
					Image(systemName: "message.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("ChatGPT")
			
			self.discordView
				.tabItem {
					Text("Discord")
					Image(systemName: "message.badge.circle.fill")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("Discord")
			
			self.wwwView
				.tabItem {
					Text("Browse Web")
					Image(systemName: "globe")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.navigationBarTitle("Web")
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
			.listStyle(SidebarListStyle())
			
			.background(BlurView())
		} detail: {
			destinationView(for: selectedSideBarItem)
		}.padding(0)
		.background(BlurView())
		.onAppear {
			
			if selectedSideBarItem != .ClassSide {
				selectedSideBarItem = SideBarItem.allCases.first ?? .ClassSide
			}
		}
#endif
		
	}
	
	#if os(macOS)
	func destinationView(for item: SideBarItem) -> some View {
		switch item {
			case .ClassSide:
				return classSideView
			case .Moodle:
				return moodleView
			case .TimeTable:
				return timeTableView
			case .WebUntis:
				return webUntisView
			case .OSZimt:
				return oszimtView
			case .ChatGPT:
				return chatGPTView
			case .Discord:
				return discordView
			case .WWW:
				return wwwView
			default:
				return classSideView
		}
	}
	#endif
	
}

#if os(macOS)

enum SideBarItem: String, Identifiable, CaseIterable {
	var id: String { rawValue }
	
	case ClassSide
	case Moodle
	case TimeTable
	case WebUntis
	case OSZimt
	case ChatGPT
	case Discord
	case WWW
	
	var title: String {
		switch self {
			case .ClassSide: return "Klassen Webseite"
			case .Moodle: return "Moodle"
			case .TimeTable: return "Stundenplan"
			case .WebUntis: return "WebUntis"
			case .OSZimt: return "OSZ IMT Webseite"
			case .ChatGPT: return "ChatGPT"
			case .Discord: return "Discord"
			case .WWW: return "Browse Web"
		}
	}
	
	var systemImage: String {
		switch self {
			case .ClassSide: return "doc.richtext"
			case .Moodle: return "studentdesk"
			case .TimeTable: return "info.circle"
			case .WebUntis: return "info.circle"
			case .OSZimt: return "graduationcap.circle"
			case .ChatGPT: return "message.circle"
			case .Discord: return "message.badge.circle.rtl"
			case .WWW: return "globe"
		}
	}
}

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
	@Binding var webView: WKWebView
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
	@Binding var webView: WKWebView
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


struct ClassSideView: View {
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
	let startURL = URL(string: "https://ita12docoszimt.serveblog.net/")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText);
			HStack {
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			
			
		}
	}
	
	
	func goBack() {
		webView.goBack()
	}
	
	func goForward() {
		webView.goForward()
	}
	
	func goHome() {
		webView.load(URLRequest(url: startURL))
	}
	
	func reload() {
		webView.reload()
	}
}
struct MoodleView: View {
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
	let startURL = URL(string: "https://moodle.oszimt.de/")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			 
			
		}
	}
	func goBack() {
		webView.goBack()
	}
	
	func goForward() {
		webView.goForward()
	}
	
	func goHome() {
		webView.load(URLRequest(url: startURL))
	}
	
	func reload() {
		webView.reload()
	}
}

struct TimeTableView: View {
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
	let startURL = URL(string: "https://mese.webuntis.com/WebUntis/monitor?school=OSZ%20IMT&simple=2&type=1&monitorType=tt&name=ITA%2012")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
			 
		}
	}
	func goBack() {
		webView.goBack()
	}
	
	func goForward() {
		webView.goForward()
	}
	
	func goHome() {
		webView.load(URLRequest(url: startURL))
	}
	
	func reload() {
		webView.reload()
	}
}

struct OSZimtView: View {
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
	let startURL = URL(string: "https://oszimt.de")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
		}
		
	}
	func goBack() {
		webView.goBack()
	}
	
	func goForward() {
		webView.goForward()
	}
	
	func goHome() {
		webView.load(URLRequest(url: startURL))
	}
	
	func reload() {
		webView.reload()
	}
}

struct ChatGPTView: View {
	
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
	let startURL = URL(string: "https://chat.openai.com/")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("r", modifiers: .command)
				
			}
			
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
		}
	}
	func goBack() {
		webView.goBack()
	}
	
	func goForward() {
		webView.goForward()
	}
	
	func goHome() {
		webView.load(URLRequest(url: startURL))
	}
	
	func reload() {
		webView.reload()
	}
}



	struct WWWView: View {
			// Konfigurieren der WKWebViewConfiguration-Instanz
		static let webViewConfiguration: WKWebViewConfiguration = {
			let configuration = WKWebViewConfiguration()
#if os(iOS)
			configuration.allowsInlineMediaPlayback = true
			configuration.allowsPictureInPictureMediaPlayback = true
#endif
			return configuration
		}()
		
		@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
		let startURL = URL(string: "https://ita12docoszimt.serveblog.net/")!
		@State private var searchText = ""
		var body: some View {
			VStack{
				CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText)
				HStack {
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
					.keyboardShortcut("ö", modifiers: .command)
					
					Button(action: goForward) {
						Image(systemName: "arrowshape.turn.up.right.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
.frame(width: 20)
					}
					.buttonStyle(PlainButtonStyle())
					.keyboardShortcut("ä", modifiers: .command)
					
					Button(action: goHome) {
						Image(systemName: "house.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
.frame(width: 20)
					}
					.buttonStyle(PlainButtonStyle())
					.keyboardShortcut("ü", modifiers: .command)
					
					Button(action: reload) {
						Image(systemName: "arrow.clockwise.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
.frame(width: 20)
					}
					.buttonStyle(PlainButtonStyle())
					.keyboardShortcut("r", modifiers: .command)
					
				}
				.aspectRatio(contentMode: .fit)
				.padding([.horizontal, .bottom])
			}
		}
		
		
		func goBack() {
			webView.goBack()
		}
		
		func goForward() {
			webView.goForward()
		}
		
		func goHome() {
			webView.load(URLRequest(url: startURL))
		}
		
		func reload() {
			webView.reload()
		}
		func search() {
				// Check if the search text starts with "!yt:"
			if searchText.hasPrefix("!yt:") {
					// Extract the search query
				let searchQuery = searchText.replacingOccurrences(of: "!yt:", with: "")
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
						   let url = URL(string: "https://www.bing.com/search?q=\(encodedSearchText)") {
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


	}

struct WebUntisView: View {
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
	let startURL = URL(string: "https://mese.webuntis.com/WebUntis/?school=OSZ+IMT#/basic/login")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
		}
	}
	func goBack() {
		webView.goBack()
	}
	
	func goForward() {
		webView.goForward()
	}
	
	func goHome() {
		webView.load(URLRequest(url: startURL))
	}
	
	func reload() {
		webView.reload()
	}
}

struct DiscordView: View {
		// Konfigurieren der WKWebViewConfiguration-Instanz
	static let webViewConfiguration: WKWebViewConfiguration = {
		let configuration = WKWebViewConfiguration()
#if os(iOS)
		configuration.allowsInlineMediaPlayback = true
		configuration.allowsPictureInPictureMediaPlayback = true
#endif
		return configuration
	}()
	
	@State private var webView = WKWebView(frame: .zero, configuration: Self.webViewConfiguration)
	let startURL = URL(string: "https://ptb.discord.com/login")!
	@State private var searchText = ""
	var body: some View {
		VStack{
			CustomWebView(webView: $webView, request: URLRequest(url: startURL), searchText: $searchText)
			HStack {
				Spacer()
				Button(action: goBack) {
					Image(systemName: "arrowshape.turn.up.left.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
.frame(width: 20)
				}
				.buttonStyle(PlainButtonStyle())
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			.padding([.horizontal, .bottom])
		}
	}
	func goBack() {
		webView.goBack()
	}
	
	func goForward() {
		webView.goForward()
	}
	
	func goHome() {
		webView.load(URLRequest(url: startURL))
	}
	
	func reload() {
		webView.reload()
	}
}



#Preview {
    ContentView()
}
