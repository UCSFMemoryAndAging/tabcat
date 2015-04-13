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


# norms as of 2014-08-16
TASK_TO_NORMS =
  'line-orientation': [
    {
      cohort:
        minAge: 40
        maxAge: 70
      mean: 5.0
      n: 18
      stddev: 1.8
    }, {
      cohort:
        minAge: 71
        maxAge: 91
      mean: 5.6
      n: 19
      stddev: 1.4
    }
  ],
  'parallel-line-length': [
    {
      cohort:
        minAge: 50
        maxAge: 70
      mean: 4.1
      n: 18
      stddev: 1.9
    }, {
      cohort:
        minAge: 71
        maxAge: 91
      mean: 4.8
      n: 19
      stddev: 2.0
    }
  ],
  'perpendicular-line-length': [
    {
      cohort:
        minAge: 50
        maxAge: 70
      mean: 11.0
      n: 18
      stddev: 5.1
    }, {
      cohort:
        minAge: 71
        maxAge: 91
      mean: 12.1
      n: 19
      stddev: 4.5
    }
  ]



# everything is scored the same way: mean intensity at reversal, dropping
# the first two
makeScorer = (taskName) ->
  (eventLog) ->
    intensitiesAtReversal = (
      item.state.intensity for item in eventLog \
      when item?.interpretation?.reversal)

    score =
      description: 'Spatial Perception'
      lessIsMore: true
      value: gauss.Vector(intensitiesAtReversal[2..]).mean()

    if TASK_TO_NORMS[taskName]?
      score.norms = TASK_TO_NORMS[taskName]

    return {scores: [score]}


Scoring.addTaskScorer('parallel-line-length',
  makeScorer('parallel-line-length'))
Scoring.addTaskScorer('perpendicular-line-length',
  makeScorer('perpendicular-line-length'))
Scoring.addTaskScorer('line-orientation',
  makeScorer('line-orientation'))
