//
//  VMLaunchAtLogin.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 20/08/2023.
//
#if os(macOS)
import Foundation
import Combine
import LaunchAtLogin

final class VMLaunchAtLogin {
	private var isLaunchAtLoginEnabled = LaunchAtLogin.isEnabled
	private var cancellables = Set<AnyCancellable>()
	
	func bind() {
		LaunchAtLogin
			.publisher
			.assign(to: \.isLaunchAtLoginEnabled, on: self)
			.store(in: &cancellables)
	}
}
#endif
