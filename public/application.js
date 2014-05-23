$( document ).ready(function() {

  $( "#hit" ).click(function() {
    $.ajax({
      url: "/game/hit",
      success: function(data) {
        var my_img = $(data).filter("img");
        $("#player-cards").append(my_img);

        var my_label = $(data).filter("label");
        $("#points").replaceWith(my_label);

        var my_report = $(data).filter("#result-zone");
        if (my_report.length) {
          $("#player-table").after(my_report);
        }

        var my_action = $(data).filter("#action-zone");
        if (my_action.length) {
          $("#action-zone").replaceWith(my_action);
        }
      }
    });
  });

  $("#stay").click(function() {
    $.ajax({
      url: '/game/stay',
      success: function(data) {
        $("#dealer-cards").replaceWith($(data).filter("#dealer-cards"));
        $("#player-table").after($(data).filter("#result-zone"));
        $("#action-zone").replaceWith($(data).filter("#action-zone"));
      }
    });
  });

});
