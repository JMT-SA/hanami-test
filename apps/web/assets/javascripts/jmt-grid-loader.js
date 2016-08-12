(function() {
  var loadGrid;

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
    var grid, gridOptions, grids, _i, _len, _results;
    grids = document.querySelectorAll('[data-grid]');
    _results = [];
    for (_i = 0, _len = grids.length; _i < _len; _i++) {
      grid = grids[_i];
      gridOptions = {
        columnDefs: null,
        rowDefs: null,
        enableColResize: true,
        enableSorting: true,
        enableFilter: true,
        suppressScrollLag: true,
        //suppressCopyRowsToClipboard: true
        //quickFilterText: 'fred'
      };
      new agGrid.Grid(grid, gridOptions);
      _results.push(loadGrid(grid, gridOptions));
    }
    return _results;
  });

}).call(this);
