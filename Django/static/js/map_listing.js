(function(A) {
	if (!Array.prototype.forEach)
		A.forEach = A.forEach || function(action, that) {
			for (var i = 0, l = this.length; i < l; i++)
				if (i in this)
					action.call(that, this[i], i, this);
			};

		})(Array.prototype);

        function hideAllMarkers () {
            for (var key in markers)
                markers[key].forEach(function (marker) {
                    marker.setMap(null);
                });
        };
        
        function toggleMarkers (category) {
            hideAllMarkers();
            closeInfoBox();

            if ('undefined' === typeof markers[category])
                return false;
            markers[category].forEach(function (marker) {
                marker.setMap(mapObject);
                marker.setAnimation(google.maps.Animation.DROP);

            });
        };

        function closeInfoBox() {
            $('div.infoBox').remove();
        };

        function getInfoBox(item) {
            return new InfoBox({
                content:
                '<div class="marker_info">' +
                '<figure><a href='+ item.url_detail +'><img src="' + item.map_image_url + '" alt="Image"></a></figure>' +
                '<small>'+ item.type +'</small>' +
                '<h3><a href='+ item.url_detail +'>'+ item.name_point +'</a></h3>' +
                '<div class="marker_tools">' +
                '<form action="http://maps.google.com/maps" method="get" target="_blank" style="display:inline-block""><input name="saddr" value="'+ item.get_directions_start_address +'" type="hidden"><input type="hidden" name="daddr" value="'+ item.location_latitude +',' +item.location_longitude +'"><button type="submit" value="Get directions" class="btn_infobox_get_directions">Directions</button></form>' +
                    '<a href="tel://'+ item.phone +'" class="btn_infobox_phone">'+ item.phone +'</a>' +
                    '</div>' +
                '</div>',
                disableAutoPan: false,
                maxWidth: 0,
                pixelOffset: new google.maps.Size(10, 105),
                closeBoxMargin: '',
                closeBoxURL: "{% static 'img/close_infobox.png' %}",
                isHidden: false,
                alignBottom: true,
                pane: 'floatPane',
                enableEventPropagation: true
            });
        };
        
        function onHtmlClick(location_type, key){
            console.log("onHTMLClick markers",markers);
    google.maps.event.trigger(markers[location_type][key], "click");
}
	