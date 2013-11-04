(function(window, $) { 
  // Generate the public & private keypair and store the private key in the
  // browser local storage.
  window.generateKeys = function() {
    var keySize = 1024;
    crypt = new JSEncrypt({default_key_size : keySize});
    var dt = new Date();
    var time = - (dt.getTime());
    crypt.getKey(function(){
        dt = new Date();
        time += (dt.getTime());
        
        $('#loader').hide();
        $('#time-report').text('Generated in '+time+' ms');

        localStorage.setItem("privatekey", crypt.getPrivateKey());

        $('#user_public_key').val(crypt.getPublicKey());
        $("#new_user").submit();
    });
  }
})(window, $);
