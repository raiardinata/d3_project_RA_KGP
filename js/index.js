var width = $("[id='viz']").width();
var height = $("[id='viz']").height();
var color = d3.scaleOrdinal(d3.schemeTableau10);
var base_url = window.location.origin;
var tableArray = [];

function generate_simulation() {
    const mtcd = $('[id=\'inputMaterialcode\']').val();
    const batc = $('[id=\'inputBatch\']').val();
    tableArray = [];

    //generate linear json file
    jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { mtcd: mtcd, batc: batc }, async: false, success: function (data) { result = data; } }); return result; } });
    reqResult = $.getValues(base_url + '/KGP_Test/d3_prototype/php/generate_json.php');
    var graph = JSON.parse(reqResult);
    debugger;
    if(typeof(graph) == 'undefined' || graph == null) {
        alert('There is no data feedback with Material Code ' + mtcd + ' and Batch ' + batc + '');
        $('[class=\'dt-buttons\']').remove();
        $('[class=\'dataTables_wrapper dt-bootstrap4 no-footer\']').remove();
        return false;
    }
    
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

    //generate full json file
    jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { mtcd: mtcd, batc: batc }, async: false, success: function (data) { result = data; } }); return result; } });
    reqFullResult = $.getValues(base_url + '/KGP_Test/d3_prototype/php/generate_json_ori.php');
    var graphFull = JSON.parse(reqFullResult);
    if(!graphFull) {
        alert('There is no data feedback with Material Code ' + mtcd + ' and Batch ' + batc + '');
        return false;
    }
    graphFull.nodes.forEach(function (d, i) {
        tableArray.push( d );
    });

    // A scale that gives a X target position for each group
    var x = d3.scaleOrdinal()
        .domain([1, 2, 3, 4, 5])
        .range([50, 340, 640, 940, 1240]);

    var labelLayout = d3.forceSimulation(label.nodes)
        .force("charge", d3.forceManyBody().strength(-1000))
        .force('collision', d3.forceCollide().radius(function(d) {
            return 80
          }))
        .force("x", d3.forceX(250))
        .force("y", d3.forceY(0))
        .force("link", d3.forceLink(label.links).distance(2).strength(2));

    var graphLayout = d3.forceSimulation(graph.nodes)
        .force("charge", d3.forceManyBody().strength(-2000).distanceMax(-2000).distanceMin(-80))
        .force("center", d3.forceCenter(width / 2, height / 2))
        .force('collision', d3.forceCollide().radius(function(d) {
            return 20
          }))
        .force("x", d3.forceX().strength(0.5).x( function(d){ return x(d.group) } ))
        .force("y", d3.forceY(height / 2))
        .force("link", d3.forceLink(graph.links).id(function (d) { return d.id; }).distance(200).strength(1))
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
        .attr("id", function(d,i) { return i % 2 == 0 ? "" : "txt" + d.node.id} )
        .text(function (d, i) {
            if(d.node.description != "Produksi") {
                return i % 2 == 0 ? "" : d.node.description ; 
            }
            else {
                return i % 2 == 0 ? "" : d.node.description + ' \n(' + d.node.key + ')'
            }
        })
        .style("fill", "#555")
        .style("font-family", "Arial")
        .style("font-size", '1rem')
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
            return neigh(index, o.index) ? 1 : 0.3;
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

    //bind mstr prd info
    jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { mtcd: mtcd }, async: false, success: function (data) { result = data; } }); return result; } });
    var prdInfoRess = $.getValues(base_url + '/KGP_Test/d3_prototype/php/get_mstr_prd_info.php');
    prdInfoRess = JSON.parse(prdInfoRess);
    $('#lblMtcd').html( function() {
        if(prdInfoRess.description != null) {
            return prdInfoRess.description;
        }
        else {
            return prdInfoRess.materialCode;
        }
    });
    $('#lblDesc').html( function() {
        if(prdInfoRess.additionalInfo != null) {
            return prdInfoRess.additionalInfo;
        }
    });
    $('#imageColumn').prepend($('<img>',{id: 'image',src: prdInfoRess.imageData, style: 'border-radius: 50%; max-width: 70px;' }));
}

