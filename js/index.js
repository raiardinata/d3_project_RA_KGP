// import { select, json, scaleOrdinal, forceSimulation, forceManyBody, forceLink, forceCenter, forceX, forceY } from 'd3';

var width = $("[id='viz']").width();
var height = $("[id='viz']").height();
var color = d3.scaleOrdinal(d3.schemeTableau10);
var base_url = window.location.origin;

function generate_simulation() {
    const mtcd = $('[id=\'inputMaterialcode\']').val();
    const batc = $('[id=\'inputBatch\']').val();

    //generate json file
    jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { mtcd: mtcd, batc: batc }, async: false, success: function (data) { result = data; } }); return result; } });
    reqResult = $.getValues(base_url + '/KGP_Test/d3_prototype/php/test.php');
    var graph = JSON.parse(reqResult);
    debugger;
    
    var label = {
        'nodes': [],
        'links': []
    };

    graph.nodes.forEach(function (d, i) {
        label.nodes.push({ node: d });
        label.nodes.push({ node: d });
        label.links.push({
            source: i * 2,
            target: i * 2 + 1
        });
    });

    var labelLayout = d3.forceSimulation(label.nodes)
        .force("charge", d3.forceManyBody().strength(-50))
        // .force("x", d3.forceX(250))
        .force("y", d3.forceY(250))
        .force("link", d3.forceLink(label.links).distance(2).strength(2));

    var graphLayout = d3.forceSimulation(graph.nodes)
        .force("charge", d3.forceManyBody().strength(-2000).distanceMax(1000).distanceMin(80))
        .force("center", d3.forceCenter(width / 2, height / 2))
        // .force("x", d3.forceX(width / 2))
        .force("y", d3.forceY(height / 2))
        .force("link", d3.forceLink(graph.links).id(function (d) { return d.id; }).distance(50).strength(1))
        .on("tick", ticked);

    var adjlist = [];

    graph.links.forEach(function (d) {
        adjlist[d.source.index + "-" + d.target.index] = true;
        adjlist[d.target.index + "-" + d.source.index] = true;
    });

    function neigh(a, b) {
        return a == b || adjlist[a + "-" + b];
    }

    var svg = d3.select("#viz").attr("width", width).attr("height", height);
    var container = svg.append("g").attr('id', 'forceSimulationG');

    svg.call(
        d3.zoom()
            .scaleExtent([.1, 4])
            .on("zoom", function () { container.attr("transform", d3.event.transform); })
    );

    var link = container.append("g").attr("class", "links")
        .selectAll("line")
        .data(graph.links)
        .enter()
        .append("line")
        .attr("stroke", "#aaa")
        .attr("stroke-width", "3px");

    var node = container.append("g").attr("class", "nodes")
        .selectAll("g")
        .data(graph.nodes)
        .enter()
        .append("circle")
        .attr("r", 20)
        .attr("fill", function (d) { return color(d.group); })

    node.on("mouseover", focus).on("mouseout", unfocus);

    node.call(
        d3.drag()
            .on("start", dragstarted)
            .on("drag", dragged)
            .on("end", dragended)
    );

    var labelNode = container.append("g").attr("class", "labelNodes")
        .selectAll("text")
        .data(label.nodes)
        .enter()
        .append("text")
        .text(function (d, i) { return i % 2 == 0 ? "" : d.node.description + ' (' + d.node.material + ')'; })
        .style("fill", "#555")
        .style("font-family", "Arial")
        .style("font-size", 12)
        .style("pointer-events", "none"); // to prevent mouseover/drag capture

    node.on("mouseover", focus).on("mouseout", unfocus).on('click', click);

    function ticked() {

        node.call(updateNode);
        link.call(updateLink);

        labelLayout.alphaTarget(0.3).restart();
        labelNode.each(function (d, i) {
            if (i % 2 == 0) {
                d.x = d.node.x;
                d.y = d.node.y;
            } else {
                var b = this.getBBox();

                var diffX = d.x - d.node.x;
                var diffY = d.y - d.node.y;

                var dist = Math.sqrt(diffX * diffX + diffY * diffY);

                var shiftX = b.width * (diffX - dist) / (dist * 2);
                shiftX = Math.max(-b.width, Math.min(0, shiftX));
                var shiftY = 16;
                this.setAttribute("transform", "translate(" + shiftX + "," + shiftY + ")");
            }
        });
        labelNode.call(updateNode);

    }

    function fixna(x) {
        if (isFinite(x)) return x;
        return 0;
    }

    function focus(d) {
        var index = d3.select(d3.event.target).datum().index;
        node.style("opacity", function (o) {
            return neigh(index, o.index) ? 1 : 0.1;
        });
        labelNode.attr("display", function (o) {
            return neigh(index, o.node.index) ? "block" : "none";
        });
        link.style("opacity", function (o) {
            return o.source.index == index || o.target.index == index ? 1 : 0.1;
        });
    }

    function click(d) {
        highlight = '#Step_'+d.group;
        window.location.href = '#Step_'+d.group;
    }

    function unfocus() {
        labelNode.attr("display", "block");
        node.style("opacity", 1);
        link.style("opacity", 1);
    }

    function updateLink(link) {
        link.attr("x1", function (d) { return fixna(d.source.x); })
            .attr("y1", function (d) { return fixna(d.source.y); })
            .attr("x2", function (d) { return fixna(d.target.x); })
            .attr("y2", function (d) { return fixna(d.target.y); });
    }

    function updateNode(node) {
        node.attr("transform", function (d) {
            return "translate(" + fixna(d.x) + "," + fixna(d.y) + ")";
        });
    }

    function dragstarted(d) {
        d3.event.sourceEvent.stopPropagation();
        if (!d3.event.active) graphLayout.alphaTarget(0.3).restart();
        d.fx = d.x;
        d.fy = d.y;
    }

    function dragged(d) {
        d.fx = d3.event.x;
        d.fy = d3.event.y;
    }

    function dragended(d) {
        if (!d3.event.active) graphLayout.alphaTarget(0);
        d.fx = null;
        d.fy = null;
    }
}

