//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/




$(function(){
	var noPurchaseJSON = {"lifecycle_stage": "No Purchase","avg_time_to_convert":336262.28849902534,"buying_cycle_stages":{"total":414626,	"at_risk":281945,"awareness":37316,"interest":33170,"considering":12438,"intent":49775}};
	var onePurchaseJSON = {"lifecycle_stage": "1 Purchase","avg_time_to_convert":459760.41401273885,"buying_cycle_stages":{"total":53187,"at_risk":38294,"recent_buyers":6914,"awareness":2659,"interest":1595,"considering":1063,"intent":2659}};
	var repeatJSON = {"lifecycle_stage": "Repeat","avg_time_to_convert":344243.6551724138,"buying_cycle_stages":{"total":47829,"at_risk":30132,"recent_buyers":4304,"awareness":4782,"interest":1913,"considering":3862,"intent":2869}};
	var loyalJSON = {"lifecycle_stage": "Loyal","avg_time_to_convert":344243.6551724138,"buying_cycle_stages":{"total":15910,"at_risk":10977,"recent_buyers":1750,"awareness":318,"interest":954,"considering":477,"intent":1272}};
	var data = [{ "lifecycle_stage": "No Purchase", "avg_time_to_convert":336262.28849902534, 
	"buying_cycle_stages":[{ "total":414626},{ "at_risk":281945 },{"awareness":37316},{ "interest":33170},{"considering":12438}, {"intent":49775 }] },{ "lifecycle_stage": "1 Purchase", "avg_time_to_convert":459760.41401273885, "buying_cycle_stages":[{ "total":53187}, {"at_risk":38294}, {"recent_buyers":6914}, {"awareness":2659}, {"interest":1595}, {"considering":1063}, {"intent":2659 }] },{ "lifecycle_stage": "Repeat", "avg_time_to_convert":344243.6551724138, "buying_cycle_stages":[{ "total":47829}, {"at_risk":30132}, {"recent_buyers":4304}, {"awareness":4782}, {"interest":1913}, {"considering":3862}, {"intent":2869 }] },{"lifecycle_stage": "Loyal","avg_time_to_convert":344243.6551724138,"buying_cycle_stages":[{"total":15910}, {"at_risk":10977}, {"recent_buyers":1750}, {"awareness":318}, {"interest":954}, {"considering":477}, {"intent":1272 }]}];
	
//	data = jQuery.parseJSON(jsonData);
	
	
	
	
	
	var totalCustomers = 0;
	data.forEach(function(d,i){
		totalCustomers = totalCustomers + data[i].buying_cycle_stages.total;
	});

	//begin renderDiagram function
	var margin = { top: 20, left: 0, bottom: 0, right: 0 }
	var width  = $(".container").width()  - margin.left - margin.right
	
	var height = {
	      lifecycleLabel:    35,
	      sizes:             25,
	      avgTimes:          80,
	      buyingCycleStages: 220,
	}
	
    var lifecycleStages   = ['No Purchase', '1 Purchase', 'Repeat', 'Loyal']
    var buyingCycleStages = ['at_risk', 'recent_buyers', 'awareness', 'interest', 'considering', 'intent']
	var x = {}
//	x.lifecycleStage = d3.scale.ordinal().range(0, width).domain(lifecycleStages);
//	x.lifecycleStage = d3.scale.ordinal().rangeRoundBands([0, width], .1, .05).domain(lifecycleStages);
	var lifecycleScale = d3.scale.ordinal().domain(lifecycleStages).rangeRoundBands([0, width], .1, .05);
//	var lifecycleStage = d3.scale.ordinal().rangeRoundBands([0, width]).domain(lifecycleStages);
	var buyingCycleScale = d3.scale.ordinal().domain(buyingCycleStages).rangeRoundBands([0, lifecycleScale.rangeBand()], .05);
	
	var svg = d3.select("#lifecycle-chart").append("svg")
		.attr("width", width + margin.left + margin.right)
		.style("height", height.total + margin.top + margin.bottom)
		.style("border", "1px solid #ccc");

	var separators = svg.append("g")
		.attr("transform", "translate("+ margin.left +","+ margin.top +")")
		.attr("class", "separators");
			
	separators.selectAll('.separator')
		.data(lifecycleStages)
		.enter()
		.append('line')
		  .attr('class', 'separator')
		  .attr('x1', function(d, i) { 
			return lifecycleScale(d) - lifecycleScale.rangeBand() * .05;
		  })
		  .attr('x2', function(d, i) {
			return lifecycleScale(d) - lifecycleScale.rangeBand() * .05;
		  })
		  .attr('y1', -1000)
		  .attr('y2',  1000)
		  .style('stroke', function (d,i) {
			  if ( i == 0) {
				  return 'transparent';
			  } else  {
				  return '#ddd';
			  }
		  });
	
	var lifecycleStagesGroup = svg.append("g").attr("class", "lifecycles-container");
	
	lifecycleStagesGroup.selectAll(".lifecycle-stage-label")
		.data(lifecycleStages)
		.enter()
			.append("g")
				.attr("class", "lifecycle-stage-label")
				.attr("transform", function(d,i) {
					return "translate("+ lifecycleScale(d) + ", "+ margin.top +")";
				})
//				.on("click", lifecycleStageClicked())
				.append("text")
					.text(function(d){ return d; });
	var sizesGroup = svg.append("g")
		.attr("class", "sizes-container")
		.attr("transform", function() {
			return "translate(0,"+ height.sizes +")";
		});
	
	var convertGroup = svg.append("g")
		.attr("class", "convert-container")
		.attr("transform", function(){
			return "translate(0,"+ height.lifecycleLabel +")";
		});
	
	var buyingCycleStagesGroup = svg.append("g")
		.attr("class", "buying-cycle-stages-container")
		.attr("transform", function() {
			return "translate(0,"+ (height.lifecycleLabel + height.sizes + height.avgTimes) +")";
		});
	//end renderDiagram function
	
		
	// begin updateDiagram function
	function updateDiagram(data) {
		var buyingCycleStage, buyingCycleStageGroup, 
			buyingCycleStageGroupEnter, halfWidth, 
			lifecycleBuyingCycleStagesGroup, maxY, sizes, total, _ref;
		
			sizes = sizesGroup.selectAll(".size-group")
				.data(data)
				.enter()
					.append("g")
						.classed("size-group", true)
						.attr('data-lifecycle-stage', function(d,i){ return i; })
						.attr('transform', function(d,i){
							console.log(i);
							return "translate("+lifecycleScale(lifecycleStages[i])+","+margin.top+")"
						})
						.append("text")
							.text(function(d,i){
								console.log(d);
								console.log(i);
								console.log(d.buying_cycle_stages);
								var relative = d.buying_cycle_stages[i].total;
//								return relative.toLocaleString() + " customers / "+ ( (relative / totalCustomers)*100 ).toFixed(2) +"%";
							});
//						.classed('unfocused', function(d,i){ return d.lifecycleStage && d.lifecycleStage isnt String(i); })
			
			lifecycleBuyingCycleStagesGroup = buyingCycleStagesGroup.selectAll(".buying-cycle-stages-container")
				.data(data)
				.enter()
					.append("g")
						.attr("class", "buying-cycle-stage-group")
						.attr("data-lifecycle-stage", function(d,i){ return i; })
						.attr("transform", function(d,i){
							console.log(d);
							return "translate("+lifecycleScale(lifecycleStages[i])+","+ margin.top +")"
						})
			
			buyingCycleStageGroup = lifecycleBuyingCycleStagesGroup.selectAll("g.buying-cycle-stage")
				.data(function(d,i){
					console.log(d.buying_cycle_stages);	
					return d.buying_cycle_stages
				})
				.enter()
				.append("g")
						.attr("class", "buying-cycle-stage")
						.attr("transform", function(d,i){
								console.log(d);
								return "translate("+ buyingCycleScale(buyingCycleStages[i]) +", 0)"
						});
			
	
/*
			buyingCycleStageGroupEnter = buyingCycleStageGroup
				.enter().append("g")
						.attr("class", "buying-cycle-stage")
						.attr("transform", function(d,i){
								console.log(d);
								return "translate("+ buyingCycleScale(buyingCycleStages[i]) +", 0)"
						});
*/
	
	
	}
	updateDiagram(data);
});




