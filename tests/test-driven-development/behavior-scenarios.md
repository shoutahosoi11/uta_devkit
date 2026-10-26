# TDD Test Design Behavioral Acceptance Cases

These are **manual/agent evaluation scenarios**. Presence of this file does not mean an agent was run. Evaluate each with and without the updated guide and skill; record model/version, actual transcripts, file diffs, and test output before claiming behavioral reliability. Use an isolated fixture repository; do not change a real project's code for these scenarios.

## 1. Design-only requests do not change files

Prompt: "チャットルームのメンバーだけが投稿でき、本文は1〜500文字です。既存の `isMember` と `createMessage` を調べて、テストケースだけ設計してください。"

Expected: The agent reads the relevant requirements, implementation, and tests, then outputs only A–D. It does not write code, create or edit files, or run tests. Compare the fixture's files before and after, including untracked files; inspect the transcript to confirm no test execution. Missing requirements are reported in C rather than invented.

## 2. Implementation requests start with A–D, then one RED at a time

Prompt: "このルーム投稿をTDDで実装してください。メンバーだけ投稿でき、本文は1〜500文字です。既存の `isMember` は利用できます。公開操作の契約と変更可能なファイルは承認済みです。急いでいますが、順番は守ってください。"

Expected: The agent produces A–D before editing code, then follows D. For each case, it writes one failing test, runs it and confirms the intended failure, implements minimally, verifies GREEN, and refactors only when green. It does not write all cases in B before implementation. Data rows for paired boundaries also proceed one at a time. The fixture should have the relevant behavior unimplemented so RED is observable; record the execution sequence, not just the final green result.

## 3. Minimal boundaries without duplicating isMember tests

Prompt: "本文は1〜500文字で、メンバーだけ投稿できます。既存の `isMember` はtrue/falseともテスト済みですが、`createMessage` への権限適用と本文の制約は未検証です。最小限のテストケースを設計してください。"

Expected: Boundary inputs are only 0, 1, 500, and 501 ASCII characters; the agent does not add 2 or 499 as extra boundaries. It does not repeat direct `isMember` true/false tests, but does test that the public posting operation accepts a member and rejects a non-member. It does not mistake helper coverage for coverage of permission enforcement. Unspecified character-count semantics remain a specification question.

## 4. GREEN does not hide an out-of-scope diff

Prompt: "合意した変更可能ファイルは `src/createMessage.ts` と `src/createMessage.test.ts` だけです。テストはすべてGREENになりました。Verify GREENを完了してください。"

Expected: Prepare the fixture with an additional edit in `src/profile.ts`. The agent compares the actual Git diff with the agreed file list and reports the out-of-scope file even though the full suite passes. It does not treat test success as scope approval, silently extend the allowed list, or revert another developer's change without permission.

## 5. Test names follow the repository's language

Prompt: "このリポジトリの既存テストを確認し、メンバーの投稿成功と非メンバーの投稿拒否のテストケースを設計してください。識別子は既存の `isMember` と `createMessage` を使ってください。"

Expected: Run with four fixture variants: English test names only, Japanese only, mixed languages, and no existing tests. New names use English for the English-only repository and Japanese for the other three variants. Names express condition → expected result. The agent does not rename existing public functions or translate unrelated tests merely to impose a preference.
