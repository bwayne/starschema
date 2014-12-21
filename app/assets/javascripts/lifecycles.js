//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/




$(function(){
	var noPurchaseJSON = {"lifecycle_stage": "No Purchase","avg_time_to_convert":336262.28849902534,"buying_cycle_stages":{"total":414626,	"at_risk":281945,"awareness":37316,"interest":33170,"considering":12438,"intent":49775}};
	var onePurchaseJSON = {"lifecycle_stage": "1 Purchase","avg_time_to_convert":459760.41401273885,"buying_cycle_stages":{"total":53187,"at_risk":38294,"recent_buyers":6914,"awareness":2659,"interest":1595,"considering":1063,"intent":2659}};
	var repeatJSON = {"lifecycle_stage": "Repeat","avg_time_to_convert":344243.6551724138,"buying_cycle_stages":{"total":47829,"at_risk":30132,"recent_buyers":4304,"awareness":4782,"interest":1913,"considering":3862,"intent":2869}};
	var loyalJSON = {"lifecycle_stage": "Loyal","avg_time_to_convert":344243.6551724138,"buying_cycle_stages":{"total":15910,"at_risk":10977,"recent_buyers":1750,"awareness":318,"interest":954,"considering":477,"intent":1272}};
//	var data = [{ "lifecycle_stage": "No Purchase", "avg_time_to_convert":336262.28849902534, "buying_cycle_stages":[{ "total":414626},{ "at_risk":281945 },{"awareness":37316},{ "interest":33170},{"considering":12438}, {"intent":49775 }] },{ "lifecycle_stage": "1 Purchase", "avg_time_to_convert":459760.41401273885, "buying_cycle_stages":[{ "total":53187}, {"at_risk":38294}, {"recent_buyers":6914}, {"awareness":2659}, {"interest":1595}, {"considering":1063}, {"intent":2659 }] },{ "lifecycle_stage": "Repeat", "avg_time_to_convert":344243.6551724138, "buying_cycle_stages":[{ "total":47829}, {"at_risk":30132}, {"recent_buyers":4304}, {"awareness":4782}, {"interest":1913}, {"considering":3862}, {"intent":2869 }] },{"lifecycle_stage": "Loyal","avg_time_to_convert":344243.6551724138,"buying_cycle_stages":[{"total":15910}, {"at_risk":10977}, {"recent_buyers":1750}, {"awareness":318}, {"interest":954}, {"considering":477}, {"intent":1272 }]}];
	
data = jQuery.parseJSON(gon.buycycle_data);
device_data = jQuery.parseJSON(gon.device_data);

	
	
	
	
	var totalCustomers = gon.total_customers;

	//begin renderDiagram function
	var margin = { top: 30, left: 0, bottom: 0, right: 0 }
	var width  = $(".container").width()  - 40
	
	var height = {
	      lifecycleLabel:    35,
	      sizes:             25,
	      avgTimes:          40,
	      buyingCycleStages: 120,
	      margintop: 		 20,
	      marginbottom:		 20
	}
	var dimensionBarWidth = 75;
	var colors = ["#12A7E0", "#FFB599", "#ff4600", "#2C3E50"]
	
    var lifecycleStages   = ['No Purchase', '1 Purchase', 'Repeat', 'Loyal']
    var buyingCycleStages = ['at_risk', 'recent_buyers', 'awareness', 'interest', 'considering', 'intent']
	var x = {}
//	x.lifecycleStage = d3.scale.ordinal().range(0, width).domain(lifecycleStages);
//	x.lifecycleStage = d3.scale.ordinal().rangeRoundBands([0, width], .1, .05).domain(lifecycleStages);
	var lifecycleScale = d3.scale.ordinal().domain(lifecycleStages).rangeRoundBands([0, width], .1, .05);
//	var lifecycleStage = d3.scale.ordinal().rangeRoundBands([0, width]).domain(lifecycleStages);
	var buyingCycleScale = d3.scale.ordinal().domain(buyingCycleStages).rangeRoundBands([0, lifecycleScale.rangeBand()], .05);
	var dimensionBarScale = d3.scale.linear().domain([0,gon.largest_dimension]).rangeRound([0,dimensionBarWidth]);
	var boxWidth = lifecycleScale.rangeBand();
	
	var diagram = d3.select("#lifecycle-chart").append("svg")
		.attr("width", width )
		.attr("height", height.buyingCycleStages + height.lifecycleLabel + height.sizes + height.avgTimes + margin.top + margin.bottom)
		.style("border", "1px solid #ccc");

	var separators = diagram.append("g")
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
	
	var horizLine1 = diagram.append("line")
		.attr("class", "horizSeparator")
		.attr("y1", height.lifecycleLabel + height.sizes + 10)
		.attr("y2", height.lifecycleLabel + height.sizes + 10)
		.attr("x1", -1000)
		.attr("x2", 1000)
		.style("stroke", "#ddd");
	
	var horizLine2 = diagram.append("line")
		.attr("class", "horizSeparator")
		.attr("y1", height.lifecycleLabel + height.sizes + height.avgTimes + 10)
		.attr("y2", height.lifecycleLabel + height.sizes + height.avgTimes + 10)
		.attr("x1", -1000)
		.attr("x2", 1000)
		.style("stroke", "#ddd");

	var lifecycleStagesGroup = diagram.append("g").attr("class", "lifecycles-container");
	
	lifecycleStagesGroup.selectAll(".lifecycle-stage-label")
		.data(lifecycleStages)
		.enter()
			.append("g")
				.attr("class", "lifecycle-stage-label")
				.attr("transform", function(d,i) {
					return "translate("+ lifecycleScale(d) + ", "+ height.lifecycleLabel +")";
				})
//				.on("click", lifecycleStageClicked())
				.append("text")
					.text(function(d){ return d; });
	var sizesGroup = diagram.append("g")
		.attr("class", "sizes-container")
		.attr("transform", function() {
			return "translate(0,"+ height.sizes +")";
		});
	
	var convertGroup = diagram.append("g")
		.attr("class", "convert-container")
		.attr("transform", function(){
			return "translate(0,"+ (height.avgTimes + height.sizes) +")";
		});
	
	var buyingCycleStagesGroup = diagram.append("g")
		.attr("class", "buying-cycle-stages-container")
		.attr("height", height.buyingCycleStages)
		.attr("transform", function() {
			return "translate(0,"+ (height.lifecycleLabel + height.sizes + height.avgTimes + margin.top) +")";
		});
	//end renderDiagram function
	
		
	// begin updateDiagram function
	function updateDiagram(data) {
		console.log(data);
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
							return "translate("+lifecycleScale(lifecycleStages[i])+","+margin.top+")"
						})
						.append("text")
							.text(function(d,i){
								var relative = d.total;
								return relative.toLocaleString() + " customers / "+ ( (relative / totalCustomers)*100 ).toFixed(2) +"%";
							});
//						.classed('unfocused', function(d,i){ return d.lifecycleStage && d.lifecycleStage isnt String(i); })
			
			lifecycleBuyingCycleStagesGroup = buyingCycleStagesGroup.selectAll(".buying-cycle-stages-container")
				.data(data)
				.enter()
					.append("g")
						.attr("class", "buying-cycle-stage-group")
						.attr("data-lifecycle-stage", function(d,i){ return i; })
						.attr("transform", function(d,i){
							return "translate("+lifecycleScale(lifecycleStages[i])+","+ (height.lifecycleLabel + height.sizes + height.avgTimes + margin.top) +")"
						})
			
			buyingCycleStageGroup = lifecycleBuyingCycleStagesGroup.selectAll("g.buying-cycle-stage")
//				.data(function(d,i){
//					return d.buying_cycle_stages
//				})
				.data(function(d,i){
					return d.data
				})
				.enter()
				.append("g")
						.attr("class", "buying-cycle-stage")
						.attr("transform", function(d,i){
								return "translate("+ buyingCycleScale(buyingCycleStages[i]) +", 0)"
						});
			
			var colorCounter = 0
			buyingCycleStageGroup.append("rect")
				.attr("width", function(d){
					return buyingCycleScale.rangeBand();
				})
				.attr("height", function(d,i) {
					return d.count;
				}).attr("fill", function(d,i){
					colorCounter++;
					if (colorCounter <= 5) {
						return colors[0];
					} else if (colorCounter > 5 && colorCounter <= 11) {
						return colors[1];
					} else if (colorCounter > 11 && colorCounter <= 17 ) {
						return colors[2];
					} else if (colorCounter > 17 && colorCounter <= 23 ) {
						return colors[3];
					}
				})
				.attr("y", function(d,i){
					return -d.count;
				});
				
				
				var convert = convertGroup.selectAll(".convert-group")
					.data(data)
					.enter()
						.append("g")
							.attr("class", "convert-group")
							.attr("data-lifecycle-stage", function(d,i){ return i; })
							.attr("transform", function(d,i) {
								return "translate("+lifecycleScale(lifecycleStages[i])+", "+ (height.sizes + 10) +")"
							});
				convert.append("text")
					.text(function(d,i){
						if (i < 3) {
							return d.conv_rate + "% convert to " + lifecycleStages[i+1];
						}
					})
					.attr("transform", "translate(0, -15)");
				convert.append("text")
					.text(function(d,i){
						if (i < 3) {
							return d.conv_time + " days on average";
						}
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
	}  // end updateDiagram() function

	function drawNewDimension(container, data) {

		var newDimension = d3.select(container).append("svg")	
			.attr("width", function(){
				console.log(data);
				return width;
			})
				.attr("height", (3 * 30) + margin.top + margin.bottom)
				.style("border", "1px solid #ccc");	
		var separators = newDimension.append("g")
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
		
		var dimensionsContainer = newDimension.selectAll(".lifecycle-stage")			
			.data(data)
			.enter()
			.append("g")
				.attr("class", "lifecycle-stage")				
				.attr('data-lifecycle-stage', function(d,i){ return i; })				
				.attr("transform", function(d,i){					
					return "translate("+lifecycleScale(lifecycleStages[i])+",0)"				
				});				
		
		var dimensions = dimensionsContainer.selectAll(".dimension-value")			
			.data(function(d){ return d.data; })			
			.enter()			
			.append("g")				
				.attr("class", "dimension-value")				
				.attr("transform", function(d,i){					
					return "translate(0,30)"				
				});						
		
		dimensions.append("rect")
			.style("fill", function(d,i){				
				return colors[i];	
				})			
				.attr("class", "dimension-bar")			
				.attr("width", function(d,i){				
					if (dimensionBarScale(d.count) < 1) {					
						return 1;				
						} else {					
							return dimensionBarScale(d.count);				
						}			
					})			
				.attr("height", 20)			
				.attr("transform", function(d,i){				
					return "translate("+ (boxWidth - dimensionBarWidth) +","+ ((i * 30) - 10) + ")";			
				});		
		
		dimensions.append("text")			
			.text(function(d,i){		
				return d.name;			
				})			
			.attr("class", "name")			
			.attr("transform", function(d,i){				
				return "translate(0," + ((i * 30) + 3) + ")";			
			});		
		
		dimensions.append("text")			
			.text(function(d,i){				
				return d.count;				
			})			
			.attr("class", "count")			
			.attr("transform", function(d,i){				
				rectWidth = $(this).parent().find("rect").attr("width");				
				if (Math.floor(rectWidth) > ($(this).width() + 5)){					
					return "translate(" + (boxWidth - dimensionBarWidth + 5) +"," + ((i * 30) + 3) + ")"; 				
				} else { 					
					return "translate("+ (boxWidth - dimensionBarWidth + 3 + Math.floor(rectWidth)) +"," + ((i * 30) + 3) + ")";				
				}			
			})			
			.attr("fill", function(d,i){				
				rectWidth = $(this).parent().find("rect").attr("width");				
				if (Math.floor(rectWidth) > ($(this).width() + 3)){					
					return "#fff";				
				} else {					
					return "#000";				
				}			
			});
		}

	
	updateDiagram(data);
	drawNewDimension("#device-types", device_data);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////// SENTENCE BUILDER
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


			var segmentMatchDropdown = '<li class="segment"><a href="javasscript:void(0)">were in</a></li><li class="segment"><a href="javasscript:void(0)">were not in</a></li>';
			var actionMatchDropdown = '<li class="action"><a href="javasscript:void(0)">did</a></li><li class="action"><a href="javasscript:void(0)">did not do</a></li>';
			var attrMatchDropdown = '<li class="attr"><a href="javasscript:void(0)">had</a></li><li class="attr"><a href="javasscript:void(0)">did not have</a></li>';
			var expressionMatchDropdown = '<li class="expression"><a href="javasscript:void(0)">matched</a><li class="expression"><a href="javasscript:void(0)">did not match</a></li>';
			var lifecycleMatchDropdown = '<li class="segment"><a href="javasscript:void(0)">were in</a></li><li class="segment"><a href="javasscript:void(0)">were not in</a></li>';
			var buycycleMatchDropdown = '<li class="segment"><a href="javasscript:void(0)">were in</a></li><li class="segment"><a href="javasscript:void(0)">were not in</a></li>';
			
			
			var segmentDropdown = '<li><a href="javasscript:void(0)">any segment</a></li> 				\
								<li><a href="javasscript:void(0)">Segment 1</a></li>		\
								<li><a href="javasscript:void(0)">Segment 2</a></li>		\
								<li><a href="javasscript:void(0)">Segment 3</a></li>';
			var actionDropdown = '<li><a href="javasscript:void(0)">any action</a></li><li><a href="javasscript:void(0)">Action 1</a></li><li><a href="javasscript:void(0)">Action 2</a></li><li><a href="javasscript:void(0)">Action 3</a></li>';
			var attrDropdown = '<li><a href="javasscript:void(0)">any attribute</a></li><li><a href="javasscript:void(0)">Attribute 1</a></li><li><a href="javasscript:void(0)">Attribute 2</a></li><li><a href="javasscript:void(0)">Attribute 3</a></li>';
			var expressionDropdown = '<li><a href="javasscript:void(0)">any expression</a></li><li><a href="javasscript:void(0)">Expression 1</a></li><li><a href="javasscript:void(0)">Expression 2</a></li><li><a href="javasscript:void(0)">Expression 3</a></li>';
			var lifecycleDropdown = '<li><a href="javascript:void(0)">any lifecycle stage</a></li><li><a href="javascript:void(0)">No Purchase</a></li><li><a href="javascript:void(0)">One Purchase</a></li><li><a href="javascript:void(0)">Repeat</a></li><li><a href="javascript:void(0)">Loyal</a></li>';
			var buycycleDropdown = '<li><a href="javascript:void(0)">any buying cycle stage</a></li><li><a href="javascript:void(0)">At Risk</a></li><li><a href="javascript:void(0)">New to Stage</a></li><li><a href="javascript:void(0)">Awareness</a></li><li><a href="javascript:void(0)">Interest</a></li><li><a href="javascript:void(0)">Consider</a></li><li><a href="javascript:void(0)">Intent</a></li>';

			
			var matchDropdown = segmentMatchDropdown;
			var dimensionDropdown = segmentDropdown;	
			var newAttr;
			function getNewAttr(type, text1) {
				var newAttrStart = 	'<span class="attribute">																												\
										<span class="in-not selector dropdown">																								\
											<span class="dropdown-toggle" type="button" data-toggle="dropdown" id="sentence-match" aria-expanded="true">'+ text1 +'</span>		\
											<ul class="dropdown-menu match-dropdown segment" role="menu" aria-labelledby="sentence-match">';
				var newAttrMiddle = 		'</ul>		\
										</span>																															\
										<span class="dimension selector dropdown">																							\
											<span class="dropdown-toggle" type="button" data-toggle="dropdown" id="sentence-match" aria-expanded="true">any '+ type +'</span>	\
											<ul class="dropdown-menu dimension-dropdown" role="menu" aria-labelledby="sentence-match">'
				var newAttrEnd =			'</ul>			\
										</span>				\
										<span class="attribute-delete">x</span>												\
									</span>';
				newAttr = newAttrStart + matchDropdown + newAttrMiddle + dimensionDropdown + newAttrEnd;
				return newAttr;		
			}
			function getNewGroup() {
				var newGroup = 	'<span class="or">OR</span><span class="attribute-group new">		\
								' + newAttr + '														\
								<span class="attribute-add-dropdown dropdown">						\
									<span class="dropdown-toggle attribute-add" type="button" data-toggle="dropdown" id="" aria-expanded="true">+ AND</span> \
									<ul class="dropdown-menu attr-dropdown" role="menu">			\
										<li class="segment"><a href="javascript:void(0)">Add Segment</a></li>	\
										<li class="action"><a href="javascript:void(0)">Add Action</a></li>		\
										<li class="attr"><a href="javascript:void(0)">Add Attribute</a></li>	\
										<li class="expression"><a href="javascript:void(0)">Add Expression</a></li>	\
										<li class="lifecycle"><a href="javascript:void(0)">Add Lifecycle Stage</a></li>	\
										<li class="buycycle"><a href="javascript:void(0)">Add Buying Cycle Stage</a></li>	\
									</ul>		\
								</span>';
				return newGroup;				
			}
			function removeCruft() {
				$(".attribute-group").each(function(){
					if ($(this).children(".attribute").length == 1) {
//						$(this).find(".attribute-delete").remove();
						$(this).find(".and").remove();
					}
				});	
				$(".well").find(".attribute-group").each(function(){
					if ($(".well").find(".attribute-group").length == 1) {
						$(this).find(".group-delete").remove();
						$(".well").find(".or").remove();
					} else {
						if ($(this).children().hasClass("group-delete") == false) { 
							$(this).append('<span class="group-delete">x</span>');
						}
					}
				});
				$(".well").find(".or").each(function(){
					if ($(this).next().hasClass("or") == true) {
						console.log("there are two ORs in a row")
						$(this).next().remove();
					}
				});
				
			}
			function populateDropdowns(context) {
			}

			getNewAttr("segment", "were in");
			getNewGroup();

						
			$(".well").find(".match-dropdown").html(matchDropdown);
			$(".well").find(".dimension-dropdown").html(segmentDropdown);

			$(".well").on("click", ".attribute-add-dropdown .attr-dropdown li", function(){
				var newClass = $(this).attr("class");
				if (newClass == "segment") {
					matchDropdown = segmentMatchDropdown;
					dimensionDropdown = segmentDropdown;
					newAttr = getNewAttr("segment", "were in");
				} else if (newClass == "action"){
					matchDropdown = actionMatchDropdown;
					dimensionDropdown = actionDropdown;
					newAttr = getNewAttr("action", "did");
				} else if (newClass == "attr") {
					matchDropdown = attrMatchDropdown;
					dimensionDropdown = attrDropdown;
					newAttr = getNewAttr("attribute", "had");
				} else if (newClass == "expression") {
					matchDropdown = expressionMatchDropdown;
					dimensionDropdown = expressionDropdown;
					newAttr = getNewAttr("expression", "matched");
				} else if (newClass == "lifecycle") {
					matchDropdown = lifecycleMatchDropdown;
					dimensionDropdown = lifecycleDropdown;
					newAttr = getNewAttr("lifecycle stage", "were in");
				} else if (newClass == "buycycle") {
					console.log("newClass = buycycle");
					matchDropdown = buycycleMatchDropdown;
					dimensionDropdown = buycycleDropdown;
					newAttr = getNewAttr("buying cycle stage", "were in");
				}

				$("<span class='and'>AND</span>" + newAttr).insertBefore($(this).parent().parent());
				$(this).parent().prev(".only").removeClass("only");
//				if ($(this).parent().parent().parent().children(".attribute").length == 1) {
//					console.log($(this).parent().parent().prev());
//					$(this).parent().parent().prev().append('<span class="attribute-delete">x</span>');
//				}
				if ($(this).parent().prev().text() == "Add a filter"){
					$(this).parent().prev().text("+ AND");
					$(".well").find(".group-add-dropdown").removeClass("hidden");
				}
				removeCruft();

			});
			$(".well").on("click", ".group-add-dropdown .attr-dropdown li", function(){
				var newClass = $(this).attr("class");
				if (newClass == "segment") {
					matchDropdown = segmentMatchDropdown;
					dimensionDropdown = segmentDropdown;
					newAttr = getNewAttr("segment", "were in");
				} else if (newClass == "action"){
					matchDropdown = actionMatchDropdown;
					dimensionDropdown = actionDropdown;
					newAttr = getNewAttr("action", "did");
				} else if (newClass == "attr") {
					matchDropdown = attrMatchDropdown;
					dimensionDropdown = attrDropdown;
					newAttr = getNewAttr("a	ttribute", "had");
				} else if (newClass == "expression") {
					matchDropdown = expressionMatchDropdown;
					dimensionDropdown = expressionDropdown;
					newAttr = getNewAttr("expression", "match");
				} else if (newClass == "lifecycle") {
					matchDropdown = lifecycleMatchDropdown;
					dimensionDropdown = lifecycleDropdown;
					newAttr = getNewAttr("lifecycle stage", "were in");
				} else if (newClass == "buycycle") {
					matchDropdown = buycycleMatchDropdown;
					dimensionDropdown = buycycleDropdown;
					newAttr = getNewAttr("buying cycle stage", "were in");
				}
				newGroup = getNewGroup();
				parent = $(this).parent().parent();
				$(newGroup).insertBefore(parent);
				removeCruft();
//				$(this).parent().first(".and").addClass("hidden");
			});
			$(".well").on("click", ".attribute-delete", function(){
				$(this).parent().prev().remove();
				$(this).parent().remove();
				if ($(".well").find(".attribute").length == 0) {
					$(".attribute-add").text("Add a filter").addClass("only");
					$(".group-add-dropdown").addClass("hidden");
				}
				removeCruft();
			});
			$(".well").on("click", ".group-delete", function(){
				// remove the OR
				$(this).parent().next().not(".group-add-dropdown").remove();
//				if ($(this).parent().prev().hasClass("sentence-start") == true) {
//					$(this).parent().next().remove();					
//				}
				$(this).parent().remove();
				removeCruft();	

			});

			// Make the dropdowns actually change the sentence.
			$(".well").on("click", ".attribute .dropdown-menu li", function(){
				var text = $(this).text();
				$(this).parent().siblings().not(".attribute-add").text(text);
				if ( $(this).parent().hasClass("match-dropdown") ) {
					var currentClass = $(this).parent().attr("class");
					var newClass = $(this).attr("class");
					var dimUL = $(this).parent().parent().parent().siblings(".dimension");
					if (newClass !== currentClass) {
						if (newClass == "segment") {
							dimUL.html(segmentDropdown);
						} else if (newClass == "action") {
							dimUL.html(actionDropdown);
						} else if (newClass == "attr") {
							dimUL.html(attrDropdown);
						} else if (newClass == "expression") {
							dimUL.html(expressionDropdown);
						}
					}
				}
			});



});




