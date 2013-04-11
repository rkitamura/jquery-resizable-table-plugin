(($) ->

  $.fn.simpleResizableTable = ->

    resetTableSizes = (table, change, columnIndex) ->
      # calculate new width;
      tableId = table.attr("id")
      myWidth = $("#" + tableId + " TR TH").get(columnIndex).offsetWidth
      newWidth = (myWidth + change) + "px"
      $("#" + tableId + " TR").each ->
        $(this).find("TD").eq(columnIndex).css "width", newWidth
        $(this).find("TH").eq(columnIndex).css "width", newWidth
      resetSliderPositions table

    resetSliderPositions = (table) ->
      tableId = table.attr("id")
      # put all sliders on the correct position
      table.find(" TR:first TH").each (index) ->
        td = $(this)
        newSliderPosition = td.offset().left + td.outerWidth()
        $("#" + tableId + "_id" + (index + 1)).css
          left: newSliderPosition
          height: table.height() + "px"

    makeResizable = (table) ->
      # get number of columns
      numberOfColumns = table.find("TR:first TH").size()
      # id is needed to create id's for the draghandles
      tableId = table.attr("id")
      i = 0
      while i <= numberOfColumns
        handle = $("<div class='srt-draghandle' id='#{tableId}_id#{i}'></div>")
        handle.insertBefore(table).data("tableid", tableId).data("myindex", i)
        handle.draggable
          axis: 'x'
          start: ->
            tableId = ($(this).data("tableid"))
            $(this).toggleClass "dragged"
            # set the height of the draghandle to the
            # current height of the table, to get the vertical ruler
            $(this).css height: $("#" + tableId).height() + "px"
          stop: (event, ui) ->
            tableId = ($(this).data("tableid"))
            $(this).toggleClass "dragged"
            oldPos = ($(this).data("draggable").originalPosition.left)
            newPos = ui.position.left
            index = $(this).data("myindex")
            resetTableSizes $("#" + tableId), newPos - oldPos, index - 1
        i++
      resetSliderPositions table
      table

    $("""
      <style type='text/css'>
        .srt-draghandle.dragged {
          border-left: 1px solid #333;
        }
      </style>
    """).appendTo 'head'

    $("""
      <style type='text/css'>
        .srt-draghandle {
          position: absolute;
          z-index:5;
          width:5px;
          cursor:e-resize;
        }
      </style>
    """).appendTo 'head'

    @each ->
      makeResizable $(this)

) jQuery
