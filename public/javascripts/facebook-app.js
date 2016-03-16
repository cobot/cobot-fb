var CobotFb = {
  renderPlans: function(){
    var $plans = $('#plans');
    var space_id = $plans.data('space-id');
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
        $('#welcome').html(marked(space.description));
      }
    });

    $.when(space_req, plans_req)
      .fail(function(){console.log('Error getting plans');})
      .done(function(space_resp, plans_resp){
      var space = space_resp[0];
      var plans = plans_resp[0];

      var display_gross = function(){
        return space.price_display == "gross";
      };

      var gross_price = function(price){
        var tax_multiplier = (1 + parseFloat(space.tax_rate) / 100);
        return (Math.round(tax_multiplier * parseFloat(price)) * 100) / 100.0;
      };

      var price_to_display_price = function(price){
        if(display_gross()){
          return gross_price(price);
        } else {
          return price;
        }
      };

      var has_cycle_costs = function(plan){
        return parseFloat(plan.price_per_cycle) > 0;
      };

      $.each(plans, function(){
        this.time_passes = this.time_passes.sort(function(a, b){
          return parseFloat(a.price_in_cents) > parseFloat(b.price_in_cents) ? 1 : -1;
        });
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
        this.html_description = function(){
          if($.trim(this.description).length > 0){
            return marked(this.description);
          }
        };
        this.display_day_pass_price = price_to_display_price(this.day_pass_price);
        this.display_price_per_cycle = price_to_display_price(this.price_per_cycle);

        this.url = space.url + '/users/new?plan_id='+ this.id;
        var planHtml = Mustache.to_html(planTemplate, this);
        $plans.append(planHtml);
        if(typeof FB != 'undefined'){
          FB.Canvas.setSize();
        }
      });
    });
  }
};

$(CobotFb.renderPlans);