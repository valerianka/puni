$(document).ready(function(){

  var options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  };

  function success(pos) {
    var crd = pos.coords;
    compareBusData(crd);


    console.log('Your current position is:');
    console.log('Latitude : ' + crd.latitude);
    console.log('Longitude: ' + crd.longitude);
  };

  function error(err) {
    console.warn('ERROR(' + err.code + '): ' + err.message);
  };

  var compareBusData = function(coords){
    $.ajax({
      url: "http://proximobus.appspot.com/agencies/sf-muni/vehicles.json",
    }).done(function(data){
      var closest = [];
      var vehicles = data.items;
      console.log(data.items.length);
      for (var i=0; i < vehicles.length; i++) {
        var latDiff = coords.latitude-vehicles[i].latitude;
        var lngDiff = coords.longitude-vehicles[i].longitude;
        if ((latDiff <= 0.003 && latDiff >= -0.003) && (lngDiff <= 0.003 && lngDiff >= -0.003)) {
          closest.push(vehicles[i]);
          console.log(closest.length);
        }
      }
      var routeNumber = closest[0].route_id
      $('#route-name').text(routeNumber);
      getAverages(routeNumber);
    });
  }

  var getAverages = function(name){
    $.ajax({
      url: '/munis/' + name + '/average'
    }).done(function(content){
      console.log('hello');
      console.log(content);
      $('#stink-score').text(content.smell);
      $('#filth-score').text(content.clean);
    })
  }

  navigator.geolocation.getCurrentPosition(success, error, options);

});
