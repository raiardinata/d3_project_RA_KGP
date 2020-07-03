import { select, json, scaleOrdinal, forceSimulation, forceManyBody, forceLink, forceCenter, forceX, forceY } from 'd3';

var width = $("[id='viz']").width();
var height = $("[id='viz']").height();
var color = scaleOrdinal(d3.schemeTableau10);
var graph, labelLayout, graphLayout, svg, graphChildren, parent;

var label = {
    'nodes': [],
    'links': []
};

// Define the div for the tooltip
var div = select("body").append("div")
    .attr("class", "tooltip")
    .style("opacity", 0);

json("../php/generate_json.php").then(function (json) {
    graph = json;

    graph.nodes.forEach(function (d, i) {
        if (d.children) {

        }
        label.nodes.push({ node: d });
        label.nodes.push({ node: d });
        label.links.push({
            source: i * 2,
            target: i * 2 + 1
        });
    });

    labelLayout = forceSimulation(label.nodes)
        .force("charge", forceManyBody().strength(-50))
        //.force("y", forceY((height / 2) - 15).strength(1))
        .force("link", forceLink(label.links).distance(0).strength(2));

    graphLayout = forceSimulation(graph.nodes)
        .force("charge", forceManyBody().strength(-3000))
        .force("center", forceCenter(width / 2, height / 2))
        //.force("x", forceX(width / 2).strength(1))
        .force("y", forceY(height / 2).strength(1))
        .force("link", forceLink(graph.links).id(function (d) { return d.id; }).distance(50).strength(1));

    update();
});

function update() {

    graphLayout.on("tick", ticked);

    var adjlist = [];

    graph.links.forEach(function (d) {
        adjlist[d.source.index + "-" + d.target.index] = true;
        adjlist[d.target.index + "-" + d.source.index] = true;
    });

    function neigh(a, b) {
        return a == b || adjlist[a + "-" + b];
    }


    svg = d3.select("#viz");
    var container = svg.append("g").attr("id", "simulationG");

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
        .attr("stroke-width", "5px");

    var node = container.append("g")
        .attr("class", "nodes")
        .selectAll("g")
        .data(graph.nodes)
        .enter()
        .append("circle")
        .attr("r", 10)
        .attr("fill", function (d) { return color(d.group); })

    //node.on("mouseover", focus).on("mouseout", unfocus);

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
        .text(function (d, i) { return i % 2 == 0 ? "" : d.node.id; })
        .style("fill", "#555")
        .style("font-family", "Arial")
        .style("font-size", 12)
        .style("pointer-events", "none"); // to prevent mouseover/drag capture

    node.on("mouseover", function (d) {
        focus(d);
        div.transition()
            .duration(200)
            .style("opacity", .9);
        div.html(`Process Name : ${d.id}\nDetail : ${d.detail}`)
            .style("left", (d3.event.pageX + 28) + "px")
            .style("top", (d3.event.pageY - 28) + "px");
    })
        .on("mouseout", unfocus)
        .on("click", click);

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

    function unfocus() {
        labelNode.attr("display", "block");
        node.style("opacity", 1);
        link.style("opacity", 1);
        div.transition()
            .duration(500)
            .style("opacity", 0);
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

} // end function update

function click() {
    console.log(`Inside update function labellayout value : ${labelLayout} and graphlayout value : ${graphLayout}`);
    //document.getElementById("simulationG").remove();

    //update();
}