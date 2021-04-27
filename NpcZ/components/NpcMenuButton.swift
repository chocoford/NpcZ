//
//  MenuButton.swift
//  NpcZ
//
//  Created by Chocoford on 2021/4/27.
//

import SwiftUI

struct NpcMenuButton: View {
    @State var hovering: Bool = false
    let title: String
    let action: () -> Void
    let keyEquivalent: String
    
//    struct NpcMenuButtonStyle: ButtonStyle {
//      func makeBody(configuration: Configuration) -> some View {
//        Button(action: {}, label: {
//          HStack {
//            Spacer()
//            configuration.label.foregroundColor(.black)
//            Spacer()
//          }
//        })
//        // 👇🏻 makes all taps go to the the original button
//        
//        .padding()
//        .background(Color.yellow.cornerRadius(8))
//        .scaleEffect(configuration.isPressed ? 0.95 : 1)
//      }
//    }
//    
    
    var body: some View {
        Button(action: action, label: {
            HStack{
            Text(title)
                .font(.title3)
            Spacer()
            Text(keyEquivalent)
                .font(.caption).foregroundColor(hovering ? Color.white: Color.gray)
            }

            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(RoundedRectangle(cornerRadius: 4).fill(hovering ? Color.gray: Color.clear))

        })
        .onHover(perform: { hovering in
            self.hovering = hovering
        })
        .padding(.horizontal, 4)
        .buttonStyle(PlainButtonStyle())
        
    }
}

struct NpcMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        NpcMenuButton(title: "123", action: {}, keyEquivalent: "⌘  , ")
    }
}
