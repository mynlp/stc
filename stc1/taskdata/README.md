# Task data for NTCIR STC Japanese subtask

## Overview

This is the data from which tweets are to be retrieved.  That is,
given an input tweet, a system is required to search this data set for
a tweet that is appropriate as a reply to the input tweet.

The tweet data were randomly sampled from all the tweets in 2014
(around 1 million tweets).  Development and test data will be chosen
from tweets in 2015.

- `twitter_id_str_data.txt.bz2`: The ID pairs of tweets (see "Data
  format" for details)
- `deleted_tweets_20160204.txt.bz2`: The ID list of tweets deleted
  after the release of `twitter_id_str_data.txt.bz2` (see "Deleted
  tweets" for details)

## Data format

The data set is provided as tweet pairs in the following format:

```
TWEET1A TWEET1B
TWEET2A TWEET2B
...
```

Tweets in the first column are original posts, while those in the
second column are replies to the first tweet.  You may want to use
this information for the development of your system, but this is not
obligatory.  In the formal run, we will consider this data set as
simply a set of tweets.

## Deleted tweets

We provide the list of tweets that have been deleted at Feb. 4, 2016.
These tweets are excluded from the target of the retrieval of
replies.

