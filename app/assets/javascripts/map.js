/**
 * Created by Fred on 2017-02-21.
 */
function loadMap(map_json) {
    mapboxgl.accessToken = 'pk.eyJ1IjoiZnJlZGxhYjciLCJhIjoiY2l5a2R6OTNyMDAxMzJxcGZ0N3BiZHg4NCJ9.yy7iToUoptoBI9Sh3CHkbg';

    var bounds = [
        [-71.2912, 46.7840], // Southwest coordinates
        [-71.2845, 46.7886]  // Northeast coordinates
    ];

    var map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v9',
        center: [-71.28739276585, 46.78611111111],
        zoom: 18,
        maxBounds: bounds
    });

    map.on('load', function () {
        j = map_json.length;
        z = (map_json.length) * 2;

        for (i = 0; i < map_json.length; i++) {

            map.addLayer({
                "id": i.toString(),
                "type": "line",
                "source": {
                    "type": "geojson",
                    "data": map_json[i]
                }, "layout": {
                    "line-join": "round"
                },
                "paint": {
                    "line-color": "#009688",
                    "line-width": 1
                }
            });

            map.addLayer({
                "id": j.toString(),
                "type": "symbol",
                "source": {
                    "type": "geojson",
                    "data": map_json[i]
                },
                "layout": {
                    "text-field": "{ref}",
                    "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
                    "text-offset": [0, 0.6]
                },
                "filter": ["==", "type", "image"]
            });

            map.addLayer({
                "id": z.toString(),
                "type": "circle",
                "source": j.toString(),
                "paint": {
                    "circle-radius": 3,
                    "circle-color": "#009688"
                },
                "filter": ["==", "type", "doors"]
            });

            j++;
            z++;
        }
    });
}