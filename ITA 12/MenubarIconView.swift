//
//  MenubarIconView.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 15/08/2023.
//

import SwiftUI

struct MenubarIconView: View {
	var body: some View {
		VStack {
				Image(systemName: "questionmark.app.fill")
					.resizable()
					.frame(width: 20, height: 20)
					.aspectRatio(contentMode: .fit)
			
		}
	}
}

#Preview {
   ContentView()
}
