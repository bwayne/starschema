//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){
	documentWidth = document.body.clientWidth;
	$(".content").width(documentWidth - 220);
	data = jQuery.parseJSON(gon.goal_affinity);
	
	var tip = d3.tip()
		.attr("class", "d3-tip")
		.html(function(d){ return "<strong>"+ d.name + "</strong>: " + d.size + " customers"; });
	
	var allSizes = []
	var allAffins = []

	data.forEach(function(d1){
		d1.children.forEach(function(d2){
			d2.children.forEach(function(d_3){
               allSizes.push(d_3.size);
               allAffins.push(d_3.affinity);
            });
		});
	});
	var minSize = d3.min(allSizes);
	var maxSize = d3.max(allSizes);
	var minAffin = d3.min(allAffins);
	var maxAffin = d3.max(allAffins);
	
	var margin = { top: 30, left: 0, bottom: 0, right: 0 }
	var width  = $(".main").width();
	var circlesWidth = width * 0.7;
	var idealWidth = width * 0.25
	var circlesTransform = width - circlesWidth;
	
	var height = {
		  row:					50,
		  dimGroupName: 		30,
		  dimGroupMargin:		90,
	      lifecycleLabel:    	35,
	      sizes:             	25,
	      avgTimes:          	40,
	      buyingCycleStages: 	120,
	      margintop: 		 	20,
	      marginbottom:		 	20
	}
	var colors = ["#12A7E0", "#FFB599", "#ff4600", "#2C3E50"]
	
    var lifecycleStages   = ['No Purchase', '1 Purchase', 'Repeat', 'Loyal']
    var buyingCycleStages = ['at_risk', 'recent_buyers', 'awareness', 'interest', 'considering', 'intent']
	var radiusScale = d3.scale.linear().domain([minSize,maxSize]).range([0,25])
	var dimXscale = d3.scale.linear().domain([minAffin,maxAffin]).range([0,width-50]);
	var colorScale = d3.scale.linear().domain([minAffin,maxAffin]).range([0,1]);

	var dimGroupLength = [0]
	data.forEach(function(d,i){
		dimGroupLength.push(d.children.length + dimGroupLength[i])
	});

	
	var svg = d3.select("#dimension-chart").append("svg")
		.attr("width", width)
		.attr("height", 2000)
		.call(tip)
		.on("click", tip.hide);
		
	var dimGroupContainers = svg.selectAll(".dimGroupContainer")
		.data(data)
		.enter()
		.append("g")
			.attr("class", "dimGroupContainer")
			.attr("id", function(d){ return d.id })
			.attr("width", width)
			.attr("height", function(d,i){
				return "translate(0,"+ ((height.row * dimGroupLength[i]) + (height.dimGroupMargin * i)) + ")";
			})
			.attr("transform", function(d,i){ 
				return "translate(0,"+ ((height.row * dimGroupLength[i]) + (height.dimGroupMargin * i)) + ")";
			});
			
	var idealBoxes = dimGroupContainers.append("rect")
		.attr("class", "ideal-box")
		.attr("width", idealWidth)
		.attr("transform", function(){
			return "translate("+ (width - idealWidth) +","+ height.dimGroupName +")";
		})
		.attr("height", function(d){ 
			return height.row * d.children.length
		});
		
	var dimGroupName = dimGroupContainers.append("text")
				.text(function(d,i){
					return d.name;
				})
				.attr("class", "dimGroupName")
				.attr("transform", function(){ return "translate(0,15)"; });

	var rowGroups = dimGroupContainers.append("g")
		.attr("class", "rowGroup")
		.attr("transform", function(){
			return "translate(0,"+ height.dimGroupName +")";
		});

	var row = rowGroups.selectAll(".dimension-row")
		.data(function(d){
			return d.children;
		}).enter()
		.append("g")
			.attr("class", "dimension-row")
			.attr("id", function(d){ return d.id })
			.attr("width", width)
			.attr("transform", function(d,i){
				return "translate(0,"+ (height.row * i) +")";
			})
	
	var rowBG = row.append("rect")
		.attr("class", "rowBG")
		.attr("width", function(){ return width + 2 })
		.attr("height", height.row)
		.attr("transform", "translate(-1,0)")
		.style("fill", function(d,i){
			if (i % 2 == 0) { return "#f6f6f6"}
			else {return "none"}
		})
		.attr("fill-opacity", 0.3);
		
	var dimName = row.append("text")
		.text(function(d,i){
			return d.name;
		})
		.attr("class", "dimension-name")
		.attr("transform", "translate(20,30)")
	
	var circleGroup = row.append("g")
		.attr("class", "circle-group")
		.attr("width", function(d,i){
			return width * 0.7;
		})
		.attr("height", height.row)
		.attr("transform", "translate(150, 0)");
//		.attr("transform", function(){
//			return "translate(" + circlesTransform + ",0)";
//		});

	circleGroup.selectAll(".circle")
		.data(function(d,i){
			return d.children;
		})
		.enter()
		.append("circle")
			.attr("class", "circle row-circle")
			.attr("r", function(d){ return radiusScale(d.size) })
			.attr("transform", function(d,i){
				var x = dimXscale(d.affinity);
				return "translate("+ x +",25)";
			})
			.style("fill", "#3973ac")
			.attr("fill-opacity", function(d){
				return colorScale(d.affinity);
			})
			.on("mouseover", tip.show)
			.on("mouseout", tip.hide);
