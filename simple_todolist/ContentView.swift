//
//  ContentView.swift
//  simple_todolist
//
//  Created by ina on 2022/09/11.
//

import SwiftUI

class ObservableList: ObservableObject {
    @Published var list: [String] = []
}

struct DetailView: View {
    @State var todo: String = ""
    @Environment(\.dismiss) var dismiss
    
    var list: ObservableList
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                TextField("Enter your todo", text: $todo)
                    .padding()
                Button(action: {
                    self.list.list.insert(todo, at: 0)
                    dismiss()
                }, label: {
                    Text("추가")
                })
                Spacer()
            }
            Spacer()
        }
        .navigationBarTitle("할일 추가")
    }
}

struct ContentView: View {
    @ObservedObject var list = ObservableList()
    
    var body: some View {
        NavigationView {
            ZStack {
                List(list.list, id: \.self) { item in
                    Text(item)
                }
                
                NavigationLink(destination: DetailView(list: self.list)) {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                                .padding()
                                .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
