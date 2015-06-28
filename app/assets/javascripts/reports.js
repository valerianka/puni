$(document).ready(function(){

  $('#report-form').submit(function(event){
    event.preventDefault;

  //   console.log('hello my friend');
  //   console.log($('#route-name').html())

  //   var formData = {asdf_name: 7,
  //                   smell_rating: $('#smell-slider').val(),
  //                   clean_rating: $('#clean-slider').val(),
  //                   driver_rating: $('#driver-slider').val()};

  //   $.ajax({
  //       url: '/create_report',
  //       type: 'POST',
  //       data: formData,
  //   }).done(function(){
  //     window.location.href = '/munis/stinkchamp';
  //   });
  // })

  window.location.href = '/munis/stinkchamp';

});