

var CobotFb = {
  renderSpaces: function(spaces){
    var spaceTemplate = $('#spaceTemplate').html();
    var $spaces = $('#spaces');

    var space_id = function(space_url){
      var regex = /api\/spaces\/([\w-]+)/;
      var match = regex.exec(space_url);
      return(match[1]);
    };
    if(spaces.length > 0){
      $.each(spaces, function(){
        this.space_id = space_id(this.space_link);
        var spaceHtml = Mustache.to_html(spaceTemplate, this);
        $spaces.append(spaceHtml);
      });
    }else{
      $('#text').text("Seems you don't manage any coworking spaces via cobot.");
    };
  }
};

