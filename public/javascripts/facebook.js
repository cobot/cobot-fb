
window.fbAsyncInit = function() {
  // init the FB JS SDK
  FB.init({
    appId: '108253272618609',
    status: true,
    cookie: true,
    version: 'v2.0'
  });
  FB.Canvas.setSize();
};

// Load the SDK asynchronously
(function(d, s, id){
   var js, fjs = d.getElementsByTagName(s)[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement(s); js.id = id;
   js.src = "//connect.facebook.net/en_US/all.js";
   fjs.parentNode.insertBefore(js, fjs);
 }(document, 'script', 'facebook-jssdk'));
