//
//  ContentView.swift
//  NetworkLayer
//
//  Created by hamid on 06.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            NetworkManeger.shared.getcomments { result in
                switch result {
                    
                case .success(let success):
                    
                    success.forEach { comment in
                        
                        print(comment.postID ?? "")
                    }
                      
                case .failure(let failure):
                      print(failure.localizedDescription)
                    }
                }
            }
        }
    }


#Preview {
    ContentView()
}
