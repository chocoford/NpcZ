//
//  ListCell.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/23.
//

import SwiftUI

struct ListCell: View {
    @State var value = ""
    @State var active: Bool = false

    
    var body: some View {
        HStack {
            TextField("开启端口", text: $value)
                
            Toggle(isOn: $active, label: {})
        }.padding()
        .border(Color.white)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell()
    }
}
