//
//  ProgressView.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/24.
//

import SwiftUI

struct TrafficProgressView: View {
    @State var traficProgress = 0.6
    
    var body: some View {
        ProgressView("剩余流量", value: traficProgress)
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
    }
}

struct TrafficProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TrafficProgressView()
    }
}