function generateDynamicTable(graphTable, Step_ID) {

    $('[id=\'' + Step_ID + '\']').remove();
    
    var graphLength = graphTable.length;
    var br = document.createElement('br');
    var h4 = document.createElement('H4');
    h4.setAttribute('id', Step_ID);
    h4.setAttribute('style', 'color:'+ color(Step_ID.substring(5)) +';');//color(d.group)


    if (graphLength > 0) {


        // CREATE DYNAMIC TABLE.
        var table = document.createElement("table");
        table.style.width = '50%';
        table.setAttribute('border', '1');
        table.setAttribute('cellspacing', '0');
        table.setAttribute('cellpadding', '5');
        table.setAttribute('id', Step_ID);

        // retrieve column header ('Name', 'Email', and 'Mobile')

        var col = []; // define an empty array
        for (var i = 0; i < graphLength; i++) {
            for (var key in graphTable[i]) {
                if (col.indexOf(key) === -1) {
                    col.push(key);
                }
            }
        }

        // CREATE TABLE HEAD .
        var tHead = document.createElement("thead");
        tHead.setAttribute('style', 'background-color: '+ color(Step_ID.substring(5)) +'; color: white;');


        // CREATE ROW FOR TABLE HEAD .
        var hRow = document.createElement("tr");

        // ADD COLUMN HEADER TO ROW OF TABLE HEAD.
        for (var i = 0; i < col.length; i++) {
            var th = document.createElement("th");
            th.innerHTML = col[i];
            hRow.appendChild(th);
        }
        tHead.appendChild(hRow);
        table.appendChild(tHead);

        // CREATE TABLE BODY .
        var tBody = document.createElement("tbody");

        // ADD COLUMN HEADER TO ROW OF TABLE HEAD.
        for (var i = 0; i < graphLength; i++) {

            var bRow = document.createElement("tr"); // CREATE ROW FOR EACH RECORD .


            for (var j = 0; j < col.length; j++) {
                var td = document.createElement("td");
                td.innerHTML = graphTable[i][col[j]];
                bRow.appendChild(td);
            }
            tBody.appendChild(bRow)

        }
        table.appendChild(tBody);


        // FINALLY ADD THE NEWLY CREATED TABLE WITH JSON DATA TO A CONTAINER.
        var divContainer = document.getElementById("detailTable");
        // divContainer.innerHTML = Step_ID;
        divContainer.appendChild(br);
        divContainer.appendChild(h4);
        divContainer.appendChild(table);
        $('[id=\'' + Step_ID + '\']H4').text(Step_ID.replace(/_/g, ' '));

    }
}

$('[id=\'btnSearch\']').on('click', function () {
    $('[id=\'forceSimulationG\']').remove();
    generate_simulation();

    const mtcd = $('[id=\'inputMaterialcode\']').val();
    const batc = $('[id=\'inputBatch\']').val();
    jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { mtcd: mtcd, batc: batc }, async: false, success: function (data) { result = data; } }); return result; } });
    var graphRess = $.getValues(base_url + '/KGP_Test/d3_prototype/php/generate_table.php');
    var graphTable = JSON.parse(graphRess);
    function generateArray100(array) {
        return array['Step_ID'] == 100;
    }
    function generateArray200(array) {
        return array['Step_ID'] == 200;
    }
    function generateArray300(array) {
        return array['Step_ID'] == 300;
    }
    function generateArray400(array) {
        return array['Step_ID'] == 400;
    }
    var Step100 = graphTable.filter(generateArray100);
    generateDynamicTable(Step100, 'Step_100');
    var Step200 = graphTable.filter(generateArray200);
    generateDynamicTable(Step200, 'Step_200');
    var Step300 = graphTable.filter(generateArray300);
    generateDynamicTable(Step300, 'Step_300');
    var Step400 = graphTable.filter(generateArray400);
    generateDynamicTable(Step400, 'Step_400');
});