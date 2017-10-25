var map;
var fusionLayerInfoWindow;
function drawMap_Baidu() {

	map = new BMap.Map("map_div", {}); // ����Mapʵ��
	map.centerAndZoom(new BMap.Point(-76.609, 39.395), 8); // ��ʼ����ͼ,�������ĵ�����͵�ͼ����
	map.enableScrollWheelZoom(); // ���ù��ַŴ���С
	if (document.createElement('canvas').getContext) { // �жϵ�ǰ������Ƿ�֧�ֻ��ƺ�����
		var points = []; // ��Ӻ���������
		for ( var i = 0; i < data.data.length; i++) {
			var p = new BMap.Point(data.data[i].lng, data.data[i].lat);
			p.sId = data.data[i].sId;
			p.siteName = data.data[i].siteName;
			p.area = data.data[i].area;
			p.impervious = data.data[i].impervious;
			points.push(p);
		}
		console.log(points)
		var options = {
			size : BMAP_POINT_SIZE_BIG,
			shape : BMAP_POINT_SHAPE_STAR,
			color : '#ff0000'
		}
		var pointCollection = new BMap.PointCollection(points, options); // ��ʼ��PointCollection
		pointCollection.addEventListener('click', function(e) {

			// ��event�л�ȡ�����վ�����Ϣ
			var sId = String(e.point.sId);
			var siteName = e.point.siteName;
			// TODO: At some point it will be necessary to create a system that
			// requests IV or Daily Values.
			// USGS�������ʿ�̽�֣�United States Geological Survey��
			// Many of the USGS sites don't have their Source set yet, so
			// automatically set to 'USGS-DV' if empty.
			// ���usgsվ��û��������Դ�����Ե���ԴΪ��ʱ����Դ�Զ�������Ϊ'USGS-DV'
			var source = e.point.source || 'USGS-DV';
			// TODO: Some USGS sites have Source set to 'USGS', which is not in
			// the providerList right now.
			// ��Щusgsվ���ԴΪ��usgs������������providerList��������
			if (source == 'USGS')
				source = 'USGS-DV';
			var prefix = providerList[source].idPrefix;
			sId = prefix + sId;
			var siteDict = {
				id : sId,
				name : siteName || null,
				area : +e.point.area || null,
				impervious : +e.point.impervious || null
			};

			// Update our viewModel with the current site information.
			// �õ����ȡ��ʵʱ���ݸ���viewModel
			viewModel.siteId(sId);
			viewModel.siteName(siteName);

		
			fusionLayerInfoWindow = new BMap.InfoWindow("<div class='googft-info-window'>" +
                    "<b>" + siteName + "</b><br>" +
                    "<b>site ID: </b>" + sId + "<br>" +
                    "</div>"); // ������Ϣ���ڶ���
			
			map.openInfoWindow(fusionLayerInfoWindow, e.point); // ������Ϣ����

			requestData(sId, source, siteName, siteDict);

		});
		map.addOverlay(pointCollection); // ���Overlay
		
	} else {
		alert('����chrome��safari��IE8+����������鿴��ʾ��');
	}
}