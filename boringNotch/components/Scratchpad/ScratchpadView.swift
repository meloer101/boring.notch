//
//  ScratchpadView.swift
//  boringNotch
//

import AppKit
import SwiftUI

struct ScratchpadView: View {
    @EnvironmentObject var vm: BoringViewModel
    @StateObject private var store = ScratchpadStore.shared
    @FocusState private var isEditorFocused: Bool
    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            toolbar

            TextEditor(text: $store.text)
                .focused($isEditorFocused)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
                .scrollContentBackground(.hidden)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.08))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(isEditorFocused ? 0.22 : 0.1), lineWidth: 1)
                        }
                )
                .overlay(alignment: .topLeading) {
                    if store.text.isEmpty {
                        Text("Paste or type temporary text...")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundStyle(.gray)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 16)
                            .allowsHitTesting(false)
                    }
                }
        }
        .padding(.horizontal, 8)
        .padding(.top, 2)
        .padding(.bottom, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            isEditorFocused = true
            vm.isScratchpadEditing = true
        }
        .onChange(of: isEditorFocused) { _, isFocused in
            vm.isScratchpadEditing = isFocused
        }
        .background(ScratchpadWindowFocusBridge(isEnabled: true))
        .onDisappear {
            copied = false
            vm.isScratchpadEditing = false
        }
    }

    private var toolbar: some View {
        HStack(spacing: 8) {
            Label("Scratchpad", systemImage: "text.alignleft")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)

            Spacer()

            Button {
                copyText()
            } label: {
                Image(systemName: copied ? "checkmark" : "doc.on.doc")
                    .font(.system(size: 12, weight: .semibold))
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)
            .foregroundStyle(store.hasContent ? Color.white : Color.secondary)
            .disabled(!store.hasContent)
            .help("Copy scratchpad")

            Button {
                store.clear()
                copied = false
                isEditorFocused = true
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 12, weight: .semibold))
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)
            .foregroundStyle(store.hasContent ? Color.white : Color.secondary)
            .disabled(!store.hasContent)
            .help("Clear scratchpad")
        }
    }

    private func copyText() {
        guard store.hasContent else { return }

        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(store.text, forType: .string)

        copied = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            copied = false
        }
    }
}

private struct ScratchpadWindowFocusBridge: NSViewRepresentable {
    let isEnabled: Bool

    func makeNSView(context: Context) -> NSView {
        FocusBridgeView()
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        DispatchQueue.main.async {
            guard let window = nsView.window else { return }
            ScratchpadWindowFocusBridge.setAllowsKeyFocus(isEnabled, on: window)

            if isEnabled {
                window.makeKey()
            }
        }
    }

    static func dismantleNSView(_ nsView: NSView, coordinator: ()) {
        guard let window = nsView.window else { return }
        setAllowsKeyFocus(false, on: window)
    }

    private static func setAllowsKeyFocus(_ allowsKeyFocus: Bool, on window: NSWindow) {
        if let notchWindow = window as? BoringNotchWindow {
            notchWindow.allowsKeyFocus = allowsKeyFocus
        }
        if let skyLightWindow = window as? BoringNotchSkyLightWindow {
            skyLightWindow.allowsKeyFocus = allowsKeyFocus
        }
    }

    private final class FocusBridgeView: NSView {
        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()

            guard let window else { return }
            ScratchpadWindowFocusBridge.setAllowsKeyFocus(true, on: window)
            window.makeKey()
        }
    }
}

#Preview {
    ScratchpadView()
        .frame(width: 620, height: 150)
        .background(.black)
}
