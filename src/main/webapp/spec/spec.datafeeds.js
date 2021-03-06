describe("The Jasmine async functions", function() {
  var result = 1;

  //You can redefine the default timeout from 5000 to anything you want; but you have to do it inside an it() function.
  //jasmine.DEFAULT_TIMEOUT_INTERVAL = 1000;

  beforeEach(function(done) {
    setTimeout(function() {
      result = {
        status : 200
      };
      console.log("beforeEach");
      //Once you have completed the above tasks, trigger the "done()" function.
      done();
      //wait 100 milliseconds before executing the function.
    }, 100);
  });

  it("should work properly.", function(done) {
    //This function will not run until the beforeEach function triggers the done() function.
    console.log("inside the first it()");
    expect(result.status).toEqual(200);
    done();
  });
  it("should test each it() function", function() {
    console.log("inside the second it()");
  });
  it("should not run tests without functions to test");
  xit("should not run xit() functions.", function() {
    expect(55).toEqual(55);
  });
});

describe("This server", function(done) {
  var result = 1;
  result = $.ajax({
    url : "resources/loading.gif",
    success : done
  });
  //});
  it("should return a 200 code.", function(done) {
    expect(result.status).toEqual(200);
    done();
  });
});

describe("The USGS real-time service", function() {
  var result = 1;

  //I would like to request the data once and then test it, but this done() system doesn't seem to be up to it.
  beforeEach(function(done) {
    console.log("start USGS request");
    result = 5;
    result = $.ajax({
      url : "http://waterservices.usgs.gov/nwis/iv/?format=json&sites=01646500&parameterCd=00060",
      dataType : "json",
      complete : function() {
        console.log("request complete");

        done();
      }
    });
  });
  it("should return a 200 code.", function(done) {
    console.log(result.responseJSON);
    expect(result.status).toEqual(200);
    done();
  });
  it("should return some data", function(done) {
    //console.log(result.responseText);
    expect(result.responseText).toEqual(jasmine.any(String));
    expect(result.responseJSON).toEqual(jasmine.any(Object));
    done();
  });
  it("should return data for site #01646500", function() {
    expect(result.responseJSON.value.timeSeries[0].sourceInfo.siteCode[0].value).toEqual("01646500");
  });
  it("should return data for site name POTOMAC RIVER NEAR WASH, DC LITTLE FALLS PUMP STA", function() {
    expect(result.responseJSON.value.timeSeries[0].sourceInfo.siteName).toEqual("POTOMAC RIVER NEAR WASH, DC LITTLE FALLS PUMP STA");
  });
  it("should return numeric data", function() {
    expect(+result.responseJSON.value.timeSeries[0].values[0].value[0].value).toEqual(jasmine.any(Number));
  });
  it("should return data that is less than 12 hours old.", function() {
    //console.log(Date.parse(result.responseJSON.value.timeSeries[0].sourceInfo.siteCode[0].dateTime));
    console.log("Time of last measurement: " + result.responseJSON.value.timeSeries[0].values[0].value[0].dateTime);
    expect(Date.parse(result.responseJSON.value.timeSeries[0].values[0].value[0].dateTime)).toBeGreaterThan(Date.now() - (12 * 60 * 60 * 1000));
  });
});

describe("The TU NEXRAD service", function() {
  var result = 2;

  //I would like to request the data once and then test it, but this done() system doesn't seem to be up to it.
  beforeEach(function(done) {
    var urlDates = "http://10.55.17.48:5000/nexradTS/id=01646500/startdate=2014-03-22/enddate=2014-03-25";
    var urlRecent = "http://10.55.17.48:5000/nexradTSrecent/id=01646500/recent=2";
    console.log("start TU NEXRAD request");
    result = 6;
    result = $.ajax({
      url : urlRecent,
      dataType : "json",
      complete : function() {
        console.log("request complete");

        done();
      }
    });
  });
  it("should return a 200 code.", function(done) {
    console.log(result.responseJSON);
    expect(result.status).toEqual(200);
    done();
  });
  it("should return some data", function(done) {
    //console.log(result.responseText);
    expect(result.responseText).toEqual(jasmine.any(String));
    expect(result.responseJSON).toEqual(jasmine.any(Object));
    done();
  });
  it("should return data for site #01646500", function() {
    expect(result.responseJSON[0].SITE_NO).toEqual("01646500");
  });
  it("should return numeric precipitation data", function() {
    expect(+result.responseJSON[0].precipitation).toEqual(jasmine.any(Number));
  });
  it("should return data that is less than 36 hours old.", function() {
    //console.log(Date.parse(result.responseJSON.value.timeSeries[0].sourceInfo.siteCode[0].dateTime));
    console.log("Time of last measurement: " + result.responseJSON[result.responseJSON.length-1].dateTime);
    expect(Date.parse(result.responseJSON[result.responseJSON.length-1].dateTime)).toBeGreaterThan(Date.now() - (48 * 60 * 60 * 1000));
  });
});