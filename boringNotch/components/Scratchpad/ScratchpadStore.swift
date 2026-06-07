//
//  ScratchpadStore.swift
//  boringNotch
//

import Combine
import Foundation

final class ScratchpadStore: ObservableObject {
    static let storageKey = "scratchpadText"
    static let shared = ScratchpadStore()

    @Published var text: String {
        didSet {
            save(text)
        }
    }

    private let save: (String) -> Void

    var hasContent: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    convenience init(defaults: UserDefaults = .standard) {
        self.init(initialText: defaults.string(forKey: Self.storageKey) ?? "") { value in
            defaults.set(value, forKey: Self.storageKey)
        }
    }

    init(initialText: String, save: @escaping (String) -> Void) {
        self.text = initialText
        self.save = save
    }

    func clear() {
        text = ""
    }
}
