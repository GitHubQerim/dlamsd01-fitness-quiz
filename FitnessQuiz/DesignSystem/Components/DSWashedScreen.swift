import SwiftUI

/// Shared full-screen scaffold for the two screens that use the header
/// wash: a scrollable, screen-gutter-padded content area over the
/// top-anchored teal gradient. Extracted so StartView and ResultView
/// can't drift apart on the wash height/inset (both used to hard-code
/// the same `ZStack`/`ScrollView` wrapper independently).
struct DSWashedScreen<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ZStack(alignment: .top) {
            DSColor.headerWash
                .frame(height: 220)
                .ignoresSafeArea(edges: .top)

            ScrollView {
                content
                    .padding(DSSpacing.screenGutter)
            }
        }
    }
}
