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
SANDBOX_USER = 's@ndbox'
SANDBOX_PASSWORD = 's@ndbox'


submitEnterPasswordForm = (event) ->
  event.preventDefault()
  form = $(event.target)
  errorP = form.find('#error')

  password = form.find('input[name=password]').val()
  if not password
    errorP.text('Please enter your password')
    return

  TabCAT.UI.login(null, password).then(
    null,
    (xhr) -> switch xhr.status
      when 401 then errorP.text(
        'Incorrect email or password')
      else errorP.text(xhr.textStatus or 'Unknown error')
  )


@initPage = ->
  TabCAT.UI.enableFastClick()
  TabCAT.UI.turnOffBounce()

  user = TabCAT.User.get()
  if not user?
    window.location = 'login.html'
    return

  $(->
    $('#howToLogout').text(
      'Not ' + user + '? Tap the Log Out button (in the upper right)' +
      ' to log in as a different user.')

    $loginForm = $('#loginForm')
    $loginForm.find('input[name=email]').val(user)

    if TabCAT.UI.inSandbox() and user is SANDBOX_USER
      $loginForm.find('input[name=password]').val(SANDBOX_PASSWORD)

    $loginForm.on('submit', submitEnterPasswordForm)
    $loginForm.find('button').removeAttr('disabled')
  )
  $(TabCAT.UI.updateStatusBar)
