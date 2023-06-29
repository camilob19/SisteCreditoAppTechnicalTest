//
//  LoadingBar.swift
//  VideogameApp
//
//  Created by Cristian on 28/06/23.
//

import SwiftUI

struct LoadingBar: View {
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Loading...")
                    .fontWeight(Font.Weight.bold)
                    .foregroundColor(Color.white)
                Spacer()
                ActivityIndicatorView()
                    .padding(.bottom)
            }
            .frame(width: 200, height: 60)  
            .background(Color.clear)
            .cornerRadius(20)
        }
        .background(Color.shark)
        .ignoresSafeArea()
    }
}

struct ActivityIndicatorView: View {
    @State var offsetX: CGFloat = 0
    @State var widthLoader: CGFloat = 20
    
    var body: some View {
        ZStack {
            Capsule()
                .stroke(Color.white)
                .frame(width: 180, height: 20)
                .overlay(
                    VStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.pictonBlue)
                            .frame(width: widthLoader,
                                   height: 15,
                                   alignment: .leading)
                            .padding([.leading, .trailing], 5)
                            .offset(x: offsetX, y: 0)
                            .onAppear {
                                withAnimation(Animation.linear(duration: 0.9).repeatForever()) {
                                    offsetX = 140
                                    widthLoader = 40
                                }
                            }
                    }.frame(width: 190, height: 20, alignment: .leading)
                )
        }
    }
}

struct LoadingBar_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBar()
    }
}
