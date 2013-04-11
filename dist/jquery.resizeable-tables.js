(function($) {
  return $.fn.simpleResizableTable = function() {
    var makeResizable, resetSliderPositions, resetTableSizes;

    resetTableSizes = function(table, change, columnIndex) {
      var myWidth, newWidth, tableId;

      tableId = table.attr("id");
      myWidth = $("#" + tableId + " TR TH").get(columnIndex).offsetWidth;
      newWidth = (myWidth + change) + "px";
      $("#" + tableId + " TR").each(function() {
        $(this).find("TD").eq(columnIndex).css("width", newWidth);
        return $(this).find("TH").eq(columnIndex).css("width", newWidth);
      });
      return resetSliderPositions(table);
    };
    resetSliderPositions = function(table) {
      var tableId;

      tableId = table.attr("id");
      return table.find(" TR:first TH").each(function(index) {
        var newSliderPosition, td;

        td = $(this);
        newSliderPosition = td.offset().left + td.outerWidth();
        return $("#" + tableId + "_id" + (index + 1)).css({
          left: newSliderPosition,
          height: table.height() + "px"
        });
      });
    };
    makeResizable = function(table) {
      var handle, i, numberOfColumns, tableId;

      numberOfColumns = table.find("TR:first TH").size();
      tableId = table.attr("id");
      i = 0;
      while (i <= numberOfColumns) {
        handle = $("<div class='srt-draghandle' id='" + tableId + "_id" + i + "'></div>");
        handle.insertBefore(table).data("tableid", tableId).data("myindex", i);
        handle.draggable({
          axis: 'x',
          start: function() {
            tableId = $(this).data("tableid");
            $(this).toggleClass("dragged");
            return $(this).css({
              height: $("#" + tableId).height() + "px"
            });
          },
          stop: function(event, ui) {
            var index, newPos, oldPos;

            tableId = $(this).data("tableid");
            $(this).toggleClass("dragged");
            oldPos = ($(this).data("draggable").originalPosition.left);
            newPos = ui.position.left;
            index = $(this).data("myindex");
            return resetTableSizes($("#" + tableId), newPos - oldPos, index - 1);
          }
        });
        i++;
      }
      resetSliderPositions(table);
      return table;
    };
    $("<style type='text/css'>\n  .srt-draghandle.dragged {\n    border-left: 1px solid #333;\n  }\n</style>").appendTo('head');
    $("<style type='text/css'>\n  .srt-draghandle {\n    position: absolute;\n    z-index:5;\n    width:5px;\n    cursor:e-resize;\n  }\n</style>").appendTo('head');
    return this.each(function() {
      return makeResizable($(this));
    });
  };
})(jQuery);
