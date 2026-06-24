# Graph Report - /Users/oao/my-brain  (2026-06-22)

## Corpus Check
- Large corpus: 350 files · ~182,372 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder, or use --no-semantic to run AST-only.

## Summary
- 143 nodes · 245 edges · 14 communities detected
- Extraction: 53% EXTRACTED · 47% INFERRED · 0% AMBIGUOUS · INFERRED: 116 edges (avg confidence: 0.5)
- Token cost: 0 input · 0 output

## God Nodes (most connected - your core abstractions)
1. `main()` - 11 edges
2. `render_transcript_markdown()` - 10 edges
3. `upsert_conversation()` - 8 edges
4. `_render_quick_summary()` - 8 edges
5. `_clean_text()` - 7 edges
6. `_extract_conversations_from_traj()` - 7 edges
7. `find_sessions()` - 7 edges
8. `extract_conversation()` - 7 edges
9. `main()` - 7 edges
10. `extract_conversation()` - 7 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Communities

### Community 0 - "Community 0"
Cohesion: 0.16
Nodes (24): _append_section(), _append_text_block(), build_search_entry(), build_subagent_index(), clean_project_label(), extract_command_mentions(), extract_file_mentions(), extract_signal_mentions() (+16 more)

### Community 1 - "Community 1"
Cohesion: 0.16
Nodes (23): _build_search_index(), _build_transcript_stem(), _clean_metadata_text(), _content_hash(), _default_markdown_dir(), export_antigravity(), export_claude(), export_codex() (+15 more)

### Community 2 - "Community 2"
Cohesion: 0.21
Nodes (19): _append_message(), _clean_text(), _collect_brain_artifacts(), _decode_value(), _extract_artifact_heading(), _extract_conversations_from_traj(), _extract_json_objects(), _extract_messages_from_chunk() (+11 more)

### Community 3 - "Community 3"
Cohesion: 0.18
Nodes (17): _clean_text(), decode_project_name(), _extract_assistant_text(), extract_conversation(), _extract_user_text(), find_sessions_by_date(), format_conversation(), _is_noise() (+9 more)

### Community 4 - "Community 4"
Cohesion: 0.2
Nodes (16): _clean_text(), extract_conversation(), _extract_from_history(), find_sessions_by_date(), format_conversation(), _is_system_noise(), load_history_for_session(), load_thread_titles() (+8 more)

### Community 5 - "Community 5"
Cohesion: 0.47
Nodes (5): build_mapping(), main(), parse_frontmatter(), Extract YAML frontmatter fields we care about (project_ref, aliases)., Return {alias_lower: (project_ref, brief_path)} for all projects.

### Community 6 - "Community 6"
Cohesion: 0.53
Nodes (4): combineGraphs(), extractDotBlocks(), main(), renderToSvg()

### Community 7 - "Community 7"
Cohesion: 0.53
Nodes (4): build_html(), _json_for_html_script(), main(), run_export()

### Community 8 - "Community 8"
Cohesion: 0.7
Nodes (4): infer_agent(), infer_project(), infer_title(), main()

### Community 9 - "Community 9"
Cohesion: 0.67
Nodes (3): main(), Generate speech from text using edge-tts., speak()

### Community 10 - "Community 10"
Cohesion: 0.67
Nodes (3): main(), Transcribe audio file using faster-whisper., transcribe()

### Community 11 - "Community 11"
Cohesion: 1.0
Nodes (0): 

### Community 12 - "Community 12"
Cohesion: 1.0
Nodes (0): 

### Community 13 - "Community 13"
Cohesion: 1.0
Nodes (0): 

## Knowledge Gaps
- **23 isolated node(s):** `Extract YAML frontmatter fields we care about (project_ref, aliases).`, `Return {alias_lower: (project_ref, brief_path)} for all projects.`, `Generate speech from text using edge-tts.`, `Transcribe audio file using faster-whisper.`, `基于 messages 生成内容哈希，用于判断会话是否有变化` (+18 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 11`** (1 nodes): `render-writer-package.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 12`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 13`** (1 nodes): `convs.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Are the 10 inferred relationships involving `main()` (e.g. with `load_index()` and `save_index()`) actually correct?**
  _`main()` has 10 INFERRED edges - model-reasoned connections that need verification._
- **Are the 9 inferred relationships involving `render_transcript_markdown()` (e.g. with `get_subagent_display_name()` and `build_subagent_index()`) actually correct?**
  _`render_transcript_markdown()` has 9 INFERRED edges - model-reasoned connections that need verification._
- **Are the 6 inferred relationships involving `upsert_conversation()` (e.g. with `_preserve_existing_fields()` and `_sanitize_conversation_metadata()`) actually correct?**
  _`upsert_conversation()` has 6 INFERRED edges - model-reasoned connections that need verification._
- **Are the 7 inferred relationships involving `_render_quick_summary()` (e.g. with `clean_project_label()` and `extract_file_mentions()`) actually correct?**
  _`_render_quick_summary()` has 7 INFERRED edges - model-reasoned connections that need verification._
- **Are the 6 inferred relationships involving `_clean_text()` (e.g. with `_extract_title()` and `_normalize_title_candidate()`) actually correct?**
  _`_clean_text()` has 6 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Extract YAML frontmatter fields we care about (project_ref, aliases).`, `Return {alias_lower: (project_ref, brief_path)} for all projects.`, `Generate speech from text using edge-tts.` to the rest of the system?**
  _23 weakly-connected nodes found - possible documentation gaps or missing edges._