# Idiomaticity rubrics

Each language has a manual scoring rubric, designed to evaluate the idiomaticity, both paradigmatic and language-specific, of each program. Every rubric has 6 items, where each item has a score from 0-2. Therefore, the maximum score for a single program is 12.

## Evaluation

For a run's results, create the file `{run_id}_rubric.csv` inside the results folder. The file must have the following columns:

```
problem,src,tgt,item1,item2,item3,item4,item5,item6
```

Each `itemN` describes the score, from 0-2, of the `N`th item in the rubric. `src` and `tgt` must match the language names given in [matrix.json](../pipeline/matrix.json).

For example, a row may look like:

```
p01_rle,java,scheme,2,2,0,1,0,0
```

Do not add columns; this CSV is intended to be the raw output. [evals/aggregate.py](./aggregate.py) will analyze the results.
