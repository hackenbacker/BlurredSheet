//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
// Copyright (c) 2022 Hackenbacker.
//
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php
//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

import SwiftUI

/// Declares Custom View Modifier.
extension View {

    /// Presents a blurred sheet when `show` is true.
    /// - Parameters:
    ///   - style: AnyShapeStyle - Materials, Colors, etc.
    ///   - show:  Determine whether a sheet should be shown.
    ///   - onDismiss: Dismiss Action
    ///   - content:   Sheet Content View
    func blurredSheet<Content: View>(_ style: AnyShapeStyle,
                                     show: Binding<Bool>,
                                     onDismiss: @escaping ()->Void,
                                     @ViewBuilder content: @escaping ()->Content) -> some View {
        sheet(isPresented: show, onDismiss: onDismiss) {
            content()
                .background(WithoutBackgroundColor())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    // MARK: Custom Background View
                    Rectangle()
                        .fill(style)
                        .ignoresSafeArea(.container, edges: .all)
                }
        }
    }
}
/*
 全画面表示がやりたい場合：
 `sheet( ... ) {`  の代わりに
 `fullScreenCover(isPresented: show, onDismiss: onDismiss) {`  と記述する。
 呼び出し側で`content`に閉じるボタンを付けないと、元の画面に戻れなくなるので注意。

 It won't work for NavigationStack,
 since it requires background color for its push/pop animation.
 */

/// Helper View.
fileprivate struct WithoutBackgroundColor: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // UI must be updated on Main Thread
        Task { @MainActor in
            // MARK: - This method is not recommended because it may not work
            // MARK: if the VIEW hierarchical structure changes due to an iOS version up. -
            // MARK: - この方法は推奨しない。
            // MARK: iOSのバージョンアップでVIEWの階層構造が変わったら動かなくなる可能性があるため。 -
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
}
