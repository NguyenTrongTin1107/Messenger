//
//  HomeView.swift
//  Messenger
//
//  Created by Trọng Tín on 11/08/2021.
//

import SwiftUI

struct HomeView: View {
    enum Tab {
        case info, listUser, listFriend, setting
        
        var title: String {
            switch self {
            case .info: return ""
            case .listUser: return "List user"
            case .listFriend: return "List friend"
            case .setting: return "Setting"
            }
        }
        
        var isHiddenNavigation: Bool {
            switch self {
            case .info: return true
            default: return false
            }
        }
        
        var barColor: UIColor {
            switch self {
            case .info: return .clear
            default: return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            }
        }
    }
    
    @ObservedObject var authenModel: AuthenModel
    
    @State private var selection: Tab = .listFriend
    
    var body: some View {
        TabView (selection: $selection) {
            InfoView(viewModel: InfoViewModel(authenModel: authenModel))
                .tabItem {
                    Label("Users", systemImage: "person.crop.circle")
                }
                .tag(Tab.info)
            ListFriendView()
                .tabItem {
                    Label("Friends", systemImage: "bubble.left.and.bubble.right")
                }
                .tag(Tab.listFriend)
            ListUser()
                .tabItem {
                    Label("More friend", systemImage: "person.crop.circle.badge.plus")
                }
                .tag(Tab.listUser)
            SettingView(viewModel: SettingViewModel(authenModel: authenModel))
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
                .tag(Tab.setting)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(selection.barColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection.isHiddenNavigation)
        .navigationTitle(selection.title).font(.title2)
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            HomeView(user: User(_id: "", email: "ntrongtin11702@gmail.com", password: "", fullname: "Nguyễn Trọng Tín"))
//        }
//    }
//}
