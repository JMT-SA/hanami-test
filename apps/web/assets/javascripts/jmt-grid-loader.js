// AG Grid enterprise license:
agGrid.LicenseManager.setLicenseKey("J&J_Multi-Tier_Kromco_Packhouse_Solution_1Devs_15_August_2017__MTUwMjc1MTYwMDAwMA==6d25bb000cc39a1b1b5692e0e64952b9");

// Object to keep track of the grids in a page - so they can be looked up by div id.
var jmtGridStore = {

  gridStore: {},

  addGrid: function(gridId, gridOptions) {
    this.gridStore[gridId] = gridOptions;
  },

  getGrid: function(gridId) {
    return this.gridStore[gridId];
  },

  removeGrid(gridId) {
    this.gridStore[gridId].api.destroy();
    delete this.gridStore[gridId];
  },

  listGridIds: function() {
    var grid_id, lst = [];
    for(grid_id in this.gridStore) {
      lst.push(grid_id);
    }
    return lst.join(', ');
  }

};

var jmtGridEvents = {

  csvExport: function(grid_id, file_name) {
    var gridOptions,

    params = {
      fileName: file_name
      // skipHeader: true,
      // skipFooters: true,
      // skipGroups: true,
      // allColumns: true,
      // suppressQuotes: true,
      // onlySelected: true,
      // columnSeparator: ';'
    };

    // Ensure long numbers are exported as strings.
    params.processCellCallback = function(params) {
      var testStr;
      // If HTML entities are a problem...
      // params.value.replace(/&amp;/g, "&").replace(/\\&quot;/g, "\"").replace(/&quot;/g, "\"").replace(/&gt;/g, ">").replace(/&#x2F;/g, "/").replace(/&lt;/g, "<");

      if (params.value) {
        testStr = ''+params.value;
        if (testStr.length > 12 && !isNaN(testStr) && !testStr.includes('.')) {
          return "'"+testStr;
        }
        else {
          return params.value;
        }
      }
      else {
        return params.value;
      }
    };

    gridOptions = jmtGridStore.getGrid(grid_id);
    gridOptions.api.exportDataAsCsv(params);
  },

  toggleToolPanel: function(grid_id) {
    var gridOptions, isShowing;
    gridOptions = jmtGridStore.getGrid(grid_id);
    isShowing = gridOptions.api.isToolPanelShowing();
    gridOptions.api.showToolPanel( !isShowing );
  },

  printAGrid: function(grid_id, grid_url) {
     var disp_setting =  "toolbar=yes,location=no,directories=yes,menubar=yes,";
         //disp_setting += "scrollbars=yes,width=650, height=600, left=100, top=25";
    window.open("/print_grid?grid_url="+encodeURIComponent(grid_url), "printGrid", disp_setting);
  },

  quickSearch: function(event) {
    var gridOptions;
    // clear on Esc
    if (event.which == 27) {
      event.target.value = "";
    }
    gridOptions = jmtGridStore.getGrid(event.target.dataset.gridId);
    gridOptions.api.setQuickFilter(event.target.value);
  },

  // setFilterChangeEvent: function(grid_id) {
  //   var gridOptions;
  //
  //   gridOptions = jmtGridStore.getGrid(grid_id);
  //   gridOptions.api.afterFilterChanged();
  //   //.api.rowModel.rootNode.childrenAfterFilter.length
  //
  // }
  showFilterChange: function(grid_id) {
    var gridOptions, filterLength;
    gridOptions = jmtGridStore.getGrid(grid_id);
    if(gridOptions.api.rowModel.rootNode.childrenAfterFilter) {
      filterLength = gridOptions.api.rowModel.rootNode.childrenAfterFilter.length;
    }
    else {
      filterLength = 0;
    }
    console.log('onAfterFilterChanged', filterLength, grid_id);
  }

};

(function() {
  var loadGrid;
  var onBtExport;

  loadGrid = function(grid, gridOptions) {
    var httpRequest, url;
    url = grid.getAttribute('data-gridurl');
    httpRequest = new XMLHttpRequest();
    httpRequest.open('GET', url);
    httpRequest.send();
    return httpRequest.onreadystatechange = function() {
      var httpResult;
      if (httpRequest.readyState === 4 && httpRequest.status === 200) {
        httpResult = JSON.parse(httpRequest.responseText);
        gridOptions.api.setColumnDefs(httpResult.columnDefs);
        return gridOptions.api.setRowData(httpResult.rowDefs);
      }
    };
  };

  document.addEventListener("DOMContentLoaded", function() {
    var grid, gridOptions, grids, _i, _len, _results, grid_id;
    grids = document.querySelectorAll('[data-grid]');
    _results = [];
    for (_i = 0, _len = grids.length; _i < _len; _i++) {
      grid = grids[_i];
      grid_id = grid.getAttribute('id');
      for_print = grid.dataset.gridPrint;
      // lookup of grid ids? populate here and clear when grid unloaded...
      gridOptions = {
        columnDefs: null,
        rowDefs: null,
        enableColResize: true,
        enableSorting: true,
        enableFilter: true,
        suppressScrollLag: true,
        enableRangeSelection: true,
        enableStatusBar: true,
        suppressAggFuncInHeader: true,
        // onAfterFilterChanged: function() {console.log('onAfterFilterChanged', this.api.rowModel.rootNode.childrenAfterFilter.length, grid_id);}
        // onAfterFilterChanged: jmtGridEvents.showFilterChange(grid_id)
        //suppressCopyRowsToClipboard: true
        //quickFilterText: 'fred'
      };
      if(for_print) {
        gridOptions.forPrint        = true;
        gridOptions.enableStatusBar = false;
      }

      new agGrid.Grid(grid, gridOptions);
      jmtGridStore.addGrid(grid_id, gridOptions);
      gridOptions.onAfterFilterChanged = jmtGridEvents.showFilterChange(grid_id);
      _results.push(loadGrid(grid, gridOptions));
    }
    return _results;
  });

}).call(this);
