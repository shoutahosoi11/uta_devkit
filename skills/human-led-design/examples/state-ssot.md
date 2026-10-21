# Example: Query Cache and Editable React State

**1. ユーザーの課題**  
A search results page must show fresh results without confusing stale content. Whether the user edits an unsaved draft is **unknown**.

**2. 既存システムと制約**  
Assume TanStack Query already fetches and caches server results. The server/DB remains authoritative for persisted data; the query cache may be the SSOT for **rendering fetched results**.

**3. 選択肢**

### A. Render directly from the query cache; derive view-only data
- **技術的性質:** Components render from one query result without copying the same fetched data into a second state.
- **ユーザーのメリット:** On cache refresh, one rendered data path reduces the chance of seeing stale duplicated results.
- **ユーザーのデメリット:** If users must edit without saving immediately, this approach alone does not provide a distinct draft buffer.
- **システムのメリット:** Eliminating a redundant copy removes manual cache-to-state synchronization and extra update paths.
- **システムのデメリット:** Truly editable temporary values require an explicit separate state and merge/conflict policy.

### B. Copy the same fetched result into useState
- **技術的性質:** The fetched result now has two independently changeable client copies.
- **ユーザーのメリット:** If this copy is intentionally used as an *unsaved editable draft*, changes can be shown before committing them to the server.
- **ユーザーのデメリット:** If synchronization is not defined, refresh or delayed responses can overwrite a draft or show older results.
- **システムのメリット:** Deliberately separate draft state can isolate pending user edits from new server snapshots.
- **システムのデメリット:** Additional synchronization, reset, cancel, conflict, and out-of-order response rules are required. Copying for read-only display adds cost with no meaningful user benefit.

**4. 選択肢間の比較**  
**Shared:** Both can display results. Merely displaying fetched data is *not* a reason to duplicate state.  
**Difference:** A minimizes state and synchronization for read-only views; B supports an explicitly modeled editable draft but needs a policy for refetches, errors, retries, cancellation, and concurrent changes.

**5. AIの推奨**  
For read-only results, **A**, because the existing query cache already supplies the data and eliminating a redundant copy reduces inconsistency risk and implementation scope. If editing before save is a validated user need, **B as a separate draft**, with ownership, dirty tracking, stale response handling, and rollback behavior. This recommendation reverses if confirmed editing requirements need isolation.

**6. 人間への質問**  
Do users only view the fetched results, or must they edit values locally before saving them?

**7. ADR（承認後のみ）**  
Pending human confirmation. Record state lifetime, UI SSOT, server authority, update ownership, and error/ordering behavior after approval.
