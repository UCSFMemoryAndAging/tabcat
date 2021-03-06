###
Copyright (c) 2014, Regents of the University of California
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

  1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###

if module?  # inside CouchDB
  gauss = require('js/vendor/gauss/gauss')
  Scoring = require('js/tabcat/scoring')
else
  gauss = @gauss
  Scoring = TabCAT.Scoring


#fake normative data for now
TASK_TO_NORMS =
  'digit-symbol': [
    {
      cohort:
        minAge: 50
        maxAge: 91
        meanAge: 70
      mean: 87.5
      n: 49
      stddev: 5.0
      education:
        mean: 17.0
        stdev: 2.0
    }
  ]

makeScorer = (taskName) ->
  (eventLog) ->

    trials = (item.interpretation?.correct for item in eventLog \
      when not item?.state?.practiceMode )

    totalCorrect = trials.filter((x)-> x if x == true).length
    totalIncorrect = trials.length - totalCorrect

    score =
      description: 'Correct / Incorrect'
      lessIsMore: false
      value: totalCorrect + " / " + totalIncorrect

    if TASK_TO_NORMS[taskName]?
      score.norms = TASK_TO_NORMS[taskName]

    return {scores: [score]}

Scoring.addTaskScorer('digit-symbol',
  makeScorer('digit-symbol'))
