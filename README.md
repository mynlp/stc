# Shared Task on Short Text Conversation

This repository provides data for NTCIR STC (Short Text Conversation)
Japanese subtask.  For the details of the shared task, refer to the
[STC homepage](http://ntcir12.noahlab.com.hk/stc.htm).

## Provided data

- `taskdata`: Data from which tweets are to be retrieved. 
  Provided tweets were randomly sampled from all the tweets in 2014
  (around 1 million tweets).
- `devset`: Development data.  For each input tweet, a baseline system
  retrieved tweets from `taskdata`.  Each tweet pair is labeled by 10
  annotators.

Tweets are provided as tweet IDs (id_str).  Download original texts
using twitter API, or buy the data by contacting the following
address:

Email: info<at>nazuki-oto.com
Dataset name: NTCIR STC Japanese subtask data set

