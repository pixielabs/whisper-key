(function(window, $) { 

  window.pollForMessages = function() {

    var fetch = function () {
      $.ajax({
        url: document.location,
        cache: false,
        success: function(html) {
          $("#messages-container").html(html);
        },
        error: function() {
          $status.text("Something went wrong");            
        }
      });
    };

    setInterval(fetch, 5000);
  };

  $(function() {
    var clipboard = new Clipboard('#js-clipboard');

    clipboard.on('success', function(e) {
      $('#js-clipboard').html('Copied!');

      e.clearSelection();
    });

    clipboard.on('error', function(e) {
      $('#js-clipboard').html('Sorry, something went wrong!');
    });
  });

  $(function() {

    $("#show-public-key").click(function(e) {
      e.preventDefault();

      alert($(this).data('key'));
    });

  });


})(window, $);
