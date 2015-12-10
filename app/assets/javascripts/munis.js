$(document).ready(function(){

  var options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  };

  function success(pos) {
    var crd = pos.coords;
    compareBusData(crd);
  };

  function error(err) {
    console.warn('ERROR(' + err.code + '): ' + err.message);
  };

  var compareBusData = function(coords){

    $.ajax({
      url: "http://proximobus-1135.appspot.com/agencies/sf-muni/vehicles.json",
    }).done(function(data){
      var closest = [];
      var vehicles = data.items;
      for (var i = 0; i < vehicles.length; i++) {
        var latDiff = coords.latitude - vehicles[i].latitude;
        var lngDiff = coords.longitude - vehicles[i].longitude;
        //temporary change of latdiff
        // if ((latDiff <= 0.003 && latDiff >= -0.003) && (lngDiff <= 0.003 && lngDiff >= -0.003)) {
        if ((latDiff <= 0.005 && latDiff >= -0.005) && (lngDiff <= 0.005 && lngDiff >= -0.005)) {

          closest.push(vehicles[i]);
        }
      }
      $('#route_name_tag').text(closest[0].route_id);
      $('#route_name').val(closest[0].route_id);
      getAverages(closest[0]);
      
    });

  }

  var getAverages = function(name){
    if (!(typeof name === "undefined")) {
      $.ajax({
        url: '/munis/' + name.route_id + '/average'
      }).done(function(content){
        $('#driver-score').prepend('<img id="Driver_img" src="http://localhost:3000/assets/Driver_0' + content.avg_driver_rating + '.png" />');
        $('#smell-score').prepend('<img id="Smell_img" src="http://localhost:3000/assets/Smell_0' + content.avg_smell_rating + '.png" />');
        $('#clean-score').prepend('<img id="Clean_img" src="http://localhost:3000/assets/Clean_0' + content.avg_clean_rating + '.png" />');
      });
    }
  }
  navigator.geolocation.getCurrentPosition(success, error, options);

});
