//
//  ActivityLoadingView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 21/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

extension View {
    public func loadingOverlay(isPresented: Binding<Bool>) -> some View {
        self.modifier(ActivityLoader(isPresented: isPresented))
    }
}

fileprivate struct ActivityLoader: ViewModifier {
    @Binding var isPresented: Bool
    
    var loadingView: some View {
        LoaderView(isPresented: $isPresented)
    }
    
    func body(content: Content) -> some View {
        content.overlay(self.loadingView, alignment: .center)
    }
}

private struct LoaderView: View {

    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            ActivityLoadingView(isPresented: $isPresented)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .contentShape(Rectangle())
            .background(Color.gray)
        .opacity(isPresented ? 0.5 : 0.0)
    }
}

private struct ActivityLoadingView: UIViewRepresentable {

    @Binding var isPresented: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityLoadingView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityLoadingView>) {
        isPresented ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

#if DEBUG
fileprivate struct LoaderPreview: View {
    @State var presented = false
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.presented.toggle()
            }, label: {
                Text("Toggle")
            })
            Spacer()
        }.background(Color.blue)
        .loadingOverlay(isPresented: self.$presented)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderPreview()
    }
}
#endif

