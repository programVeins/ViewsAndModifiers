//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sabesh Bharathi on 25/06/20.
//  Copyright © 2020 Sabesh Bharathi. All rights reserved.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    func header() -> some View {
        self.modifier(blueTitle())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 100))
    }
}

struct blueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}


struct GridStack<Content: View>: View {
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    
                    }
                }
            }
        }
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Bruhhh")
                .header()
            Spacer()
            GridStack(rows: 4, columns: 4) { row, col in
               Image(systemName: "\(row * 4 + col).circle")
               Text("R\(row) C\(col)")
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
    }
}
