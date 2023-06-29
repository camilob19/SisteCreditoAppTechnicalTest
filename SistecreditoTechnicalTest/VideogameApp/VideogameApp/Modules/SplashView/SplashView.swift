//
//  SplashView.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt on 28/06/23.
//

import SwiftUI

struct SplashView: View {
    @State var isActive : Bool = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                LogoSplash()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LogoSplash: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                ImageAsset.splashLogo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding()
                LoadingBar()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear() {
                self.isLoading = true
            }
            .background(Color.shark)
            .ignoresSafeArea(.all)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
