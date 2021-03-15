var request = require('request');
var fs = require('fs');
var formData = {
  file : fs.createReadStream(`ny${Math.floor(Math.random()*5)+1}.xls`),
};

request.post(
    {
        url : 'http://127.0.0.1:4000/api/uppladdning',
      headers : {'Content-Type' : 'multipart/form-data'},
      formData : formData
    },
    function optionalCallback(err, httpResponse, body) {
      if (err) {
        return console.error('upload failed:', err);
      }
      console.log('Upload successful!  Server responded with:', body);
    });
