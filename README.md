# uta-devkit

**Claude Code と Codex 専用の開発Skill集。**

## Claude Code

GitHubへのアクセス権がある環境でリポジトリをcloneし、ローカルプラグインとして利用します。

```bash
git clone git@github.com:shoutahosoi11/uta-devkit.git
claude --plugin-dir ./uta-devkit
```

マーケットプレイスを利用する場合:

```text
/plugin marketplace add shoutahosoi11/uta-devkit
/plugin install superpowers@uta-devkit
```

非公開リポジトリの登録が認証の都合で利用できない場合は `--plugin-dir` を利用してください。ほかに同名のプラグインを使用している場合は競合に注意してください。

## Codex

```bash
git clone git@github.com:shoutahosoi11/uta-devkit.git
cd uta-devkit
bash setup/install-codex.sh
```

既定では `~/.agents/skills/` にシンボリックリンクを作ります。既存のSkillは上書きしません。Codexを再起動し、Skillの読み込みを確認してください。

Skill未起動時も短文ルールを適用したい場合は、[setup/global-response-style.md](setup/global-response-style.md) を `~/.codex/AGENTS.md` と `~/.claude/CLAUDE.md` に追記してください。

## 実装後のQAレビュー

[QAレビュープロンプト](prompts/qa-review.md) の全文をClaude CodeまたはCodexに渡し、冒頭の入力欄で対象・仕様・環境を指定してください。未指定項目の扱いはプロンプトに定義しています。

仕様・コードのレビュー、テストケース設計、既存テスト・API・画面での実動作確認を対象とします。設計範囲外への影響、セキュリティ、性能も確認し、未実行を合格にしません。実装・修正・新しい自動テストの追加は行わせません。

単独で使うプロンプトであり、Skillの自動起動や既存の開発フローは変更しません。[設計方針と参照観点](docs/qa-review-sources.md) も参照できます。

## テスト

```bash
bash tests/uta-devkit/test-layout.sh
bash tests/human-led-design/test-skill-structure.sh
```

実際のClaude Code/Codexによる指示遵守は `tests/human-led-design/behavior-scenarios.md` に基づいて別途確認が必要です。

## ライセンス

独自の貢献部分は [MIT License](LICENSE) に従います。Superpowers由来のコード・文書に適用される著作権表示とライセンスは [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md) を参照してください。
