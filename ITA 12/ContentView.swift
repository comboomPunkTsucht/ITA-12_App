//
//  ContentView.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 08/08/2023.
//

import WebKit
import SwiftUI
import Foundation

struct ContentView: View {
	var body: some View {
	
		#if os(iOS)
		TabView {
			ClassSideView()
				.tabItem{
					Text("Klassen Wbseite")
					Image(systemName: "doc.richtext")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20.0)
				}
				.navigationBarTitle(Text("Klassen Webseite"))
			MoodleView()
				.tabItem {
					Text("Moodle")
					Image(systemName: "studentdesk")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20.0)
				}
				.navigationBarTitle(Text("moodel"))
			TimeTableView()
				.tabItem {
					Text("Stundenplan")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.navigationBarTitle(Text("Stundenplan"))
			WebUntisView()
				.tabItem {
					Text("WebUntis")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.navigationBarTitle(Text("WebUntis"))
			OSZimtView()
				.tabItem {
					Text("OSZ IMT Website")
					Image(systemName: "graduationcap.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.navigationBarTitle(Text("OSZ IMT Webseite"))
			ChatGPTView()
				.tabItem {
					Text("ChatGPT")
					Image(systemName: "message.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.navigationBarTitle(Text("ChatGPT"))
			DiscordView()
				.tabItem {
					Text("Discord")
					Image(systemName: "message.badge.circle.rtl")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.navigationBarTitle(Text("Discord"))
			WWWView()
				.tabItem {
					Text("Browse Web")
					Image(systemName: "globe")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.navigationBarTitle(Text("Web"))
		}
		
		#elseif os(macOS)
		
		NavigationView {
			List {
				NavigationLink(destination: ClassSideView()) {
					Label("Klassen Webseite", systemImage: "doc.richtext")
				}
				NavigationLink(destination: MoodleView()) {
					Label("Moodle", systemImage: "studentdesk")
				}
				NavigationLink(destination: TimeTableView()) {
					Label("Stundenplan", systemImage: "info.circle")
				}
				NavigationLink(destination: WebUntisView()) {
					Label("WebUntis", systemImage: "info.circle")
				}
				NavigationLink(destination: OSZimtView()) {
					Label("OSZ IMT Webseite", systemImage: "graduationcap.circle")
				}
				NavigationLink(destination: ChatGPTView()) {
					Label("ChatGPT", systemImage: "message.circle")
				}
				NavigationLink(destination: DiscordView()) {
					Label("Discord", systemImage: "message.badge.circle.rtl")
				}
				NavigationLink(destination: WWWView()) {
					Label("Browse Web", systemImage: "globe")
				}
			}
			.listStyle(SidebarListStyle())
			.frame(minWidth: 190, idealWidth: 190, maxWidth: 190)
			
			ClassSideView()
		}
		.frame(minWidth: 1280,idealWidth: 1920, maxWidth: 7680, minHeight: 720, idealHeight: 1080, maxHeight: 4320)
		#endif
	}
}


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
}#endif


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
						.frame(width: 40)
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			
			
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
						.frame(width: 40)
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			 
			
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
						.frame(width: 40)
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
			 
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
						.frame(width: 40)
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
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
						.frame(width: 40)
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
				.keyboardShortcut("r", modifiers: .command)
				
			}
			
			.aspectRatio(contentMode: .fit)
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
						.textFieldStyle(RoundedBorderTextFieldStyle())
#if os(iOS)
						.autocapitalization(.none)
						.disableAutocorrection(true)
						.keyboardType(.URL)
#endif
					Button(action: search) {
						Image(systemName: "magnifyingglass.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
							.frame(width: 40.0)
					}
					.keyboardShortcut(.defaultAction)
					Button(action: goBack) {
						Image(systemName: "arrowshape.turn.up.left.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
							.frame(width: 40.0)
					}
					.keyboardShortcut("ö", modifiers: .command)
					
					Button(action: goForward) {
						Image(systemName: "arrowshape.turn.up.right.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
							.frame(width: 40.0)
					}
					.keyboardShortcut("ä", modifiers: .command)
					
					Button(action: goHome) {
						Image(systemName: "house.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
							.frame(width: 40.0)
					}
					.keyboardShortcut("ü", modifiers: .command)
					
					Button(action: reload) {
						Image(systemName: "arrow.clockwise.circle")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundColor(Color.accentColor)
							.frame(width: 40.0)
					}
					.keyboardShortcut("r", modifiers: .command)
					
				}
				.aspectRatio(contentMode: .fit)
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
						.frame(width: 40.0)
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40.0)
				}
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40.0)
				}
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40.0)
				}
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
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
						.frame(width: 40.0)
				}
				.keyboardShortcut("ö", modifiers: .command)
				
				Button(action: goForward) {
					Image(systemName: "arrowshape.turn.up.right.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40.0)
				}
				.keyboardShortcut("ä", modifiers: .command)
				
				Button(action: goHome) {
					Image(systemName: "house.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40.0)
				}
				.keyboardShortcut("ü", modifiers: .command)
				
				Button(action: reload) {
					Image(systemName: "arrow.clockwise.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40.0)
				}
				.keyboardShortcut("r", modifiers: .command)
				
			}
			.aspectRatio(contentMode: .fit)
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