function generateDynamicTable(rawArray, Step_ID) {
    
    var graphTable = [];
    $('[id=\'' + Step_ID + '\']').remove();
    $('[id=\'' + Step_ID + '_wrapper\']').remove();

    rawArray.forEach(element => {
        jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { id : element['id'], Step_ID : element['group'], Alias : false }, async: false, success: function (data) { result = data; } }); return result; } });
        var graphRess = $.getValues(base_url + '/KGP_Test/d3_prototype/php/generate_table.php');
        graphRess = JSON.parse(graphRess);
        for(var i in graphRess.row_array) {
            graphTable.push(graphRess.row_array[i]);
        }
    });
    var graphLength = graphTable.length;
    var h4 = document.createElement('H4');
    h4.setAttribute('id', Step_ID);
    h4.setAttribute('style', 'color:'+ color(Step_ID.substring(5)) +'; display: inline; float: left;');//color(d.group)


    if (graphLength > 0) {


        // CREATE DYNAMIC TABLE.
        var table = document.createElement("table")
        table.setAttribute('width', 'auto');
        table.setAttribute('max-width', '400%');
        table.setAttribute('border', '1');
        table.setAttribute('cellspacing', '0');
        table.setAttribute('cellpadding', '5');
        table.setAttribute('white-space', 'nowrap;');
        table.setAttribute('class', 'display');
        table.setAttribute('id', Step_ID);

        // retrieve column header ('Name', 'Email', and 'Mobile')
        var colUser = []; // define user header
        var col = []; // define original field header
        var step = Step_ID.substring(5);
        jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { id : '', Step_ID : step, Alias : true }, async: false, success: function (data) { result = data; } }); return result; } });
        var aliasRess = $.getValues(base_url + '/KGP_Test/d3_prototype/php/generate_table.php');
        aliasRess = JSON.parse(aliasRess);
        for(var i in aliasRess.alias_array) {
            colUser.push(aliasRess.alias_array[i]);
        }

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
        for (var i = 0; i < colUser.length; i++) {
            var th = document.createElement("th");
            th.innerHTML = colUser[i];
            th.setAttribute('style', 'white-space: nowrap;');
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
                td.setAttribute('style', 'white-space: nowrap;');
                bRow.appendChild(td);
            }
            tBody.appendChild(bRow)

        }
        table.appendChild(tBody);


        // FINALLY ADD THE NEWLY CREATED TABLE WITH JSON DATA TO A CONTAINER.
        var divContainer = document.getElementById("font");
        divContainer.appendChild(table);

        function getHeaderNames(table) {
            // Gets header names.
            //params:
            //  table: table ID.
            //Returns:
            //  Array of column header names.

            var header = $(table).DataTable().columns().header().toArray();

            var names = [];
            header.forEach(function(th) {
                names.push($(th).html());
            });
                
            return names;
        }

        function buildCols(data) {
            // Builds cols XML.
            //To do: deifne widths for each column.
            //Params:
            //  data: row data.
            //Returns:
            //  String of XML formatted column widths.

            var cols = '<cols>';

            for (i=0; i<data.length; i++) {
                colNum = i + 1;
                cols += '<col min="' + colNum + '" max="' + colNum + '" width="20" customWidth="1"/>';
            }

            cols += '</cols>';

            return cols;
        }

        function buildRow(data, rowNum, styleNum) {
            // Builds row XML.
            //Params:
            //  data: Row data.
            //  rowNum: Excel row number.
            //  styleNum: style number or empty string for no style.
            //Returns:
            //  String of XML formatted row.

            var style = styleNum ? ' s="' + styleNum + '"' : '';

            var row = '<row r="' + rowNum + '">';

            for (i=0; i<data.length; i++) {
                colNum = (i + 10).toString(36).toUpperCase();  // Convert to alpha
                
                var cr = colNum + rowNum;
                
                row += '<c t="inlineStr" r="' + cr + '"' + style + '>' +
                        '<is>' +
                        '<t>' + data[i] + '</t>' +
                        '</is>' +
                    '</c>';
            }
                
            row += '</row>';
                
            return row;
        }

        function getTableData(table, title) {
            // Processes Datatable row data to build sheet.
            //Params:
            //  table: table ID.
            //  title: Title displayed at top of SS or empty str for no title.
            //Returns:
            //  String of XML formatted worksheet.

            var header = getHeaderNames(table);
            var table = $(table).DataTable();
            var rowNum = 1;
            var mergeCells = '';
            var ws = '';

            ws += buildCols(header);
            ws += '<sheetData>';

            if (title.length > 0) {
                ws += buildRow([title], rowNum, 51);
                rowNum++;
                
                mergeCol = ((header.length - 1) + 10).toString(36).toUpperCase();
                
                mergeCells = '<mergeCells count="1">'+
                '<mergeCell ref="A1:' + mergeCol + '1"/>' +
                            '</mergeCells>';
            }
                                
            ws += buildRow(header, rowNum, 2);
            rowNum++;

            // Loop through each row to append to sheet.    
            table.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
                var data = this.data();
                
                // If data is object based then it needs to be converted 
                // to an array before sending to buildRow()
                ws += buildRow(data, rowNum, '');
                
                rowNum++;
            } );

            ws += '</sheetData>' + mergeCells;
                
            return ws;

        }

        function setSheetName(xlsx, name) {
            // Changes tab title for sheet.
            //Params:
            //  xlsx: xlxs worksheet object.
            //  name: name for sheet.

            if (name.length > 0) {
                var source = xlsx.xl['workbook.xml'].getElementsByTagName('sheet')[0];
                source.setAttribute('name', name);
            }
        }

        function addSheet(xlsx, table, title, name, sheetId) {
            //Clones sheet from Sheet1 to build new sheet.
            //Params:
            //  xlsx: xlsx object.
            //  table: table ID.
            //  title: Title for top row or blank if no title.
            //  name: Name of new sheet.
            //  sheetId: string containing sheetId for new sheet.
            //Returns:
            //  Updated sheet object.

            //Add sheet2 to [Content_Types].xml => <Types>
            //============================================
            var source = xlsx['[Content_Types].xml'].getElementsByTagName('Override')[1];
            var clone = source.cloneNode(true);
            clone.setAttribute('PartName','/xl/worksheets/sheet' + sheetId + '.xml');
            xlsx['[Content_Types].xml'].getElementsByTagName('Types')[0].appendChild(clone);

            //Add sheet relationship to xl/_rels/workbook.xml.rels => Relationships
            //=====================================================================
            var source = xlsx.xl._rels['workbook.xml.rels'].getElementsByTagName('Relationship')[0];
            var clone = source.cloneNode(true);
            clone.setAttribute('Id','rId'+sheetId+1);
            clone.setAttribute('Target','worksheets/sheet' + sheetId + '.xml');
            xlsx.xl._rels['workbook.xml.rels'].getElementsByTagName('Relationships')[0].appendChild(clone);

            //Add second sheet to xl/workbook.xml => <workbook><sheets>
            //=========================================================
            var source = xlsx.xl['workbook.xml'].getElementsByTagName('sheet')[0];
            var clone = source.cloneNode(true);
            clone.setAttribute('name', name);
            clone.setAttribute('sheetId', sheetId);
            clone.setAttribute('r:id','rId'+sheetId+1);
            xlsx.xl['workbook.xml'].getElementsByTagName('sheets')[0].appendChild(clone);

            //Add sheet2.xml to xl/worksheets
            //===============================
            var newSheet = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'+
                '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac" mc:Ignorable="x14ac">'+
                getTableData(table, title) +
                
                '</worksheet>';

            xlsx.xl.worksheets['sheet' + sheetId + '.xml'] = $.parseXML(newSheet);

        }

        var table = $('[class=\'display\']').DataTable({
            dom: '<f<t>ip><l>'
        });
        
        var d = new Date();

        var month = d.getMonth()+1;
        var day = d.getDate();

        var output = d.getFullYear() +
            (month<10 ? '0' : '') + month +
            (day<10 ? '0' : '') + day;
        $('#excelButton').parent().remove();
        var buttons = new $.fn.dataTable.Buttons(table, {
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: 'Export to Excel',
                    attr: { id: 'excelButton' },
                    title: function() {
                        return 'TraceabilitySystem_'+$('#inputMaterialcode').val()+'_'+$('#inputBatch').val()+'_'+output;
                    },
                    customize: function( xlsx ) {
                        setSheetName(xlsx, 'Inbound');
                        var i = 1;
                        $('#detailTable table').each(function(){ 
                            i++;
                            switch(i) {
                                case 2:
                                    addSheet(
                                        xlsx,
                                        '#Step_200.display',
                                        'TraceabilitySystem_'+$('#inputMaterialcode').val()+'_'+$('#inputBatch').val()+'_'+output,
                                        'Transfer',
                                        '2'
                                    );
                                    break;
                                case 3:
                                    addSheet(
                                        xlsx, 
                                        '#Step_300.display', 
                                        'TraceabilitySystem_'+$('#inputMaterialcode').val()+'_'+$('#inputBatch').val()+'_'+output,
                                        'Production', 
                                        '3');
                                  break;
                                case 4:
                                    addSheet(
                                        xlsx, 
                                        '#Step_350.display', 
                                        'TraceabilitySystem_'+$('#inputMaterialcode').val()+'_'+$('#inputBatch').val()+'_'+output,
                                        'Transfer FG', 
                                        '4');
                                  break;
                                case 5:
                                    addSheet(
                                        xlsx, 
                                        '#Step_400.display', 
                                        'TraceabilitySystem_'+$('#inputMaterialcode').val()+'_'+$('#inputBatch').val()+'_'+output,
                                        'Outbound', 
                                        '5');
                                  break;
                            }
                         });
                    }
                }
            ]
        }).container().appendTo($('#button'));

        $('[id=\'' + Step_ID + '_info\']').attr('style', 'display: inline');
        $('[id=\'' + Step_ID + '_paginate\']').attr('style', 'display: inline-flex; float: right;');
        var tableFilter = document.getElementById(Step_ID + '_filter');
        tableFilter.appendChild(h4);
        $('[id=\'' + Step_ID + '\']H4').text(rawArray[0]['description']);
        $('[id=\'' + Step_ID + '_wrapper\']').css('padding-top', '20px');
    }
}