/*
			.attr("cx", function(d,i){
				return (circlesWidth / 2) + dimXscale(d.affinity);
			})
			.attr("cy", 25);
*/
	var indivRows = row.selectAll(".indiv-row")
		.data(function(d,i){
			children = d.children.sort(function(a,b){ return d3.descending(a.affinity, b.affinity); })
//			console.log(d.children);
			return children;
		}).enter()
		.append("g")
			.attr("class", "indiv-row hidden")
			.attr("transform", function(d,i){
				return "translate(20,"+ (80 + (height.row * i)) + ")";
			});
			
	var separators = indivRows.append("line")
		.attr("class", "indivRowSeparator")
		.attr("x1", 0)
		.attr("x2", 4000)
		.attr("y1", 0)
		.attr("y2", 0)
		.attr("transform", "translate(0, -30)")
		.style("stroke", "#ddd")

	var indivRowName = indivRows.append("text")
		.text(function(d){ return d.name })
		.attr("fill", "#777")
		.attr("transform", function(d,i){
			var x = dimXscale(d.affinity);
			var circleSize = radiusScale(d.size);
			svgWidth = $("svg").width();
			distanceRight = svgWidth - (x + circleSize);
			if ((d.name.length * 10) > distanceRight) {
				console.log(this.clientWidth);
				return "translate("+ (x - (this.clientWidth + circleSize + 5)) +")";
			} else {
				return "translate("+ (x + circleSize + 5) +")";
				
			}
		});			
	
	var indivCircles = indivRows.append("circle")
		.attr("class", "circle indiv-circle")
		.attr("r", function(d){ return radiusScale(d.size) })
		.attr("transform", function(d,i){
			var x = dimXscale(d.affinity);
			return "translate("+ x +", -5)";
		})
		.style("fill", "#3973ac")
		.attr("fill-opacity", function(d){
			return colorScale(d.affinity);
		})
		.on("mouseover", tip.show);
//		.on("mouseout", tip.hide);
		

	var accordionCarat = row.append("polygon")
		.attr("points", "10,18 17,25 10,32")
		.attr("transform", "translate(0,0)")
		.style("fill", "#999")
		.on("click", function(d,i){ 
			var x = this;
			expandRows(d,i,x) } );
		
//	g[1].transform.baseVal[0].matrix.f

function expandRows(d,i,x) {
	thisRow = d3.select(x.parentNode);
	thisGroup = d3.select(x.parentNode.parentNode.parentNode);
	dimensionRows = d3.selectAll(".dimension-row");
	dimensionGroups = d3.selectAll(".dimGroupContainer");
	index = dimensionRows[0].indexOf(thisRow[0][0]);
	groupIndex = dimensionGroups[0].indexOf(thisGroup[0][0]);
	var parent = $(x).parent();
	indivRows = parent.find(".indiv-row");
	var showSize = indivRows.length;
	var rowsHeight = showSize * height.row;
	var idealBox = parent.parent().parent().find(".ideal-box");
	var idealBoxHeight = parseInt(idealBox.attr("height"));
	var svgHeight = parseInt($("svg").attr("height"));
	var rowBackground = parent.find(".rowBG");
	var rowCircles = parent.find(".row-circle");

	if (parent.attr("class") == "dimension-row open") {
		$(x).attr("transform", "translate(0,0)"); // rotate the carat
		parent.attr("class", "dimension-row"); // remove "open" class from parent
//				$(indivRows).addClass("hidden");
		indivRows.attr("class", "indiv-row hidden"); // hide the individual rows
		rowCircles.attr("class", "circle row-circle") // remove "hidden" class from row-circles
		parent.parent().children().each(function(i, d){
			if (i > parent.index()){
				currentY = this.transform.baseVal[0].matrix.f;
				$(this).attr("transform", "translate(0,"+(currentY - rowsHeight)+")");
			}
		});
		parent.parent().parent().siblings().each(function(i){
			index = parent.parent().parent().index();
			if (i > (index-1)) {
				currentY = this.transform.baseVal[0].matrix.f;
				$(this).attr("transform", "translate(0,"+ (currentY - rowsHeight)+")");
			}
		});
		idealBox.attr("height", function(){ return idealBoxHeight - rowsHeight; });
		rowBackground.attr("height", height.row);
		$("svg").attr("height", function(){ return svgHeight - rowsHeight });
	} else {
		parent.attr("class", "dimension-row open");
		$(x).attr("transform", "translate(10) rotate(90,7,18)");
		idealBox.attr("height", function(){ return idealBoxHeight + rowsHeight; });
		rowBackground.attr("height", function() { return height.row + rowsHeight; });
		rowCircles.attr("class", "circle row-circle hidden");
		$("svg").attr("height", function(){ return svgHeight + rowsHeight; });
		var id, thisID, parentID, thisParentID;
		dimensionRows[0].forEach(function(selectedRow, i){
			if (i == index) {
				id = selectedRow.id
				parentID = $("#"+id).parent().parent().attr("id");
				indivRows = thisRow.selectAll(".indiv-row")
				indivRows.attr("class", "indiv-row");
				showSize = indivRows[0].length;
			} else if (i > index) {
				thisID = selectedRow.id
				thisParentID = $("#"+thisID).parent().parent().attr("id");
				if (parentID == thisParentID) {
					currentY = document.getElementById(thisID).transform.baseVal[0].matrix.f
					d3.select("#"+thisID).attr("transform", function(d){ return "translate(0," + (currentY + (height.row * showSize)) + ")"});					
				}
			}
		});
		dimensionGroups[0].forEach(function(group, i){
			if (i > groupIndex) {
				groupID = group.id
				currentY = document.getElementById(groupID).transform.baseVal[0].matrix.f
				d3.select("#"+groupID).attr("transform", function(d){ return "translate(0," + (currentY + (height.row * showSize)) + ")"});
				newTransform = d3.select("#"+groupID).attr("transform");
			}
		});
	}
}



	documentHeight = document.body.clientHeight;
	$(".menu").height(documentHeight);

		
	
});
