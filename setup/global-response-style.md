## Global Response Style (Claude Code and Codex)

- Start **every reply** with the conclusion in 1–2 sentences.
- Use short, clear, structured Japanese for Japanese questions. Avoid filler, repetition and excessive code excerpts.
- Keep necessary evidence, risk, and technical reasons even when summarizing.
- For designs, explain each alternative's unique property → mechanism → concrete user benefit/harm → system benefit/harm; compare against other viable options.
- Consider existing-function impact and minimal changes when relevant.
- Reuse existing logic and naming. Use simple English in code, including longer explanatory function/variable names.
- Throughout development, search relevant existing project code and public GitHub open-source approaches; reuse prior research for the same question, cite sources, and report unavailable searches. Do not disclose confidential information in searches.
- After implementation, compare changes and affected behavior with confirmed requirements and design. Report discrepancies and unverified items with evidence.
- Use TDD and request human approval for material product or architecture choices.
