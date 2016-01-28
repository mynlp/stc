# Shared Task on Short Text Conversation

This repository provides the datasets for NTCIR STC (Short Text Conversation)
Japanese subtask.  For the details of the shared task, refer to the
[STC homepage](http://ntcir12.noahlab.com.hk/stc.htm).

## Provided datasets

- `taskdata`: Data from which tweets are to be retrieved. 
  Provided tweets were randomly sampled from all the tweets in 2014
  (1 million tweets; .5 million tweet pairs).
- `devset`: Development data.  For each input tweet, a baseline system
  retrieved tweets from `taskdata`.  Each tweet pair is labeled by 10
  annotators.

Tweets are provided as tweet IDs (id_str).  Download original texts
using twitter API, or buy the data by contacting the following
address:

* Email: info`<at>`nazuki-oto.com
* Dataset name: NTCIR STC Japanese subtask data set

## Schedule

* Release of the Twitter data and starts accepting registration: Nov 01, 2015
* Release of the development data: ~~Nov 20, 2015~~ Nov 24, 2015
* Registration deadline of STC Japanese task: Jan 15, 2016
* Release of the test data: Feb 15, 2016
* Formal run deadline: Feb 22, 2016
* Distribution of evaluation results: Mar 10, 2016
* Paper draft deadline: Mar 20, 2016
* (brief review of the draft papers)
* Camera ready deadline: May 1, 2016
* NTCIR-12 conference: Jun 7-10, 2016

## Change log

* Nov. 1, 2015: Twitter data (task data) released
* Nov. 24, 2015:
  * Task data fixed (some pairs are randomly removed so that the task data
    contains exactly one million tweets)
  * Development data released

