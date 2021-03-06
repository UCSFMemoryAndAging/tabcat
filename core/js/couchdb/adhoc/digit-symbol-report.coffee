###
Copyright (c) 2013-2015, Regents of the University of California
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

_ = require('js/vendor/underscore')._
csv = require('js/vendor/ucsv')
patient = require('../patient')
report = require('./report')

#the reporting columns will be based on correct answers
#and errors in every 15 second interval
REPORTING_INTERVAL = 15

SECONDS_IN_TRIAL = 120

MAX_INTERVALS = SECONDS_IN_TRIAL / REPORTING_INTERVAL

makeHeaders = (prefix) ->
  prefix + (i - 1) * REPORTING_INTERVAL + 'to' + i * REPORTING_INTERVAL \
    for i in [1..MAX_INTERVALS]

columns = [
  'subject_id',
  'version',
  'session_date',
  'machine',
  'Form',
].concat(report.DATA_QUALITY_HEADERS
).concat(makeHeaders('corr_')
).concat(makeHeaders('errors_'))

patientHandler = (patientRecord) ->
  patientCode = patientRecord.patientCode
  taskInfo = {}
  for encounter in patientRecord.encounters
    for task in encounter.tasks
      if task.finishedAt and task.eventLog? and task.name is 'digit-symbol'
        # only keep the first task per patient
        if taskInfo['digit-symbol']
          continue

        correct = []
        errors = []

        intervalRange = [1..MAX_INTERVALS]

        for val in intervalRange
          do ( ->
            from = (val - 1) * REPORTING_INTERVAL
            to = val * REPORTING_INTERVAL
            corr = (
              item.interpretation?.correct for item in task.eventLog \
                when item.interpretation?.correct is true \
                  and from < item.state?.secondsSinceStart <= to
            )

            correct = correct.concat(corr.length)

            err = (
              item.interpretation?.correct for item in task.eventLog \
                when item.interpretation?.correct is false \
                  and from < item.state?.secondsSinceStart <= to
            )
            errors = errors.concat(err.length)
          )

        firstAction = _.find(task.eventLog, (item) -> item?.interpretation?)
        totalTime = null
        if (firstAction)
          totalTime = (task.finishedAt - firstAction.now) / 1000

        taskInfo['digit-symbol'] = [
          patientCode,
          report.getVersion(task),
          report.getDate(task),
          report.getMachine(task),
          report.getForm(task)
        ].concat(report.getDataQualityCols(encounter)
        ).concat(correct).concat(errors)

  if _.isEmpty(taskInfo)
    return

  # replace undefined with null, so arrayToCsv() works
  data = taskInfo['digit-symbol']
  data = (x ? null for x in data)

  send(csv.arrayToCsv([data]))

exports.list = (head, req) ->
  report.requirePatientView(req)
  start(headers: report.csvHeaders('digit-symbol-report'))

  send(csv.arrayToCsv([columns]))

  patient.iterate(getRow, patientHandler)
