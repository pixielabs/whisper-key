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

    $("#show-public-key").click(function(e) {
      e.preventDefault();

      alert($(this).data('key'));
    });

  });


})(window, $);
