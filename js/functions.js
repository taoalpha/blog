jQuery.fn.rotate = function(degrees) {
    $(this).css({'-webkit-transform' : 'rotate('+ degrees +'deg)',
                 '-moz-transform' : 'rotate('+ degrees +'deg)',
                 '-ms-transform' : 'rotate('+ degrees +'deg)',
                 'transform' : 'rotate('+ degrees +'deg)'});
    return $(this);
};

function getLocation() {
    var weatherData = $.cookie("weatherData");
    var cLocation = $.cookie("cLocation");
    var path_prefix = location.pathname.split("/")[2];
    var weatherImgUrl = $.cookie(path_prefix+"weatherImgUrl");
    if(!weatherImgUrl){
        randomImage(path_prefix)
    }
    if(weatherData){
        updateWeather(JSON.parse(weatherData),"cookie");
        return
    }else if(cLocation){
        updateWeather(cLocation,"cityname");
        return
    }
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(updateWeather,showError);
    } else { 
        alert("Geolocation is not supported by this browser.");
    }
}
function customLocation(){
    $('div.location').find("span").text("");
    $('input#cLocation').show().focus();
}
function updateLocation(){
    var cLocation = $('input#cLocation').val();
    $.cookie("cLocation",cLocation,{path:"/",expires:7});
    updateWeather(cLocation,"cityname");
}
function updateWeather(position,flag){
    var weatherUrl = "";
    if(flag == "cityname") {
        weatherUrl = "http://api.openweathermap.org/data/2.5/weather?q="+position+"&lang=zh_cn&units=metric";
    }else if (flag == "cookie"){
        updateWeatherPart(position);
        $("section.aside").css("background-image","url("+$.cookie("weatherImgUrl")+")");
        return
    }else{
        weatherUrl = "http://api.openweathermap.org/data/2.5/weather?lat="+position.coords.latitude+"&lon="+position.coords.longitude+"&lang=zh_cn&units=metric";
    }
    $.get(weatherUrl,function(data){                            
        $.cookie("weatherData",JSON.stringify(data),{expires:0.05,path:'/'});
        updateWeatherPart(data);
    })
}
function updateWeatherPart(data){
    var dt = data["dt"]*1000;
    var day = new Date(dt).getDate()
    var month = new Date(dt).getMonth()
    var Dcharacters = ["","一","二","三","四","五","六","七","八","九","十"]
    var Mcharacters = ["","十","二十","三十"]
    var ZdataM = Mcharacters[Math.floor(month/10)]+Dcharacters[month % 10+1]
    var ZdataD = Mcharacters[Math.floor(day/10)]+Dcharacters[day % 10]
    var Edata = new Date(dt).toDateString()

    $('div.location span').text(data.name);
    $('input#cLocation').hide();
    $('h2.weather-cn').html(ZdataM+"月"+ZdataD+"日: <span>"+data["weather"][0]["description"]+"</span>");
    $('h3.weather-en').html(Edata+": <span>"+data["weather"][0]["main"]+"</span>");
}
function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            console.log("You denied the request for Geolocation.");
            updateWeather("beijing","cityname")
            break;
        case error.POSITION_UNAVAILABLE:
            console.log("Location information is unavailable.");
            updateWeather("beijing","cityname")
            break;
        case error.TIMEOUT:
            console.log("The request to get user location timed out.");
            updateWeather("beijing","cityname")
            break;
        case error.UNKNOWN_ERROR:
            console.log("An unknown error occurred.");
            updateWeather("beijing","cityname")
            break;
    }
}
// add limitation for tags and picked 8 or 10 tags randomly everytime

function randomTags(flag){
    var originArray = $('ul.tags').find('a.tag')
    if(flag=="showall"){originArray.show();return}
    originArray.eq(0).show();
    for (i=0;i<10;i++){
        var index = Math.floor(Math.random()*originArray.length)+1
        originArray.eq(index).show();
    }
}
function randomImage(path){
    var imageurl = "http://www.dailywallppr.com/img/"+ Math.floor(Math.random()*2320+1)+".jpg"
    $("section.aside").css("background-image","url("+imageurl+")");
    $.cookie(path+"weatherImgUrl",imageurl,{expires:0.05})
}

