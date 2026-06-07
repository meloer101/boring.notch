import Foundation

@main
struct ScratchpadStoreTest {
    static func main() {
        var savedValues: [String] = []
        let store = ScratchpadStore(initialText: "first note") { value in
            savedValues.append(value)
        }

        assert(store.text == "first note", "Store should load initial text")
        assert(store.hasContent, "Initial non-empty text should be copyable")

        store.text = "updated note"
        assert(savedValues == ["updated note"], "Text edits should be persisted")

        store.clear()
        assert(store.text.isEmpty, "Clear should empty the scratchpad")
        assert(!store.hasContent, "Empty scratchpad should not be copyable")
        assert(savedValues == ["updated note", ""], "Clear should persist an empty value")

        print("All tests passed.")
    }
}
