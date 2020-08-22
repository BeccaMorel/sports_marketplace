import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

  const userLong = mapElement.dataset.userLongitude;
  const userLat = mapElement.dataset.userLatitude;

  const isUserLocationPresent = (userLong && userLat);

  const mapAttributes = {
    container: "map",
    style: 'mapbox://styles/mapbox/streets-v10'
  }

  if (isUserLocationPresent) {
    mapAttributes.center = [userLong, userLat];
    mapAttributes.attributionControl = false;
    mapAttributes.zoom = 12
  }

  const map = new mapboxgl.Map(mapAttributes);

  const markers = JSON.parse(mapElement.dataset.markers);

  markers.forEach((marker) => {
    if (marker.infoWindow !== "") {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    }
  });

  if (!isUserLocationPresent) {
    fitMapToMarkers(map, markers);
  }

  map.addControl(new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl
  }));
}

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

export { initMapbox };
