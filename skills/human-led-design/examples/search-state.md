# Example: Reloadable Search Filters

**1. ユーザーの課題**  
After reloading the search page, people should not have to re-enter filters. Sharing filters with other people is **not yet a confirmed need**.

**2. 既存システムと制約**  
Assume a React search page currently keeps filters in local component state; no persistent storage exists. Before making a real recommendation, inspect the actual codebase and routing pattern.

**3. 選択肢**

### A. URL query parameters
- **技術的性質:** Filters are encoded in a navigable, copyable URL.
- **ユーザーのメリット:** Because the URL includes the filters, sending it to another person reproduces those filters, reducing the recipient's setup work.
- **ユーザーのデメリット:** Because filters appear in a shareable URL/history, unexpectedly sensitive values may be exposed when the URL is copied or logged.
- **システムのメリット:** Because browser navigation already tracks URLs, the app can use browser back/forward history to reproduce filter changes when implemented as URL state.
- **システムのデメリット:** Parsing, validation, encoding, and avoiding loops with UI state must be tested; URLs have practical length and privacy limits.
- **既存機能への影響 (relevant here):** Filter links and routing/navigation tests may change.

### B. localStorage
- **技術的性質:** Filters persist within the same browser origin, outside the URL.
- **ユーザーのメリット:** Because that browser saves the previous settings, returning to the site can restore their last filters without bookmarking any URL.
- **ユーザーのデメリット:** Because this storage is local to a browser profile, a link or other device does not automatically restore the filters.
- **システムのメリット:** Because data need not be serialized into the URL, it can retain browser-local preferences without changing route structure.
- **システムのデメリット:** Old saved formats can outlive deployments; initialization, validation/migration, storage errors, and clearing behavior need handling.
- **既存機能への影響 (relevant here):** Search initialization and defaults change, but route links can remain unchanged.

**4. 選択肢間の比較**  
**Shared:** Both can restore filters after reload. Reload persistence is **not** a URL-specific advantage.  
**Difference:** URL supports shareable/navigation-addressable state; localStorage prioritizes an individual's browser-local remembered preference. Both require integration with UI state. For *only* reload persistence, first check which approach minimally fits the existing app; do not add both by default.

**5. AIの推奨**  
**Not enough information for an unconditional recommendation.** If shareability and back/forward replay matter, URL has a user benefit localStorage alone lacks. If only same-browser remembered preferences matter, localStorage may be the smaller change when routing need not change. URL exposes values more broadly; localStorage adds stale-data handling. The recommendation reverses with the user's actual workflow and the existing routing architecture.

**6. 人間への質問**  
Is it important that another user can reproduce the same filters from a shared URL, or is restoring your own previous filters on the same browser sufficient?

**7. ADR（承認後のみ）**  
No decision yet. Save an ADR only after the human selects a priority and approves the design.
