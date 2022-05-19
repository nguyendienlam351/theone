//
//  HomeView.swift
//  theone
//
//  Created by nguyenlam on 5/2/22.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .primary
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.thirdly], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.primary], for: .normal)
        UISegmentedControl.appearance().backgroundColor = .thirdly
    }
    
    var body: some View {
        VStack {
            NavigationView {
                CustomTabView()
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
            }.accentColor(.primary)
        }
    }
}

var tabs = ["house.fill", "magnifyingglass", "camera.viewfinder", "person.fill"]

struct CustomTabView: View {
    @State var selectedTab = "house.fill"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                Main()
                    .tag("house.fill")
                UserProfile()
                    .tag("magnifyingglass")
                Post()
                    .tag("camera.viewfinder")
                Profile()
                    .tag("person.fill")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) {
                    image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.thirdly)
            .clipShape(Capsule())
            .shadow(color: Color.secondary.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.secondary.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
            .padding(.bottom, edge!.bottom == 0 ? 20 : 0)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.secondary.opacity(0.05).ignoresSafeArea(.all, edges: .all))
    }
}


struct TabButton: View {
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color.primary : Color.secondary)
                .padding()
        }
    }
}
