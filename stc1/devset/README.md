# Development set for NTCIR STC Japanese subtask

## Overview

This is the data set of tweet pairs annotated with appropriateness of
replies.  Annotations are perfomed by crowdsourcing with at most 10
annotators.

Original posts (data in the first column) are randomly chosen from
tweets in 2015, while reply candidates (data in the second column) are
taken from the task data (data provided in the directory `taskdata`).

## Data format

The data set is provided as tweet pairs with annotated labels in the
following format:

```
TWEET1A TWEET1B LABEL1-1 LABEL1-2 ...
TWEET2A TWEET2B LABEL2-1 LABEL2-2 ...
...
```

Tweets in the first column are original posts, while those in the
second column are tweets that a baseline system retrieved as a reply
from the task data.

Each tweet pair is manually labeled with 0, 1, or 2:

* 0: The reply does not make sense.
* 1: The reply is possibly reasonable in some context.
* 2: The reply is good.

At most 10 annotations are given to each pair.  Some labels are
'NA', which indicates that an annotator judged the original post is
meaningless.  These annotations are retained in the provided data,
while we'll remove such labels from final evaluation.

