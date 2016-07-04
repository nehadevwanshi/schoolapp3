/**
 * Created by Nicole_Zhou on 6/29/16.
 */
var data = $('#location').val();
var data1 = JSON.parse(data);
console.log(data1[0]);

var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 17,
    center: new google.maps.LatLng(37.335268, -121.881361),
    mapTypeId: google.maps.MapTypeId.ROADMAP
});

var infowindow = new google.maps.InfoWindow();

var marker, i;

for(var i =0; i < data1.length; i++) {
    console.log(data1[i]['Lat']);
    console.log(data1[i]['Lng']);
    marker = new google.maps.Marker({
    position: new google.maps.LatLng(data1[i]['Lng'] , data1[i]['Lat']),
    map: map
});

google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
            infowindow.setContent(item[i][0]);
            infowindow.open(map, marker);
        }
    })(marker, i));
}
