<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <style>
        .links {
            stroke: rgba(0,0,0,0.4);
        }

        .toggle {
            position: relative;
            display: inline-block;
            width: 100px;
            height: 30px;
        }

        .toggle input {display:none;}

        .slider {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #db7f67;
            -webkit-transition: 100ms;
            transition: 100ms;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 5px;
            bottom: 5px;
            background-color: white;
            -webkit-transition: 100ms;
            transition: 100ms;
        }

        input:checked + .slider {
            background-color: #1b998b;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(70px);
            -ms-transform: translateX(70px);
            transform: translateX(70px);
        }


    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col" style="text-align: right">group</div>
        <div class="col" style="text-align: center">
            <label class="toggle">
                <input type="checkbox" id="clusterProp">
                <span class="slider"></span>
            </label>
        </div>
        <div class="col">radius</div>
    </div>
</div>
<div id="clusterBox">
</div>
<script src="https://d3js.org/d3.v5.min.js"></script>
<script>
    var w = 800;
    var h = 500;
    var numNodes = 200;
    var numGroups = 10;
    var maxNodeSize = 10;
    var intra = 2;
    var inter = 15;
    var svg = d3.select('#clusterBox')
                .append('svg')
                .attr('width', w)
                .attr('height', h);

    function getData() {
        var nodes = d3.range(numNodes).map(d3.randomUniform(0, numGroups)).map(function (n, i) {
            return {
                group:  Math.floor(n),
                radius: Math.ceil(Math.random() * maxNodeSize),
                x:      Math.random(),
                y:      Math.random(),
                id:     i + 1
            }
        });

        var groups = d3.map(nodes, (d) => d.group).keys();

        var colours = d3.quantize(d3.interpolateRainbow, groups.length + 1).slice(0, -1);
        var colourScale = d3.scaleOrdinal(colours).domain(groups);

        nodes.map((d) => {
            d.colour = colourScale(d.group);
            return d;
        });

        return nodes
    }

    function drawNodes(nodes) {
        var shapes = svg.append('g')
                        .attr('class', 'nodes')
                        .selectAll('circle')
                        .data(nodes)
                        .enter().append('circle')
                        .style('fill', (d) => d.data.data.colour)
                        .attr('r', (d) => d.data.data.radius)
                        .attr('cx', (d) => {
                            return d.x;
                        })
                        .attr('cy', (d) => d.y);

        return shapes
    }


    function getClusters(nodes, prop) {
        var c = d3.nest()
                  .key((d) => d[prop])
                  .rollup((v) => v.sort((a, b) => a.radius - b.radius).slice(-1)[0])
                  .entries(nodes);
        var x = {};
        c.forEach(function (d) {
            x[d.key] = d.value;
        });
        return x;
    }

    function moveLink(link) {
        link.attr('x1', (d) => d.source.x)
            .attr('y1', (d) => d.source.y)
            .attr('x2', (d) => d.target.x)
            .attr('y2', (d) => d.target.y);
    }

    function moveCircle(circle) {
        circle.attr('cx', function (d) {
            return (d.x =
                Math.max(d.data.data.radius, Math.min(w - d.data.data.radius, d.x)));
        })
              .attr('cy', function (d) {
                  return (d.y =
                      Math.max(d.data.data.radius, Math.min(h - d.data.data.radius, d.y)));
              })
    }

    function clusterNodes(nodeData, prop) {
        var nodes = nodeData.slice();
        var clusterCenters = getClusters(nodes, prop);

        nodes.push({
                       group:  null,
                       radius: null,
                       x:      null,
                       y:      null,
                       id:     0
                   });

        nodes = nodes.map((d) => {
            if (d.id === 0) {
                d.parent = undefined;
            }
            else {
                var cc = clusterCenters[d[prop]].id;
                if (cc === d.id) {
                    d.parent = 0;
                }
                else {
                    d.parent = cc;
                }
            }
            return d;
        });

        var pack = d3.pack()
                     .size([w, h])
                     .padding(inter);

        var root = d3.hierarchy(d3.stratify()
                                  .parentId((d) => d.parent)(nodes))
                     .sum((d) => d.data.radius)
                     .sort((a, b) => a.data.radius - b.data.radius);

        pack(root);

        voronoi = d3.voronoi()
            .x((d) => d.x)
            .y((d) => d.y);

        root.children.map(function (g) {
            g.groupNodes = g.children === undefined ? [g] : [g].concat(g.children);
            g.links = svg.append('g')
                         .attr('class', 'links')
                         .selectAll('line')
                         .data(voronoi.links(g.groupNodes))
                         .enter().append('line')
                         .call(moveLink);

            g.redraw = function () {
                var diagram = voronoi(g.groupNodes);
                g.links = g.links.data(diagram.links());
                g.links.exit().remove();
                g.links = g.links.enter().append('line').merge(g.links).call(moveLink);
            };

            return g;
        });

        var shapes = drawNodes(root.descendants());

        var force = d3.forceSimulation()
                      .force('x', d3.forceX(w / 2).strength(0.1))
                      .force('y', d3.forceY(h / 2).strength(0.1))
                      .force('collision', d3.forceCollide((d) => d.data.data.radius + intra))
                      .force('cluster', (alpha) => {
                          root.descendants().forEach(function (d) {
                              if (d.parent == null || d.parent.index === 0) {
                                  return
                              }
                              var cluster = d.parent;
                              d.vx -= ((d.x + d.data.data.radius) - (cluster.x + cluster.data.data.radius)) * alpha;
                              d.vy -= ((d.y + d.data.data.radius) - (cluster.y + cluster.data.data.radius)) * alpha;
                          });
                      })
                      .on('tick', () => {
                          root.children.forEach(function (g) {
                              g.redraw()
                          });
                          shapes.call(moveCircle);
                      })
                      .nodes(root.descendants());

        shapes.call(d3.drag()
                      .on("start", function (d) {
                          {
                              if (!d3.event.active) {
                                  force.alphaTarget(0.1).restart();
                              }
                              // move cluster centre
                              if (d.parent == null) {
                                  return
                              }
                              var cc = d.parent.index === 0 ? d : d.parent;
                              cc.fx = d.x;
                              cc.fy = d.y;
                          }
                      })
                      .on("drag", function (d) {
                          if (d.parent == null) {
                              return
                          }
                          var cc = d.parent.index === 0 ? d : d.parent;
                          cc.fx = d3.event.x;
                          cc.fy = d3.event.y;
                      })
                      .on("end", function (d) {
                          if (!d3.event.active) {
                              force.alphaTarget(0);
                          }
                          if (d.parent == null) {
                              return
                          }
                          var cc = d.parent.index === 0 ? d : d.parent;
                          cc.fx = null;
                          cc.fy = null;
                      }));
    }

    var nodeData = getData();

    var btn = d3.select('#clusterProp');
    btn.on('change', function () {
        var prop = btn.property('checked') ? 'radius' : 'group';
        svg.selectAll('*').remove();
        clusterNodes(nodeData, prop)
    });

</script>
</body>