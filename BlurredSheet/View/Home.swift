//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
// Copyright (c) 2022 Hackenbacker.
//
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php
//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

import SwiftUI
import MapKit

struct Home: View {
    @State var shouldShowSheet: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Map(coordinateRegion: .constant(.TOKYO_APPLE_MARUNOUCHI))
                .ignoresSafeArea()

            // MARK: Sheet Button
            Button {
                shouldShowSheet.toggle()
            } label: {
                ZStack {
                    Image(systemName: "circle")
                        .font(.system(size: 44))
                        .fontWeight(.thin)
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                }
            }
            .padding(16)
            .blurredSheet(.init(.ultraThinMaterial), show: $shouldShowSheet) {
                // nothing to do.
            } content: {
                Text("Hello From Sheets")
                    .presentationDetents([.large, .medium, .height(150)])
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/// Sample Locations / サンプル　ロケーション
extension MKCoordinateRegion {
    /// 東京・アップル丸の内
    static var TOKYO_APPLE_MARUNOUCHI: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude:   35.6798883,
            longitude: 139.7660499),
            latitudinalMeters:  800,
            longitudinalMeters: 800)
    }
    /// ドバイ・ブルジュハリファ
    static var DUBAI_BURJKHALIFA: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude:   25.2048,
            longitude:  55.2708),
            latitudinalMeters:  10000,
            longitudinalMeters: 10000)
    }
}
