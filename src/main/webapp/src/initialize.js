function initialize() {
	//����Knockout
    ko.applyBindings(viewModel);

    var data = [];

    viewModel.time.start(new Date(2014,1,1));
    viewModel.time.end(new Date(2015,1,1));
    viewModel.time.recent("90");
    //��ʽ����,���ﵱ��ֵ���뵽dataArray��ʱ���ͻ����plotGraph()��//����ͼ�ķ���
    viewModel.dataArray.subscribe(function(newValue) {
        //console.log("plotGraph() called with new value added to dataArray.");
        viewModel.plotGraph();
    });

    //console.log("Initial value of requestData parameters: ");
    //console.log(viewModel.siteId());
    //console.log(viewModel.siteName());
    //console.log("setting viewModel values.");
    //��ʼ������
    viewModel.siteId("dv01580000");
    var source = 'USGS-DV';
    viewModel.siteName("Deer Creek at Rocks, MD");
    var initialSiteDict = {
        id : "dv01580000",
        name : "DEER CREEK AT ROCKS, MD",
        area : 94.4,
        impervious : 1.26
    };

    //console.log("Initial call of requestData with: ");
    //console.log(viewModel.siteId());
    //console.log(viewModel.siteName());
    //console.log(viewModel.siteDict().toString());
    //��������
    requestData(viewModel.siteId(), source, viewModel.siteName(), initialSiteDict);

 /*   google.maps.event.addDomListener(window, 'load', drawMap);
    //��һ�ε�ͼ��ʾ��ʱ�����resizeһ�£�ʹ���λ��λ����Ļ����
    google.maps.event.addDomListener(window, 'load', redraw);
    //��������������ڵĴ�Сʱ������ redraw �¼���
    $(window).resize(redraw);*/
   //���Ƶ�ͼ
    drawMap_Baidu();
    //��һ�ε�ͼ��ʾ��ʱ�����resizeһ�£�ʹ���λ��λ����Ļ����
    redraw_Baidu();
    //��������������ڵĴ�Сʱ������ redraw �¼���
    $(window).resize(redraw_Baidu);
}