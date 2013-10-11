$(function(){
  $('.add-space-link').bind('click', function(){
    addToPage(this.rel);
    return(false);
  });
});

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
  },

  renderPlans: function(space_id){
    var $plans = $('#plans');
    var planTemplate = $('#planTemplate').html();
    var space_url = "https://www.cobot.me/api/spaces/" + space_id;
    var plans_url = "https://" + space_id + ".cobot.me/api/plans";
    var plans_req = $.getJSON(plans_url);
    var space_req = $.getJSON(space_url);


    $.when(space_req)
      .fail(function(space_error){console.log('Error getting space', space_error);})
      .done(function(space){
      // welcome text
      if($.trim(space.description).length > 0){
        $('#welcome').html((new Markdown.Converter()).makeHtml(space.description));
      };
    });

    $.when(space_req, plans_req)
      .fail(function(){console.log('Error getting plans');})
      .done(function(space_resp, plans_resp){
      var space = space_resp[0];
      var plans = plans_resp[0];

      var display_gross = function(){
        return space.display_price == "gross";
      };

      var gross_price = function(price){
        var tax_multiplier = (1 + parseFloat(space.tax_rate) / 100);
        return (Math.round(tax_multiplier * parseFloat(price)) * 100) / 100.0;
      };

      var price_to_display_price = function(price){
        if(display_gross){
          return gross_price(price);
        } else {
          return price;
        }
      };

      var has_cycle_costs = function(plan){
        return parseFloat(plan.price_per_cycle) > 0
      }

      plans = plans.sort(function(a, b){
        if(has_cycle_costs(a) && has_cycle_costs(b))
          return(parseFloat(a.price_per_cycle) > parseFloat(b.price_per_cycle) ? 1 : -1);
        if(has_cycle_costs(a) && !has_cycle_costs(b))
          return 1 ;
        if(!has_cycle_costs(a)  && has_cycle_costs(b) )
          return -1 ;
        if(!has_cycle_costs(a) && !has_cycle_costs(b))
          return(parseFloat(a.day_pass_price) > parseFloat(b.day_pass_price) ? 1 : -1);
        else
          return 0;
      })

      $.each(plans, function(){
        this.time_passes = this.time_passes.sort(function(a, b){
          return parseFloat(a.price_in_cents) > parseFloat(b.price_in_cents) ? 1 : -1
        });
        // no hidden plans
        if(!this.hidden){
          this.cycle_costs = function(){
            return has_cycle_costs(this);
          };
          this.extra_display_price = function(){
            var price = price_to_display_price(this.price_in_cents / 100);
            return(price);
          };
          this.discounts_available = function(){
            return this.discounts.lenght > 0;
          };
          this.display_day_pass_price = price_to_display_price(this.day_pass_price);
          this.display_price_per_cycle = price_to_display_price(this.price_per_cycle);

          this.url = space.url + '/users/new?plan_id='+ this.id;
          var planHtml = Mustache.to_html(planTemplate, this);
          $plans.append(planHtml);
          if(typeof FB != 'undefined'){
            FB.Canvas.setSize();
          }
        }
      });
    });
  }
};