function generateTableQuery(mtcd, batc, step) {
    jQuery.extend({ getValues: function (url) { var result = null; $.ajax({ url: url, type: 'post', dataType: 'text', data: { mtcd: mtcd, batc: batc, step: step }, async: false, success: function (data) { result = data; } }); return result; } });
    var graphRess = $.getValues(base_url + '/KGP_Test/d3_prototype/php/generate_table.php');
    return graphTable = JSON.parse(graphRess);
}

$('[id=\'btnSearch\']').on('click', function () {
    //remove unnecessary things
    $('[id=\'forceSimulationG\']').remove();
    $('#lblMtcd').html( '' );
    $('#lblDesc').html( '' );
    $('#image').remove();

    //generate d3 force
    generate_simulation();

    // generate table info
    function generateArray100(array) {
        return array['group'] == 100;
    }
    function generateArray200(array) {
        return array['group'] == 200;
    }
    function generateArray300(array) {
        return array['group'] == 300;
    }
    function generateArray350(array) {
        return array['group'] == 350;
    }
    function generateArray400(array) {
        return array['group'] == 400;
    }
    var Step200 = tableArray.filter(generateArray200);
    generateDynamicTable(Step200, 'Step_200');
    var Step300 = tableArray.filter(generateArray300);
    generateDynamicTable(Step300, 'Step_300');
    var Step350 = tableArray.filter(generateArray350);
    generateDynamicTable(Step350, 'Step_350');
    var Step400 = tableArray.filter(generateArray400);
    generateDynamicTable(Step400, 'Step_400');
    var Step100 = tableArray.filter(generateArray100);
    generateDynamicTable(Step100, 'Step_100');
    $("#Step_100_wrapper").prependTo("#font");
});