const path = require('path')
const { STATUS_CODES } = require('http')

exports.handler = (evt, ctx, cb) => {
  const { request } = evt.Records[0].cf

  const htmlExtRegex = /(.*)\.html?$/
  if (htmlExtRegex.test(request.uri)) {
    const uri = request.uri.replace(htmlExtRegex, '$1')
    return cb(null, redirect(uri))
  }

  if (!path.extname(request.uri)) {
    request.uri = '/index.html'
  }

  cb(null, request)
}

function redirect (to) {
  return {
    status: '301',
    statusDescription: STATUS_CODES['301'],
    headers: {
      location: [{ key: 'Location', value: to }]
    }
  }
}
