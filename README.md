# Lost Across Paradigms

Evaluating LLM-based code migration within and between programming paradigms.
CS 152 (Programming Paradigms), SJSU, Fall 2026. Authors: Ellen Moon, Ryuto Kawabata.

Proposal: `CS_152_Project_Proposal.pdf` (Canvas). Task board: [CS152 Kanban](https://github.com/users/05ryt31/projects/5).

## Roadmap

Course dates that drive the plan: Exam 1 Oct 8, mid-semester check-in Oct 22 (10 %, recorded video + per-student docs),
Exam 2 Nov 19, presentations Nov 24 / Dec 1 / Dec 3 (50 %), technical report Dec 3 (30 %).

| Milestone | Weeks | Dates | Goal | Exit criteria |
|---|---|---|---|---|
| [M1 Foundation](https://github.com/05ryt31/CS152-Project/milestone/1) | 6-8 | Sep 22 - Oct 5 | Benchmark, harness, frozen prompt/model config, pipeline skeleton | Harness runs Python references in all 6 runtimes; `MODEL.md`, `prompts/v1.md`, `matrix.json` committed |
| [M2 Intra-paradigm + check-in](https://github.com/05ryt31/CS152-Project/milestone/2) | 8-10 | Oct 6 - Oct 22 | First results, rubrics, check-in | Intra-paradigm matrix produced; rubrics v1 drafted; check-in video + docs submitted Oct 22 |
| [M3 Inter-paradigm + advisor](https://github.com/05ryt31/CS152-Project/milestone/3) | 10-13 | Oct 16 - Nov 16 | Finetune (or fallback), full matrix, manual scoring, advisor | Every pair in `matrix.json` run and scored; advisor evaluated; done before Exam 2 |
| [M4 Analysis + deliverables](https://github.com/05ryt31/CS152-Project/milestone/4) | 14-16 | Nov 17 - Dec 3 | RQ1-RQ4 answers, slides, report, release | Slides by Nov 20, report draft Nov 28, final Dec 3 |

### Week-by-week

| Week | Dates | Focus | Course context |
|---|---|---|---|
| 6 | Sep 22 - 28 | Decide: problem list, test format, Scheme impl, model + fallback. Repo skeleton, runtime env. | Paradigms basics; Assignment 2 set |
| 7 | Sep 29 - Oct 5 | Python references + tests. Harness core + 6 runners. Prompt template, matrix, pipeline smoke test. | Assignment 2 due Sep 29; Quiz 2 Oct 1 |
| 8 | Oct 6 - 12 | Light week (Exam 1 Oct 8). Run intra-paradigm pairs. Draft rubrics. Start check-in doc. | Exam 1 Oct 8 |
| 9 | Oct 13 - 19 | Aggregation script, first heatmap. Check-in slides draft by Oct 19; register for Oct 22 event. | Lambda calculus |
| 10 | Oct 20 - 26 | Record check-in video by Oct 21; submit video + Career-Connect + event reflection Oct 22. Finetuning run, static heuristics. | Scheme; Assignment 3 set; check-in due Oct 22 |
| 11 | Oct 27 - Nov 2 | Finetune go/no-go by Oct 31. Begin inter-paradigm runs. | Haskell; Assignment 3 due Oct 29 |
| 12 | Nov 3 - 9 | Finish inter-paradigm runs. Inter-rater scoring sample, kappa, rubric fixes. | Functional Python; Quiz 3; Assignment 4 set |
| 13 | Nov 10 - 16 | Score remaining outputs. Advisor prototype + evaluation. Failure taxonomy. | Functional JS; Assignment 4 due Nov 12 |
| 14 | Nov 17 - 23 | Light week (Exam 2 Nov 19). Final analysis, slides draft by Nov 20. | Prolog Nov 17; Quiz 4; Exam 2 |
| 15 | Nov 24 - 30 | Presentation (if Nov 24). Report writing. | Thanksgiving Nov 26 |
| 16 | Dec 1 - 3 | Presentation (Dec 1 or 3). Report final Dec 3. Release tag. | Report due Dec 3 |

### Risks

- **Finetuning** is the largest unknown. Decide compute and method by Oct 5 (#13); hard fallback to base model + few-shot on Oct 31 (#25).
- **Source programs in five non-Python languages** could be ~100 programs. Decide the hybrid strategy in #7 before writing any.
- **Manual rubric scoring** scales with outputs x raters. Cap the overlap sample at ~20 % and use static heuristics (#21) for the rest.
- Weeks 8 and 14 hold exams; nothing critical is scheduled there.

## Division of work

To be decided by the team. The proposal suggests: Ellen leads the test harness and Scheme/Haskell rubrics;
Ryuto leads the migration pipeline, Prolog rubric, and advisor; benchmark design, analysis, and report are shared.
Each issue carries a "Suggested lead" line based on this.

## Layout (planned)

```
benchmark/   problem specs, reference programs, tests.json per problem
harness/     runner core + one adapter per language
pipeline/    prompt templates, matrix.json, migration batch runner, MODEL.md
eval/        rubrics, static heuristics, scoring sheets
advisor/     paradigm advisor prototype
results/     raw outputs (by run id) and aggregated CSV/figures
report/      check-in, slides, technical report
```
