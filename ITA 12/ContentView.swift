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
#if os(iOS)
				.navigationBarTitle(Text("Klassen Webseite"))
#endif
			MoodleView()
				.tabItem {
					Text("Moodle")
					Image(systemName: "studentdesk")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 20.0)
				}
#if os(iOS)
				.navigationBarTitle(Text("moodel"))
#endif
			TimeTableView()
				.tabItem {
					Text("Stundenplan")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
#if os(iOS)
				.navigationBarTitle(Text("Stundenplan"))
#endif
			WebUntisView()
				.tabItem {
					Text("WebUntis")
					Image(systemName: "info.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
#if os(iOS)
				.navigationBarTitle(Text("WebUntis"))
#endif
			OSZimtView()
				.tabItem {
					Text("OSZ IMT Website")
					Image(systemName: "graduationcap.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
#if os(iOS)
				.navigationBarTitle(Text("OSZ IMT Webseite"))
#endif
			ChatGPTView()
				.tabItem {
					Text("ChatGPT")
					Image(systemName: "message.circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
#if os(iOS)
				.navigationBarTitle(Text("ChatGPT"))
#endif
			DiscordView()
				.tabItem {
					Text("Discord")
					Image(systemName: "message.badge.circle.rtl")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
#if os(iOS)
				.navigationBarTitle(Text("Discord"))
#endif
			WWWView()
				.tabItem {
					Text("Browse Web")
					Image(systemName: "globe")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundColor(Color.accentColor)
						.frame(width: 40)
				}
#if os(iOS)
				.navigationBarTitle(Text("Web"))
#endif
		}.frame(minWidth: 1280,idealWidth: 1920, maxWidth: 7680, minHeight: 720, idealHeight: 1080, maxHeight: 4320)
			.onAppear {
				createMenuBar()
			}
	}
#if os(macOS)
	func createMenuBar() {
		let mainMenu = NSApp.mainMenu ?? NSMenu()
		let appMenu = NSMenu()
		let mainMenuItem = NSMenuItem()
		mainMenu.addItem(mainMenuItem)
		NSApp.mainMenu = mainMenu
		
		let appMenuItem = NSMenuItem()
		appMenu.addItem(appMenuItem)
		mainMenuItem.submenu = appMenu
		
		appMenu.addItem(withTitle: "Go Back", action: .none, keyEquivalent: "ö")
		appMenu.addItem(withTitle: "Go Forward", action: .none, keyEquivalent: "ä")
		appMenu.addItem(withTitle: "Go Home", action: .none, keyEquivalent: "ü")
		appMenu.addItem(withTitle: "Reload", action: .none, keyEquivalent: "r")
	}

#endif
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
/*
 struct Message: Identifiable {
 var id = UUID()
 var text: String
 var isSentByUser: Bool
 }
 */

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
				let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(searchQuery)")
					// Load the YouTube video URL in the web view
				webView.load(URLRequest(url: youtubeURL!))
			} else {
					// Create the YouTube search URL
				let encodedSearchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
				let youtubeURL = URL(string: "https://www.youtube.com/results?search_query=\(encodedSearchQuery)")
					// Load the YouTube search URL in the web view
				webView.load(URLRequest(url: youtubeURL!))
			}
		} else {
				// Check if the search bar is empty (including whitespace)
			if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
					// The search bar is empty
					// Perform an action here if the search bar is empty
					// For example:
				print("The search bar is empty")
			} else {
					// The search bar is not empty
					// Perform your normal search function here
				if let urlWithProtocol = addProtocolToURL(searchText) {
						// If the search text matches a URL, add the protocol and load the URL
					webView.load(URLRequest(url: urlWithProtocol))
				} else {
						// Otherwise, perform a Bing search
					let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
					if let url = URL(string: "https://www.bing.com/search?q=\(encodedSearchText)") {
						webView.load(URLRequest(url: url))
					}
				}
			}
		}
	}
	
	#if os(iOS)
	func addProtocolToURL(_ urlString: String) -> URL? {
		if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
			return url
		} else if urlString.range(of: "^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+\\..+$", options: .regularExpression) != nil {
			let urlWithProtocol = "http://" + urlString
			return URL(string: urlWithProtocol)
		} else if urlString.range(of: "^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$", options: .regularExpression) != nil {
			let urlWithProtocol = "http://" + urlString
			return URL(string: urlWithProtocol)
		}
		return nil
	}
	#elseif os(macOS)
	
	func addProtocolToURL(_ urlString: String) -> URL? {
		if let url = URL(string: urlString), FileManager.default.fileExists(atPath: url.path) {
			return url
		} else if urlString.range(of: "^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+\\..+$", options: .regularExpression) != nil {
			let urlWithProtocol = "http://" + urlString
			return URL(string: urlWithProtocol)
		} else if urlString.range(of: "^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$", options: .regularExpression) != nil {
			let urlWithProtocol = "http://" + urlString
			return URL(string: urlWithProtocol)
		}
		return nil
	}
	#endif
	
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
