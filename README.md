# uta-devkit

**Claude Code と Codex 専用の個人向け開発Skill集。**

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


