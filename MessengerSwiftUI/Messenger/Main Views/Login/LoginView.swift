//
//  LoginView.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI

struct AlertContent: Identifiable {
    var id: String { title }
    let title: String
    let description: String?
    let dismiss: Bool
}

struct LoginView: View {
    @State private var isLogin: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Spacer()
                HStack {
                    VStack (alignment: .leading) {
                        Text("Messenger")
                            .font(.system(size: 40, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                            .lineLimit(1)
                        Text("Welcome to messenger!\nLet say something to your friend!")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.180785032, green: 0.5511000946, blue: 0.8088557696, alpha: 1)))
                            .lineLimit(2)
                            .padding(.top, 2)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                Spacer()
                if isLogin {
                    ZStack {
                        Wave(strength: 20, frequency: 10)
                            .frame(height: UIScreen.main.bounds.height*0.6)
                        InputView()
                            .padding(.horizontal, 20)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.linear)
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()
            .animation(.default)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isLogin = true
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(DefaultController())
    }
}
