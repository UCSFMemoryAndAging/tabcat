###
Copyright (c) 2013, Regents of the University of California
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

patient = require('./patient')
adhocLineTasksReport = require('./adhoc/line-tasks-report')
adhocStargazerReport = require('./adhoc/stargazer-report')
adhocFlankerReport = require('./adhoc/flanker-report')

# stitch together data from the patient view
dumpList = (head, req) ->
  keyType = req.path[req.path.length - 1]

  if not (req.path.length is 6 and keyType is 'patient')
    throw new Error('You may only dump the patient view')

  start(headers:
    'Content-Type': 'application/json')

  send('[\n')

  numRecords = 0

  patientHandler = (patientRecord) ->
    if numRecords > 0
      send(',\n')
    send(JSON.stringify(patientRecord, null, 2))
    numRecords += 1

  patient.iterate(getRow, patientHandler)

  send('\n]\n')


validateDocUpdate = (newDoc, oldDoc, userCtx, secObj) ->
  if newDoc.user?
    if newDoc.user[newDoc.user.length - 1] is '?'
      if not (newDoc.uploadedBy? and newDoc.uploadedBy is userCtx.name)
        throw {forbidden: 'uploadedBy must match current user'}
    else
      if newDoc.user isnt userCtx.name
        throw {forbidden: 'user must match current user, or end with "?"'}


exports.lists =
  dump: dumpList
  'adhoc-line-tasks-report': adhocLineTasksReport.list
  'adhoc-stargazer-report': adhocStargazerReport.list
  'adhoc-flanker-report': adhocFlankerReport.list
  
exports.validate_doc_update = validateDocUpdate

exports.views =
  patient:
    map: patient.map
