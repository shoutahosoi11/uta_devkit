# uta-devkit

**Claude Code と Codex 専用の個人向け開発Skill集。**

[obra/superpowers](https://github.com/obra/superpowers) のMITライセンス版を基に、以下の方針を加えて独立した開発ツールとして整理しています。

- **Human-led Design:** ユーザー課題を起点に、選択肢ごとの固有の性質と理由、ユーザー／システム双方のメリット・デメリットを比較。重要な設計は人間が承認。
- **最小実装:** 既存コード・バリデーション・ロジック・用語を再利用。重複や既存機能への影響を抑える。
- **状態管理:** 保存場所、寿命、SSOT、更新責任、失敗、処理順序逆転を検討。
- **TDD:** RED → GREEN → REFACTOR。簡単な英単語・既存の命名を使用し、長くても意味が分かる関数名・変数名にする。
- **コード理解:** 機能 → ファイル → 関数 → データの流れ → テストの順に説明。
- **すべての回答:** 結論ファースト・短文・要点重視。重要な因果関係は省略しない。

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

## テスト

```bash
bash tests/uta-devkit/test-layout.sh
bash tests/human-led-design/test-skill-structure.sh
```

実際のClaude Code/Codexによる指示遵守は `tests/human-led-design/behavior-scenarios.md` に基づいて別途確認が必要です。

## 著作権

[obra/superpowers](https://github.com/obra/superpowers) を基に改変。元の著作権表示とMITライセンスは [LICENSE](LICENSE) に維持しています。

LeetCodeのファイルは最新のツリーから除外しますが、過去のGit履歴には残ります。
